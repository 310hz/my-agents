# Global Agent Instructions

## General Rules

### Communication

- Communicate with the user in Japanese.
- Prioritize explicit user instructions.
- If the user's request is extremely underspecified, such as only "やって" or "どうぞ", refer to the project's `instruction.md`.
- If `instruction.md` does not exist or still does not clarify the task, ask the user instead of guessing.

### Delegating Work to the User

- Do not try to complete every operation yourself.
- Ask the user to handle operations when that is faster or more reliable, especially GUI operations.
- If an operation is blocked by missing permissions or unavailable software, do not force a workaround. Ask the user to perform the required operation or installation.

### CLI

- Use `rm` freely for files that are clearly safe to delete. If unsure, move them to `<project-root>/.trash/`. Treat `.trash/` as ignored by Git.
- Do not place temporary files, caches, or intermediate artifacts in locations that are inconvenient for the user to access, such as `/tmp`. Keep them under the project root and avoid committing them accidentally.
- Run Python through `uv`.

## Git / GitHub

The user's GitHub account is `310hz`.

### Repository Ownership

- Treat repositories whose GitHub remote belongs to `310hz` as user-owned.
- If ownership is unclear, inspect the remote.
- For repositories not owned by `310hz`, do not apply the Git workflow or documentation workflow below unless explicitly instructed.

### Commits

The following Git alias is configured for agent-authored commits:

```sh
git config --global alias.agent '!git -c user.name="Agent" -c user.email="agent@local"'
```

- Use `git agent commit` for all agent-authored commits.
- Do not use plain `git commit`.
- For repositories owned by `310hz`, unless instructed otherwise, commit and push once a coherent set of changes is complete so the work is preserved on the remote.

## Project Documentation

For repositories owned by `310hz`, maintain the following files for session handoff. Avoid duplicating information across them.

- `AGENTS.md`: Stable project context, major technologies, implementation rules, and high-level structure. Do not use it for file-level details or progress tracking.
- `agents/docs/requirements.md`: Confirmed requirements, constraints, and conceptual design. Updated infrequently.
- `agents/docs/plan.md`: High-level implementation plan.
- `agents/docs/status.md`: Current progress, next steps, blockers, and handoff notes. Update frequently.
