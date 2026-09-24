---
name: onboarding
description: Use only when explicitly requested by the user; never apply automatically. Prepare a repository for development by resolving important upfront decisions and establishing the documentation needed to start or resume work smoothly.
---

# Onboarding

The goal is to resolve important prerequisites before implementation and establish enough project context that development can begin or continue smoothly without requiring the user to repeat known information.

## Review Existing Context

Before asking the user any questions, inspect the repository, `instructions.md`, `AGENTS.md`, and existing files under `agents/docs/`.

Treat the documentation policy and operating rules in `AGENTS.md` as authoritative. Do not redefine them here unless a point is especially important to this skill.

Treat existing confirmed requirements, concepts, and decisions as established unless they conflict with newer user instructions.

Do not ask the user for information that can be determined reliably from the repository or existing documentation.

## Resolve Upfront Decisions

Identify unresolved matters that should be settled before implementation begins.

Do not design everything upfront. Prioritize only decisions that would likely cause substantial rework, migration, or redesign if deferred.

When clarification is necessary, ask the minimum necessary questions together. Matters that can be decided later at low cost may remain unresolved.

Record confirmed information in the appropriate documentation according to the policy in `AGENTS.md`.

## Establish Project Documentation

Review and complete the project documentation according to `AGENTS.md`.

In particular, ensure that:

- The documents required at session start exist and remain concise.
- The current development state and next work are clear.
- Detailed information is separated appropriately and can be discovered through the documentation index.
- Confirmed and unresolved matters are distinguished where relevant.
- Important assumptions, requirements, concepts, and design knowledge needed for future development are not missing.

Do not restructure existing documentation unnecessarily. Add or update only what is needed.

## Completion Criteria

- Important decisions that should be resolved before implementation are settled or clearly identified as unresolved.
- Project documentation satisfies the policy defined in `AGENTS.md`.
- Development can begin or resume without requiring the user to repeat known context.
- The next work and the information required to perform it are clear.
