# Week 4 — Blocks & CSS (Commerce Storefront: Drop-ins & GraphQL)

**Session:** Session 4 (2026-09-02, per the program roadmap)
**Goal:** Understand how EDS integrates with Adobe Commerce via the `aem-boilerplate-commerce`
starter — Commerce-specific blocks, drop-in components, and the actual GraphQL/REST call path from
the shopper's browser.
**Status:** Partially captured (slides shared live), presented by the trainer. More to be added as
more of the session is shared.

## Resolving Week 2's "possible scope shift" flag — take two

Week 2's README flagged a closing remark that the next session would "shift focus to commerce
integration... drop-ins and advanced block setups for e-commerce scenarios." Week 3's README
resolved that flag as **not happening in Session 3** — and it didn't. It happened here, in
**Session 4** instead. So the original Week 2 flag was correct, just one session early.

## What Is the Commerce Storefront?

- Adobe's supported starter/reference codebase for building storefronts on top of EDS — repo:
  `hlxsites/aem-boilerplate-commerce`.
- **Same EDS foundation** as Sessions 1-3: document authoring, buildless HTML generation, CDN
  delivery, GitHub deploy pipeline — **nothing here is replaced**.
- **What's added:** Commerce-specific blocks and drop-in components that connect authored pages to
  live Commerce data.
- **Workflow:** clone the boilerplate, connect a Commerce backend, customize blocks/scripts/styles —
  rather than hand-integrating every piece yourself.

## Correcting Session 3: how EDS actually talks to Commerce

| In Session 3 (as said live) | What actually happens |
|---|---|
| "EDS connects to Commerce via a spreadsheet/CSV feeding a GraphQL call" | A block's drop-in calls Commerce APIs (GraphQL/REST) **directly from the shopper's browser** |

> "This call goes from the shopper's browser directly to Commerce. Edge Delivery Services is not in
> the middle of it."

This is a genuine correction, not a contradiction of a made-up claim — the trainer explicitly called
out and corrected the earlier (Session 3) framing live. Source: experienceleague.adobe.com — "How a
Page Loads."

## How a Commerce page loads

1. **Author** — a doc table defines a block, e.g. a "Commerce Cart" table.
2. **Convert** — EDS converts the doc to HTML; the table becomes a classed `<div>` (same mechanism as
   any other EDS block, see [Week 3](../03%20-%20Week%203%20-%20Customizing%20Code/README.md)).
3. **Request** — the shopper's browser requests and loads the HTML.
4. **Decorate** — the block's decorator runs; its **initializer sets the Commerce endpoint first**,
   before anything renders.
5. **Mount** — `provider.render()` mounts the drop-in's UI into the block.
6. **Call Commerce** — the drop-in calls Commerce APIs directly; **EDS isn't in the path** at this
   point.

Source: experienceleague.adobe.com/developer/commerce/storefront/get-started/architecture/how-a-page-loads

## Blocks and the repository

- **Content blocks** — layout/marketing (cards, heroes, columns), no Commerce GraphQL involved, come
  from the standard Block Collection (same as plain EDS blocks from Weeks 1-3).
- **Commerce blocks** — interactive flows (cart, checkout, account, PDP — Product Detail Page) that
  load Commerce **drop-ins** via initializers.
- **`scripts/commerce.js`** — Commerce-specific loading, page templates, page-type detection, and
  analytics data-layer initialization.
- **`scripts/initializers/`** — one file per drop-in; each wires up the GraphQL endpoint and UI text
  **before** the block's `decorate()` runs.
- **Same naming rule as plain EDS blocks** (folder = CSS class = CSS file = JS file, see
  [Week 3](../03%20-%20Week%203%20-%20Customizing%20Code/README.md#project-anatomy-revisited)) —
  Commerce blocks just add a drop-in on top of that same structure.

## Drop-ins at a glance

A **drop-in** is a packaged piece of UI and logic for one Commerce job — cart, checkout, sign-in,
and so on. Think of it as a pre-built widget you install and configure, rather than something you
write from scratch.

**Three things every drop-in needs:**
- an npm package (e.g. `@dropins/storefront-cart`),
- initializer settings (endpoint + labels),
- a DOM mount point.

**After load, drop-ins run entirely in the browser** — EDS's job is just to deliver the HTML/CSS/JS;
once that's done, EDS steps out of the way and the drop-in takes over (consistent with the "EDS
isn't in the API path" point above).

**Customization layers, least to most invasive:**
CSS variables → label overrides → slots for custom content → extension hooks for logic replacement.

## Customization tiers

- **Tier 1 — CSS override:** theme variables like `var(--spacing-large)`, `var(--color-brand-500)`,
  `var(--type-body-1-default-font)`. Lowest-effort, highest-reuse option — try this first.
- **Tier 2 — `decorate()` override:** same signature as plain EDS blocks —
  `export default async function decorate(block) { ... }`.
- **Tier 3 — drop-in slots and events:** inject custom content via **slots**, or subscribe to
  lifecycle events via `events.on()` from `@dropins/tools/event-bus.js`.
- **Config reading pattern:** `import { readBlockConfig } from '../../scripts/aem.js'` — the exact
  same helper used by plain EDS blocks (see [Week 3](../03%20-%20Week%203%20-%20Customizing%20Code/README.md)),
  not a new Commerce-specific mechanism.
- **Gotcha:** blocks like Login, Create Account, and Forgot Password are **thin drop-in wrappers with
  no document-authoring options** — there's no table/field an author can edit in the doc to change
  their behavior. Customize these only via JS/CSS/slots.

## Two Commerce backends, compared

| | Adobe Commerce as a Cloud Service (ACCS) | Adobe Commerce Optimizer |
|---|---|---|
| License | Storefront included | Storefront included |
| Setup | Fully automated | Fully automated |
| Version | Continuous release, Adobe-managed | Continuous release, Adobe-managed |
| Management | Adobe manages all requirements | Adobe fully manages as SaaS |

A third, **unmanaged** option exists (Commerce without Optimizer), but it needs manual setup and has
**no drop-ins without an Optimizer license**. Choosing between ACCS and Optimizer is
**licensing-driven, not a technical decision** — both give you the same automated, drop-in-capable
storefront experience.

## Compatibility Package

- Bridges Adobe Commerce with the GraphQL/REST operations storefront drop-ins need (cart, checkout,
  account, order).
- **B2C package:** Commerce 2.4.7 / 2.4.8 / 2.4.9 (2.4.9 recommended). **B2B package:** 2.4.8 / 2.4.9
  only. **Magento Open Source is not supported.**
- **ACCS:** installed automatically — no action needed.
- **Cloud/on-prem with Optimizer:** manual Composer install required.
- **Cloud/on-prem without Optimizer:** not available — look at other backend options (this is the
  concrete reason the unmanaged path above has "no drop-ins").

## Getting started (local setup)

**Prerequisites:** a storefront already created (repo + Commerce connection + DA.live content),
plus Node.js and npm installed.

1. `npm install` — then **critically**, `npm run install:dropins` — copies drop-in assets into
   `scripts/__dropins__` and applies GraphQL overrides from `build.mjs`.
2. **This second command never runs automatically.** The repo's `.npmrc` disables npm lifecycle
   scripts as a security measure, so `install:dropins` has to be run **by hand, every time** drop-ins
   are installed or updated. (This is a real difference from the plain EDS boilerplate you used in
   Weeks 1-3 — there, `npm install` alone was enough.)
3. `npm start` — local dev server at `localhost:3000` (an optional global `@adobe/aem-cli` install
   lets this run from any directory, same as `aem up` from Week 3).
4. **Never edit** `scripts/aem.js` (the core runtime) or the **`package.json` lifecycle scripts** —
   both break on future boilerplate updates. This is the Commerce-specific version of the "never
   edit vendored files" rule from Week 1.

## Configuration — three layers

- **`config.json`** (repo root, for local dev) — holds `commerce-endpoint`, `commerce-core-endpoint`,
  `headers.cs`, `analytics`, `plugins.picker.rootCategory`.
  - **ACCS:** set only `commerce-endpoint`.
  - **Adobe Commerce Optimizer:** set **both** `commerce-endpoint` (catalog) and
    `commerce-core-endpoint` (core ops) — Optimizer splits catalog and core operations across two
    endpoints, ACCS doesn't.
- **`default-site.json`** — the production template: repo, content source, store config,
  `robots.txt`, admin permissions.
- **`default-query.yaml` / `default-sitemap.yaml`** — content indexing and sitemap generation.
- **Critical gotcha:** if you're using the Configuration Service, **never commit `config.json` to
  `main`** — a `config.json` present in the repo takes precedence over (overrides) the
  Configuration Service, so committing it to `main` silently locks in whatever was in that file.
  Production config actually lives at `https://tools.aem.live/`, not in the repo, once you're past
  local dev.

## Create a storefront — the lab script

**Steps 1-3:**
1. Create a repo from the `hlxsites/aem-boilerplate-commerce` template.
2. Install **AEM Code Sync** on the new repo (auto-redeploys on push to `main` — same mechanism from
   [Week 1](../01%20-%20Week%201%20-%20Introduction%2C%20Architecture%20and%20Setup)).
3. Generate `config.json` via DA.live's **Config Generator** tool, save it at the repo root,
   commit/push.

**Steps 4-5:**
4. Add content via DA.live's **Site Creator** — choose "Use existing repository," follow the
   prompts.
5. Locally: `git clone`, `npm install`, `npm run install:dropins`, `npm start`. Optional: Sidekick
   install, permissions config before production.

Tool link: da.live/app/adobe-commerce/storefront-tools/tools/site-creator/site-creator (also links
out to the Config Generator tab).

**Config Generator, concretely:** it auto-detects your environment type (PaaS, ACCS, or ACO —
Adobe Commerce Optimizer) from a GraphQL API URL you paste in (e.g.
`https://www.aemshop.net/graphql`), and generates the storefront configuration object for you. You
can either deploy the output via the Configuration Service (recommended for production) or paste it
into a `config.json` on a feature branch for local dev/branch testing — remembering the rule above
that a `config.json` on a branch always wins over the Configuration Service.

## Session narration notes

- The trainer introduced the Commerce Storefront as the same EDS foundation used in earlier sessions,
  with Commerce-specific blocks and drop-ins layered on top to connect authored pages to live
  Commerce data.
- EDS Foundation recap: document-based authoring, HTML generation, CDN delivery, and Git-based
  deployment. Commerce does not replace this foundation — it adds Commerce-specific functionality
  while preserving the buildless, JS/CSS architecture.
- Commerce API Flow: the trainer explicitly corrected the earlier (Session 3) explanation that EDS
  connects to Commerce through a CSV/spreadsheet. The actual runtime flow: a Commerce block or
  drop-in calls GraphQL or REST APIs directly from the shopper's browser; EDS delivers the page
  assets but is **not** in the API call path.
- Page Loading Sequence: authored content → converted to HTML → requested by the browser →
  decorated by the block's JavaScript → mounted with the drop-in UI. The initializer sets endpoint
  and configuration values **before** the drop-in renders.
- Block Categories: content blocks (cards, heroes, columns) are static layout/marketing components
  from the standard block collection; Commerce blocks support interactive experiences (cart,
  checkout, account, PDP) and load Commerce drop-ins through initializers.
- Drop-In Components And Customization: Commerce drop-ins package reusable UI and logic for
  functions such as cart, checkout, account, and product detail pages; each is installed as an npm
  package, configured through an initializer, and mounted into a DOM container.
- Customization Layers (least to most extensive): update CSS variables/theme tokens → override
  labels → use slots for inserting content → use extension hooks or JavaScript for deeper behavior
  changes. **Most projects should reuse the supplied drop-in and customize it, rather than replace
  it outright.**
- Decoration Pattern: Commerce blocks follow the **same** folder/CSS/JS naming conventions as
  standard EDS blocks (see [Week 3](../03%20-%20Week%203%20-%20Customizing%20Code/README.md)). Their
  `decorate()` receives the block, can read/manipulate its DOM, and mounts the resulting content;
  `readBlockConfig` remains the standard way to read authored block configuration.
- Events And Slots: slots are predefined insertion areas inside a drop-in; the **event bus** lets
  components on the *same page* communicate when data changes (e.g. cart count updating after an
  add-to-cart action elsewhere on the page). The trainer explicitly clarified this is for
  **component-to-component interaction within a page, not cross-page state transfer.**
- Commerce Backend And Compatibility: compared ACCS, Adobe Commerce Optimizer, and unmanaged
  Commerce options, emphasizing that **licensing and the required compatibility package** determine
  the supported setup — not a technical/architecture choice.
- Cloud Options: ACCS and Optimizer both provide a managed, automated storefront experience with the
  relevant Commerce integration included. The choice between them is licensing-driven, not a
  fundamental storefront-implementation decision.
- Optimizer Requirement: for a PaaS or on-premises Commerce setup, **Optimizer is required** for the
  drop-in-based storefront approach discussed. Without it, the same drop-in-based storefront setup
  isn't available at all.
- Compatibility Package: supplies the GraphQL/REST operations storefront drop-ins need (cart,
  checkout, account, order); installed automatically for ACCS, but Cloud/on-prem setups using
  Optimizer require a **manual Composer installation**.
- B2B Support: the Commerce team is preparing B2B models, and corresponding B2B drop-ins are
  available when a customer implementation requires them.
- Storefront Setup And Configuration: demoed the full setup workflow — connecting GitHub and
  DA.live, installing drop-ins locally, and generating the Commerce configuration.
- Repository Setup: participants create a **public** test repository from the Commerce boilerplate
  template, using a consistent enablement naming suffix, then install Node.js/npm and clone locally.
- Drop-In Installation: unlike the plain EDS setup, the Commerce repo needs `npm install` **because
  drop-ins are packaged dependencies**, plus the custom `npm run install:dropins` command — not
  automatic, since the repo disables npm lifecycle scripts.
- Local Development: `npm start` runs the local dev server (`localhost:3000`). Explicit caution:
  don't modify core runtime files or lifecycle scripts — it can break future boilerplate upgrades.
- Configuration Layers: `config.json` is for local dev/branch testing (Commerce endpoint settings);
  `default-site.json`/`default-query.yaml`/`default-sitemap.yaml` support production site metadata,
  permissions, indexing, and sitemap generation. Explicit emphasis: don't commit `config.json` to
  `main` when using the Configuration Service, since repo config takes precedence.
- Config Generator: the DA.live Commerce Config Generator takes a GraphQL endpoint and produces the
  needed configuration object; copy the generated JSON into `config.json`, commit to the right
  development branch, then swap the sample testing endpoint for the customer's real Commerce
  endpoint later.

## Links

- How a Page Loads: experienceleague.adobe.com/developer/commerce/storefront/get-started/architecture/how-a-page-loads
- Boilerplate repo referenced live: `hlxsites/aem-boilerplate-commerce`

## Masterclass companion

Not yet covered by any existing module — this is new Commerce-specific territory beyond Modules 1-5.
Flagging for a future module once the full session is captured.

## Your notes

_(fill in once you complete any hands-on practice for this week — key takeaways, screenshots,
questions)_

## Self-check

1. What stays exactly the same between the Commerce Storefront and the plain EDS boilerplate you
   used in Weeks 1-3, and what's actually new?
2. Session 3 described EDS-to-Commerce communication as "a spreadsheet/CSV feeding a GraphQL call."
   What's actually true, and where does that API call happen?
3. Put these steps of a Commerce page load in the correct order: Decorate, Author, Call Commerce,
   Convert, Mount, Request.
4. What's the difference between a "content block" and a "Commerce block"?
5. What does a file in `scripts/initializers/` do, and when does it run relative to `decorate()`?
6. Name the three things every drop-in needs, and put the four customization layers in order from
   least to most invasive.
7. Why can't an author customize the Login block by editing a table in their document?
8. What's the event bus for, and what is it explicitly *not* meant to do?
9. Is choosing between Adobe Commerce as a Cloud Service and Adobe Commerce Optimizer a technical
   decision or a licensing decision?
10. Why does a PaaS/on-prem Commerce setup without Optimizer have no drop-ins available?
11. What does the Compatibility Package actually provide, and who has to install it manually?
12. Why doesn't `npm install:dropins` run automatically after `npm install`, and when do you need to
    re-run it?
13. What's the difference between `config.json` and `default-site.json` — and what happens if you
    commit `config.json` to `main` while using the Configuration Service?
14. What does the Config Generator need as input, and what does it produce?

Offer `/quiz eds` for a graded version of this self-check.
