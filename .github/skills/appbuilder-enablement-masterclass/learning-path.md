# App Builder Masterclass — Learning Path

The full curriculum, prerequisites, and rough time estimates. Backs `/learn appbuilder`.

## Who this is for

Anyone new to Adobe App Builder — especially developers who need to build serverless backend logic
for Adobe Commerce / Experience Cloud (or a headless storefront) without editing product core code.
No prior serverless or Adobe I/O experience assumed.

## Prerequisites

| # | Prerequisite | Why | Check / get it |
|---|---|---|---|
| 1 | Basic JavaScript / Node.js | Actions are Node.js functions | — |
| 2 | Node.js 18+ (20 recommended) | Runtime + local tooling | `node -v` |
| 3 | The aio CLI | Login, link, deploy | `npm i -g @adobe/aio-cli` |
| 4 | An Adobe org with an App Builder project/workspace | The deploy target | `aio console org list` (or create one at `developer.adobe.com/console`) |
| 5 | Comfort with the terminal + curl/Postman | Testing actions | — |

## The path

| # | Module | Time | You'll be able to… |
|---|--------|------|---------------------|
| 1 | [What is App Builder?](01-what-is-app-builder.md) | 15 min | Explain out-of-process extensibility and why App Builder exists |
| 2 | [Architecture: Runtime, Actions & State](02-architecture-runtime-actions-state.md) | 25 min | Describe actions, the runtime, State, and read an action URL |
| 3 | [Setup & Deploy](03-setup-and-deploy.md) | 30 min (hands-on) | Log in, link a workspace, and deploy a live action |
| 4 | [Building Actions & Using State](04-building-actions-and-state.md) | 30 min | Write an action that validates input, calls an API, and uses State |
| 5 | [Connecting to a Storefront](05-connecting-to-a-storefront.md) | 25 min | Call an action from a browser/EDS block and fix CORS |

Total: ~2 hours to go from zero to "I built and deployed a backend and called it from a page."

## Suggested first sitting

1. Modules 1-2 (concepts) — read through.
2. Module 3 — **do it**: `aio login` → `aio app use` → `aio app deploy` a sample action.
3. Come back for Modules 4-5 to build something real and wire it to a page.

## After the path

- Trace the whole real build with [simulator-walkthrough.md](simulator-walkthrough.md) /
  `/simulate appbuilder`.
- Deepen into topics this kit only introduces: **Adobe I/O Events** (event-driven actions),
  **API Mesh** (unified GraphQL), the **App Builder Database** (Postgres for when key-value State
  isn't enough), and the **Admin UI SDK** (custom Commerce Admin screens). Start at
  `developer.adobe.com/app-builder`.
- Pair with the **EDS Enablement Kit** to build the storefront side that calls your actions.

## Honesty about depth

This kit covers what a first real build actually exercised: **actions, State, the aio CLI, Console
workspaces, deploy, and wiring to a storefront (incl. CORS).** It does **not** deeply cover Events,
API Mesh, the App Builder Database, or the Admin UI SDK — those are named and pointed to, not taught
in detail. Don't invent specifics for them; send learners to the official docs.
