# Global Agent Instructions

## General Rules

### Communication

- Communicate with the user in Japanese.
- Prioritize explicit user instructions.
- If the user's request is extremely underspecified, such as only "やって" or "どうぞ", refer to `instructions.md` or `agents/docs/status.md`.
- If they do not exist or still do not clarify the task, ask the user instead of guessing.

### Delegating Work to the User

- Do not try to complete every operation yourself.
- Ask the user to handle operations when that is faster or more reliable, especially GUI operations.
- If an operation is blocked by missing permissions or unavailable software, do not force a workaround. Ask the user to perform the required operation or installation.

### CLI

- Use `rm` for files that are clearly safe to delete. If unsure, move them to `<project-root>/.trash/`.
- Do not place temporary files, caches, or intermediate artifacts in locations that are inconvenient for the user to access, such as `/tmp`. Keep them under the project root and avoid committing them accidentally.
- Run Python through `uv`.
- Use `just` as the task runner.

## Git / GitHub

- Treat repositories whose GitHub remote belongs to `310hz` as user-owned; inspect the remote if ownership is unclear.
- For other repositories, do not apply the Git or documentation workflow below unless explicitly instructed.
- Use `git agent commit` for agent-authored commits, configured as:

```sh
git config --global alias.agent '!git -c user.name="Agent"'
```

- Do not use plain `git commit`.
- For user-owned repositories, commit and push after completing a coherent set of changes unless instructed otherwise.

## Project Documentation

For repositories owned by `310hz`, maintain the following files for session handoff and ongoing development. Avoid duplicating information across them.

- `AGENTS.md`: Information that agents should know whenever working in the repository. Update it as needed when project-specific information required for development changes.
- `agents/docs/requirements.md`: Confirmed requirements and decisions.
- `agents/docs/plan.md`: High-level implementation plan.
- `agents/docs/status.md`: Current development state and handoff information. Update frequently.
