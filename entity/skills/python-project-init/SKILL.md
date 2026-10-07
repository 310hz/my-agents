---
name: python-project-init
description: Initialize a new Python project with uv, Ruff, ty, and just, using the bundled config templates. Use when creating a new Python project, or when asked to set up linting, formatting, or type checking for a Python project, even if the user does not mention this skill by name.
---

# Python Project Init

Set up a new Python project so that style rules are enforced by tools rather than by documentation. The Ruff config lives in the project's `pyproject.toml` because a user-level Ruff config is only a fallback that any project-level `[tool.ruff]` overrides, so it cannot be relied on.

## Steps

1. Create the project with `uv init`. Add `--lib` for a library. If the project will be published, use `uv init --lib --build-backend hatch` so that it matches the `python-versioning` skill. The build backend does not matter for a project that will not be published.
2. Add the tools: `uv add --dev ruff ty`.
3. Append `assets/pyproject-tools.toml` to `pyproject.toml`. If `[tool.ruff]` already exists, merge the settings instead of duplicating the table.
4. Copy `assets/justfile` to the project root. If a `justfile` already exists, add only the `lint` recipe.
5. Run `just lint` and confirm it passes.

## Additional setup for libraries to be published

A published library needs full docstrings on its public API. Add `"D1"` (missing docstrings on public functions, classes, and modules) and `"D417"` (undocumented arguments) to `select` in `[tool.ruff.lint]`. Projects that will not be published do not need them.

## Related skills

- Follow the `python-coding-rules` skill when writing code. It covers only the rules that Ruff cannot enforce.
- If the project is a library that will be published, also follow the `python-versioning` skill.

## Notes

- ty needs no configuration by default, so the template has no `[tool.ty]` section. Add one only when a project needs it.
- The templates apply only at initialization. Existing projects are not updated automatically.
