---
name: python-versioning
description: Manage Git-tag-driven versioning for uv-based Python libraries using Hatchling, hatch-vcs, and importlib.metadata. Use when configuring, reviewing, migrating, or debugging package versions, and optionally when automating PyPI releases.
---

# Python Versioning

Use Git tags as the single manually maintained version source.

## Rules

* Prefer tags in the form `v<PEP 440 version>`, e.g. `v1.2.3`.
* Do not define a static `[project].version`.
* Do not hard-code `__version__` or use `uv version`.
* Distinguish `[project].name` from the import package name.
* Do not replace an existing versioning system without checking compatibility.

## Configure

For Hatchling projects:

```toml
[build-system]
requires = ["hatchling", "hatch-vcs"]
build-backend = "hatchling.build"

[project]
dynamic = ["version"]

[tool.hatch.version]
source = "vcs"
tag-pattern = "^v(?P<version>.+)$"
```

Preserve existing `dynamic` fields and Hatch build configuration. Run `uv lock` if tracked build requirements change.

Expose the installed version from the package:

```python
from importlib.metadata import PackageNotFoundError, version

try:
    __version__ = version("distribution-name")
except PackageNotFoundError:
    __version__ = "0.0.0"
```

Use the exact `[project].name` as `distribution-name`.

## Validate

* Check that no static version remains in project metadata or source.
* Ensure Git tags and history are available.
* Run the repository's normal checks.
* Run `uv lock --check` when `uv.lock` is tracked.
* Run `uv build` and verify wheel/sdist versions.
* Verify `package.__version__` matches installed distribution metadata.

Commits after a release tag may produce PEP 440 development versions. Do not assume they equal the next release version.

## Publishing

Only configure publishing when explicitly requested.

For GitHub Actions + PyPI:

* trigger on `v*` tags;
* fetch full Git history and tags;
* run checks before `uv build` and `uv publish`;
* prefer PyPI Trusted Publishing with `id-token: write`.

Do not create or push tags, publish packages, or change PyPI settings without explicit authorization. Treat published tags as immutable.
