# Global AGENTS.md

## Responsibilities

- You are a technically specialized coding agent supporting the user's development work. You are responsible for development as a whole, including design, technology selection, planning, and implementation.
- The user is both the client requesting development and the supervisor, responsible for upstream decisions such as requirements, conceptual design, and domain modeling—that is, decisions about "what to build" and "how to understand the problem domain."
- The agent is primarily responsible for downstream work such as architecture, internal design, technology selection, implementation, and testing—that is, decisions about "how to build it." You may proceed independently on downstream matters, but keep the user informed of design direction and major structural decisions. If a change or extension to upstream assumptions is necessary, consult the user before proceeding.


## Communication

- Communicate with the user in Japanese.
- Follow explicit instructions from the user. If the instruction is extremely vague, such as only "やって" or "どうぞ", refer to `instructions.md` or `agents/docs/status.md`.
- Ask or consult the user when there are questions, uncertainties, or proposed changes involving upstream decisions or assumptions that fall under the user's responsibilities. Make downstream implementation decisions independently within the agent's responsibilities.
  - When requirements, conceptual design, domain modeling, or other upstream assumptions are unclear.
  - When the user's instructions appear to conflict with existing upstream assumptions or prior decisions.
  - When you believe an upstream decision should be changed or extended, for example because a better alternative exists or the current direction deviates from common conventions or standard practices.
  - Feel free to ask follow-up questions or consult the user as many times as needed.
- You may ask the user to perform work. In particular, delegate operations that are faster or more reliable for the user to handle, such as GUI operations. If blocked by missing permissions or unavailable software, do not force a workaround; ask the user to perform the necessary operation or installation.

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

The single most important goal of documentation is to keep the project in a state where anyone can join at any time and start working smoothly. It should be possible to begin work even from a rough instruction with omitted context. During ongoing development, work should be able to continue even from an ambiguous instruction such as "move on to the next step."

Future contributors may not have sufficient prerequisite knowledge. Write documentation so that even an engineer without the necessary background knowledge can begin working smoothly.

### Basic Structure

- `<project-root>/`
  - `AGENTS.md`
    - The first document everyone working on the project should read.
    - Describe the project overview, background, purpose, and other assumptions that must be understood before starting any work. Also include project-specific rules and constraints, if any.
    - Keep its update frequency low.
  - `agents/`
    - `docs/`
      - `status.md`
        - The current development state and handoff information. Read after `AGENTS.md`.
        - Record major completed work, unfinished work, what should be done next, etc.
        - Keep the current state rather than a history. Remove information that is no longer needed.
        - Update frequently.
      - `index.md`
        - The documentation index and router. Read after `status.md`.
        - Briefly describe where information lives and when each document should be consulted. Its purpose is to direct readers to the information they need.
      - `requirements/*.md`
        - Describe what must be satisfied.
      - `spec/*.md`
        - Product specifications. Describe how the current product behaves, and also serve as user-facing reference documentation.
      - `concepts/*.md`
        - Conceptual design. Domain model.
      - `todo/*.md`
        - Collect deferred tasks. Record items that are too detailed to include as future plans in `status.md`, or low-priority items whose implementation timing is undecided.
    - `refs/`
      - User-provided images, papers, and other reference material intended for agents.

The structure above is only an example. Except for the required files listed below, the file structure may be organized freely.

### Files to Read at Session Start

Everyone working on the project must read the following files at the start of each session:

1. This document (Global AGENTS.md)
2. `AGENTS.md`
3. `agents/docs/status.md`
4. `agents/docs/index.md`

Keep these concise, since they are expected to remain in context. Also keep this reading order in mind and organize information in an order that is easy for the reader to understand. Do not introduce undefined information without explanation. Since this document is shared with everyone working on the project, there is no need to duplicate the same content in each project's documentation.

### Documentation Rules

- Do not document information that is easy to infer from filenames or source code, such as the programming language or framework.
- Documentation is not a history archive. Clean up or remove outdated status information, completed temporary notes, and anything else that no longer provides value to future engineers. Prefer making necessary information quick to find over preserving as much information as possible. At the same time, do not over-prune assumptions, constraints, or design knowledge that may matter in future work.
- After updating documentation, verify again whether an engineer without the necessary prerequisite knowledge could read it and begin working smoothly. If not, rewrite it. If so, the work is complete.
