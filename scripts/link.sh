#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
ENTITY_DIR="${ROOT}/entity"
MAP_FILE="${ROOT}/map.json"

YES=false
NO=false

for arg in "$@"; do
  case "${arg}" in
    -y) YES=true ;;
    -n) NO=true ;;
  esac
done

if [[ "${YES}" == true && "${NO}" == true ]]; then
  echo "-y and -n cannot be used together" >&2
  exit 1
fi

log() {
  echo "[my-agents link] $*"
}

create_link() {
  local src="$1"
  local dst="$2"
  local target target_abs answer

  if [[ -e "${dst}" || -L "${dst}" ]]; then
    if [[ -L "${dst}" ]]; then
      target="$(readlink "${dst}")"
      [[ "${target}" != /* ]] && target="$(dirname "${dst}")/${target}"
      target_abs="$(cd "$(dirname "${target}")" && pwd -P)/$(basename "${target}")"

      if [[ "${target_abs}" == "${ENTITY_DIR}/"* ]]; then
        trash "${dst}"
        ln -s "${src}" "${dst}"
        log "relinked: ${dst} -> ${src}"
        linked=$((linked + 1))
        return
      fi
    fi

    if [[ "${NO}" == true ]]; then
      log "skip (exists): ${dst}"
      skipped=$((skipped + 1))
      return
    fi

    if [[ "${YES}" != true ]]; then
      printf "overwrite: %s? [y/N] " "${dst}" >/dev/tty
      read -r answer </dev/tty

      if [[ ! "${answer}" =~ ^[yY]$ ]]; then
        log "skip (exists): ${dst}"
        skipped=$((skipped + 1))
        return
      fi
    fi

    trash "${dst}"
  fi

  mkdir -p "$(dirname "${dst}")"
  ln -s "${src}" "${dst}"
  log "linked: ${dst} -> ${src}"
  linked=$((linked + 1))
}

link_path() {
  local src="$1"
  local dst="$2"
  local expand_dir=false
  local src_path dst_path item

  [[ "${src}" == */ ]] && expand_dir=true

  src="${src/#\~/$HOME}"
  dst="${dst/#\~/$HOME}"

  src_path="${src%/}"
  dst_path="${dst%/}"

  [[ "${src_path}" != /* ]] && src_path="${ENTITY_DIR}/${src_path}"
  [[ "${dst_path}" != /* ]] && dst_path="${ENTITY_DIR}/${dst_path}"

  if [[ ! -e "${src_path}" ]]; then
    log "skip (source not found): ${src}"
    skipped=$((skipped + 1))
    return
  fi

  if [[ -d "${src_path}" && "${expand_dir}" == true ]]; then
    mkdir -p "${dst_path}"

    while IFS= read -r -d '' item; do
      create_link "${item}" "${dst_path}/$(basename "${item}")"
    done < <(find "${src_path}" -mindepth 1 -maxdepth 1 -print0)

    return
  fi

  [[ "${dst}" == */ ]] && dst_path="${dst_path}/$(basename "${src_path}")"

  create_link "${src_path}" "${dst_path}"
}

linked=0
skipped=0

while IFS=$'\t' read -r src dst; do
  [[ -n "${src}" ]] && link_path "${src}" "${dst}"
done < <(
  jq -r 'to_entries[] | .key as $src | .value[] | "\($src)\t\(.)"' "${MAP_FILE}"
)

log "done: linked=${linked} skipped=${skipped}"
