# App Builder Enablement — Learning Plan

A self-paced path to become an independent App Builder contributor, mirroring the EDS kit's layout.
Unlike the EDS program (which tracked real weekly live sessions), this plan is built from a real
first build — the store-locator backend — so every module is hands-on and grounded, not theoretical.

**Goal:** go from "never touched App Builder" to "I can build, deploy, and call a serverless action."
**Format:** 5 modules, ~2 hours total. Do Module 3 hands-on (deploy something real).

## Roadmap

| # | Module | Focus | Status | Skill file |
|---|--------|-------|--------|-----------|
| 1 | What is App Builder? | Positioning, out-of-process extensibility, why it exists | Ready | [01-what-is-app-builder.md](../01-what-is-app-builder.md) |
| 2 | Architecture | Runtime, actions, State, namespaces, the manifest | Ready | [02-architecture-runtime-actions-state.md](../02-architecture-runtime-actions-state.md) |
| 3 | Setup & Deploy | aio CLI, Developer Console workspaces, login → use → deploy | Ready | [03-setup-and-deploy.md](../03-setup-and-deploy.md) |
| 4 | Building Actions & State | Action anatomy, params, response shape, State data access | Ready | [04-building-actions-and-state.md](../04-building-actions-and-state.md) |
| 5 | Connecting to a Storefront | Calling actions from an EDS block, the CORS fix | Ready | [05-connecting-to-a-storefront.md](../05-connecting-to-a-storefront.md) |

## How to use

- Brand new? Run **`/learn appbuilder`** (no arguments) — it walks the modules in order, checks your
  understanding, and grounds everything in the store-locator build.
- Jump to a topic: `/learn appbuilder deploy`, `/define appbuilder namespace`,
  `/simulate appbuilder the whole build`, `/quiz appbuilder cors`.

## The running example

Every module ties back to one real build: `map-geocode` + `store-locator-search` actions deployed to
`123456-myproject-integration` and called from an EDS storefront block. See
[../simulator-walkthrough.md](../simulator-walkthrough.md) for the full step-by-step with
the exact commands and the five first-time gotchas.

## Self-check milestones

- [ ] Explain out-of-process extensibility to a colleague (Module 1)
- [ ] Read an action URL and name its namespace/package/action (Module 2)
- [ ] `aio login` → `aio app use` → `aio app deploy` a real action (Module 3)
- [ ] Write an action that validates input, calls an API, and reads State (Module 4)
- [ ] Call an action from a browser and resolve a CORS error (Module 5)

## Extend this plan

As you run real App Builder enablement sessions or tackle new topics (Events, API Mesh, App Builder
Database, Admin UI SDK), add modules/weeks here the same way the EDS kit fills in its weeks — capture
real gotchas, not theory.
