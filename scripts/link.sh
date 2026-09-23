#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
ENTITY_DIR="${ROOT}/entity"
MAP_FILE="${ROOT}/map.json"

YES=false
NO=false

for arg in "$@"; do
  case "$arg" in
    -y) YES=true ;;
    -n) NO=true ;;
  esac
done

[[ "$YES" == true && "$NO" == true ]] && {
  echo "-y and -n cannot be used together" >&2
  exit 1
}

linked=0
skipped=0

log() {
  echo "[my-agents link] $*"
}

link_path() {
  local src="$1"
  local dst="$2"
  local answer

  src="${src/#\~/$HOME}"
  dst="${dst/#\~/$HOME}"

  [[ "$src" != /* ]] && src="${ENTITY_DIR}/${src}"

  src="${src%/}"
  dst="${dst%/}"

  if [[ ! -e "$src" ]]; then
    log "skip (source not found): $src"
    skipped=$((skipped + 1))
    return
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ "$NO" == true ]]; then
      log "skip (exists): $dst"
      skipped=$((skipped + 1))
      return
    fi

    if [[ "$YES" != true ]]; then
      printf "overwrite: %s? [y/N] " "$dst" >/dev/tty
      read -r answer </dev/tty

      [[ "$answer" =~ ^[yY]$ ]] || {
        log "skip (exists): $dst"
        skipped=$((skipped + 1))
        return
      }
    fi

    trash "$dst"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"

  log "linked: $dst -> $src"
  linked=$((linked + 1))
}

while IFS=$'\t' read -r src dst; do
  link_path "$src" "$dst"
done < <(
  jq -r '
    to_entries[]
    | .key as $src
    | .value[]
    | "\($src)\t\(.)"
  ' "$MAP_FILE"
)

log "done: linked=$linked skipped=$skipped"
