---
name: project-documentation
description: Rules for writing and updating project documentation for handoff between contributors. Use when creating, updating, reviewing, or deciding whether to modify project documentation under agents/docs/.
---

# Project Documentation

The purpose of documentation is to hand off the assumptions and context needed for future development to future contributors. Documentation does not need to be updated every time work is performed. Update it only when information that should be communicated to future contributors has changed. Note that this documentation is not a work log or diary.

## What to Document

Document the assumptions and rules that contributors should understand before working on the project. Preserve information that cannot be sufficiently inferred from the code alone, such as requirements, conceptual design, domain models, important design assumptions, major ongoing work, and unresolved issues.

## Writing and Update Rules by Document

- `AGENTS.md`
  - Keep its update frequency low.
- `agents/docs/status.md`
  - Record the current state of the project as a whole, major unfinished work, unresolved issues, what should be done next, and similar handoff information.
  - Keep the current state rather than a history. Remove information that is no longer needed.
  - Update it frequently. However, update it to preserve the current state that needs to be handed off, not to record that individual tasks were performed or completed.
- `agents/docs/index.md`
  - Briefly describe where information lives and when each document should be consulted.

## Files to Read at Session Start

The required files defined in Global AGENTS.md as files to read at the start of each session are expected to remain in context, so keep them concise. Also consider this reading order and organize information in an order that is easy for the reader to understand. Do not introduce undefined information without explanation. Since Global AGENTS.md is shared by everyone working on the project, there is no need to duplicate the same content in each project's documentation.

## Documentation Rules

- Do not document information that can be easily inferred from filenames or source code, such as the programming language or framework.
- Documentation is not a history archive. Clean up or remove outdated status information, completed temporary notes, and anything else that no longer provides value to future engineers. Prefer making necessary information quick to find over preserving as much information as possible. At the same time, do not over-prune assumptions, constraints, or design knowledge that may matter in future work.
- After updating documentation, verify again whether an engineer without the necessary prerequisite knowledge could read it and begin working smoothly. If not, rewrite it. If so, the work is complete.
- Do not preserve work-in-progress details, investigation notes, implementation procedures, or local changes solely for handoff when they are only needed by the current contributor. As a rule, work at the granularity of a single Linear issue is handled by one agent.
