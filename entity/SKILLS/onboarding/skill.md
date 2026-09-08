---
name: onboarding
description: Prepare a repository for development by resolving important upfront decisions and creating project documentation for future agent sessions.
---

# Onboarding

Use this skill at the beginning of development.

The goal is to establish the necessary prerequisites before implementation so that subsequent agents can begin development without requiring the user to repeat the same context.

## Review Existing Context

Before asking the user any questions, inspect the repository, `instructions.md`, existing `AGENTS.md`, and files under `agents/docs/`. Treat existing confirmed requirements and decisions as established unless they conflict with newer user instructions.

## Resolve Upfront Decisions

Identify any unresolved decisions that should be made before implementation begins. Do not attempt to design everything upfront; only resolve decisions that would likely require substantial rework, migration, or redesign if changed later. Do not ask the user about matters that can already be determined from existing context or can be decided later at low cost.

When clarification is necessary, ask the minimum necessary questions together. Record confirmed decisions in `agents/docs/requirements.md`. Decisions that do not block development may remain unresolved.

## Project Documentation

Following the Project Documentation policy, create or update:

* `AGENTS.md`
* `agents/docs/requirements.md`
* `agents/docs/plan.md`
* `agents/docs/status.md`

## Completion Criteria

* Important decisions that should be resolved before development are settled.
* Project Documentation reflects the current state.
* Confirmed and unresolved matters are clearly distinguished.
* The next agent can begin development immediately by reading the documentation.
