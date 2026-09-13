# Global Agent Instructions

## Communication

- Communicate with the user in Japanese.
- Prioritize explicit user instructions.
- If the user's request is extremely underspecified, such as only "やって" or "どうぞ", refer to `instructions.md` or `agents/docs/status.md`.
- If they do not exist or still do not clarify the task, ask the user instead of guessing.

## Delegating Work to the User

- Do not try to complete every operation yourself.
- Ask the user to handle operations when that is faster or more reliable, especially GUI operations.
- If an operation is blocked by missing permissions or unavailable software, do not force a workaround. Ask the user to perform the required operation or installation.

## CLI

- Use `rm` for files that are clearly safe to delete. If unsure, move them to `<project-root>/.trash/`.
- Do not place temporary files, caches, or intermediate artifacts in locations that are inconvenient for the user to access, such as `/tmp`. Keep them under the project root and avoid committing them accidentally.
- Run Python through `uv`.
- Use `just` as the task runner.
- Treat `.env` as user-managed: do not open, display, search, edit, or expose its values; reading it indirectly through existing project commands that do not print values is allowed, and use `.env.example` to inspect the configuration schema.

## Git

- Treat repositories whose GitHub remote belongs to `310hz` as user-owned; inspect the remote if ownership is unclear.
- For other repositories, do not apply the Git or documentation workflow below unless explicitly instructed.
- Use the dedicated `git agent commit` alias for agent-authored commits.
- Follow the Conventional Commits specification for commit messages.
- For user-owned repositories, commit and push after completing a coherent set of changes unless instructed otherwise.

## Documents

Write project-related information under `agents/docs/`.

The single most important goal of documentation is to ensure that anyone can join the project at any time and start working smoothly. Keep the project in a state where work can begin even from a rough instruction with omitted context. During ongoing development, it should be possible to continue work even when the only instruction is something like "continue."

Documentation is not only for handing work off to the next person. Preserve information that will remain useful to any engineer who may work on the project in the future. Consider when and why that information may be needed, and keep it easy to reach.

### Basic Structure

- `<project-root>/`
  - `AGENTS.md`
    - The first document everyone working on the project should read.
    - Describe the project's purpose and essential background, along with assumptions, rules, and constraints that must be understood before working on any task.
    - Include only context that is broadly relevant across the project; do not try to cover all project details.
    - Keep its update frequency low.
  - `agents/`
    - `docs/`
      - `status.md`
        - The current development state and handoff information.
        - Record major completed work, unfinished work, what should be done next, known blockers, etc.
        - Keep the current state rather than a history. Remove information that is no longer needed.
        - Update frequently.
      - `index.md`
        - The documentation index and router.
        - Briefly describe where information lives and when each document should be consulted.
        - Use it to direct readers to the information they need.
      - `requirements/*.md`
        - Record currently valid requirements.
        - Split them by feature or concern.
        - Describe what must be satisfied, not how it should be implemented.
      - `concepts.md`
        - The conceptual design.
        - Describe the real-world model, terminology, relationships, and other domain concepts handled by the system.
        - Do not include implementation details.
    - `refs/`
      - User-provided images, papers, and other reference material intended for agents.

The structure above is only a default. Add or split files and directories as needed.

### Documents to Read at Session Start

As a rule, only the following three files must always be read at the start of a session:

- `AGENTS.md`
- `agents/docs/status.md`
- `agents/docs/index.md`

Keep them concise, since they are expected to remain in context. Read other documents only as needed based on `index.md` and the current task.

### Documentation Rules

- Do not document information that is easy to infer from filenames or source code, such as the programming language or framework. Document information that is difficult to recover from code alone or that may serve as an important prerequisite for future work.
- Move detailed information into appropriate documents instead of overloading `AGENTS.md`, `status.md`, or `index.md`.
- Documentation is not a history archive. Clean up or remove outdated status information, completed temporary notes, and anything else that no longer provides value to engineers who may work on the project in the future.
- Prefer making necessary information quick to find over preserving as much information as possible. At the same time, do not over-prune assumptions, constraints, or design knowledge that is likely to matter in future work.
- When updating documentation, verify that the change actually contributes to the goal of allowing anyone to join the project at any time and start working smoothly. Before committing, check that the documentation still follows this goal and these rules.
