---
name: appbuilder-enablement-masterclass
description: "Teach Adobe App Builder (Adobe I/O Runtime, Actions, State, API Mesh-adjacent extensibility) from zero — what App Builder is and why it exists (out-of-process, serverless extensibility for Adobe Commerce and Experience Cloud), its runtime/actions/State architecture, the aio CLI + Adobe Developer Console workspace model, how to build and deploy web actions, and the real hands-on workflow (aio login → aio app use → aio app deploy → seed data → call the actions from a storefront). Grounded in a real first-time build: a store-locator geocode + search backend deployed to Adobe I/O Runtime and wired to an Edge Delivery Services storefront block. Use when someone is new to App Builder and wants a structured learning path, a plain-English term lookup, a walkthrough of how a request flows through an action, or to be quizzed on a module."
---

# App Builder Enablement Masterclass — Learning Skill

## Purpose

Take someone who has **never touched Adobe App Builder** and teach them, from zero, how it actually
works — the mental models, the real setup steps, and the gotchas people genuinely hit the first
time. This is a **teaching** skill, not a reference dump.

The content is grounded in one concrete, real build: a **store-locator backend** — two serverless
actions, `map-geocode` (turn an address into coordinates) and `store-locator-search` (find nearby
stores) — deployed to **Adobe I/O Runtime** and called from an **Edge Delivery Services (EDS)**
storefront block. Every module ties back to that example, with the actual commands, URLs, and
first-time mistakes from building it (see [simulator-walkthrough.md](simulator-walkthrough.md)).

## What App Builder is, in one sentence

> **App Builder is Adobe's way to run your own serverless code (Node.js "actions") *next to*
> Adobe Commerce / Experience Cloud — not inside it — so you extend Adobe products without modifying
> their core code.**

That's the whole idea: "out-of-process extensibility." Commerce stays Commerce; your custom logic
lives outside it and connects back over HTTP, events, and webhooks.

## When to use

- Someone says "I'm new to App Builder, teach me" or asks how any part works (what it is, the
  runtime, actions, State, the aio CLI, Developer Console workspaces, deploying, calling actions).
- A learner wants a plain-English term explained (what's a web action? what's a namespace? what's
  `require-adobe-auth`? what's Adobe I/O State?) — see [glossary.md](glossary.md).
- Someone wants to trace a request end to end — browser/storefront → action → State/external API →
  response — see [simulator-walkthrough.md](simulator-walkthrough.md).
- A learner wants to be quizzed / self-check a module.

## When NOT to use

- Deep **Adobe Commerce on-prem/PaaS** internals (PHP modules, plugins, DI) — that's Magento
  engineering, not App Builder.
- **EDS storefront** authoring/blocks themselves — that's `eds-enablement-masterclass`. This skill
  covers the *backend* actions an EDS block calls; the two are companions (Module 5 is the bridge).
- The broader **ACCS / API Mesh / Events** conceptual map for commerce architects — that's
  `adobe-commerce-cloud-masterclass`. This skill teaches App Builder hands-on, from zero.

## How to teach (the operating rules)

1. **Meet the learner where they are.** Assume no prior knowledge. Define every acronym the first
   time it appears (aio = Adobe I/O, CLI = Command-Line Interface, etc.). No jargon walls.
2. **One mental model at a time.** Analogy first, *then* mechanics, *then* the store-locator example.
3. **Always connect back to the "spine."** App Builder's spine is a **request → action → response**
   pipeline:

   ```mermaid
   flowchart LR
       T["TRIGGER<br/>HTTP call / webhook /<br/>event / schedule"] --> A["ACTION<br/>your Node.js code on<br/>Adobe I/O Runtime"]
       A --> D["DATA<br/>Adobe I/O State /<br/>external API (e.g. OSM)"]
       D --> A
       A --> R["RESPONSE<br/>JSON"]
       R --> C["CONSUMER<br/>EDS block / Commerce /<br/>browser"]
   ```

   After explaining a piece, say where it sits on this spine and what breaks if it's done wrong
   (e.g. forget to register the action in `app.config.yaml` → it never deploys; set CORS headers
   yourself → the browser sees `*,*` and rejects it).
4. **Ground it in the store-locator build.** Use the real commands, the real namespace
   (`123456-myproject-integration`), and the real gotchas from
   [simulator-walkthrough.md](simulator-walkthrough.md).
5. **Check understanding before advancing.** End a teaching turn with the module's "Check yourself"
   questions, and offer the next module.
6. **Teach visually — use Mermaid diagrams.** Each module has ready-made diagrams; reproduce them.
7. **Be honest about depth.** This kit covers what a first real build actually exercised: actions,
   State, the aio CLI, Console workspaces, deploy, and wiring to a storefront. It does **not** deeply
   cover Adobe I/O Events, API Mesh, the App Builder Database (Postgres), or the Admin UI SDK — if
   asked, say so plainly and point to `developer.adobe.com/app-builder` docs rather than inventing.

## The learning path (pedagogical order)

| # | Module | The one question it answers | File |
|---|--------|------------------------------|------|
| 1 | What is App Builder? | What is App Builder, and why does it exist? | [01-what-is-app-builder.md](01-what-is-app-builder.md) |
| 2 | Architecture: Runtime, Actions & State | What actually runs your code, and where does data live? | [02-architecture-runtime-actions-state.md](02-architecture-runtime-actions-state.md) |
| 3 | Setup & Deploy (aio CLI + Console) | How do you go from nothing to a live action URL? | [03-setup-and-deploy.md](03-setup-and-deploy.md) |
| 4 | Building Actions & Using State | How do you write an action, and how does it read/write data? | [04-building-actions-and-state.md](04-building-actions-and-state.md) |
| 5 | Connecting Actions to a Storefront | How does an EDS block call your action (and the CORS gotcha)? | [05-connecting-to-a-storefront.md](05-connecting-to-a-storefront.md) |

## Companion commands

- **`/learn appbuilder [topic]`** — start or continue the masterclass; teaches a module in depth.
- **`/define appbuilder [term]`** — a quick, plain-English definition of one term, backed by
  [glossary.md](glossary.md).
- **`/simulate appbuilder [scenario]`** — trace a request from trigger to response, or walk the real
  store-locator build step by step. Backed by [simulator-walkthrough.md](simulator-walkthrough.md).
- **`/quiz appbuilder [topic]`** — quiz the learner on a module and grade the answers.

## Additional resources

- [learning-path.md](learning-path.md) — full curriculum, prerequisites, time estimates
- [glossary.md](glossary.md) — every acronym and term, in plain English
- [simulator-walkthrough.md](simulator-walkthrough.md) — the real store-locator build: exact
  commands, the `123456-myproject-integration` namespace, and every first-time gotcha
- Module files `01` through `05` — one concept each, in pedagogical order (table above)
