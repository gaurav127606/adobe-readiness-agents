# Week 5 — Drop-In Customization, Configuration & Go-Live

**Session:** Session 5 (2026-09-09) — final session of the 5-week program
**Goal:** Finish drop-in customization depth (Extend/Substitute/Create, slots, events, tokens,
localization), fix a real production-config bug live, and cover the go-live checklist (SEO,
platform limits, AEM Assets, CORS) before independent work begins.
**Status:** Captured from transcript + Copilot recap/action-items.

## Masterclass companion

Not yet covered by any existing module — like Week 4, this is Commerce-specific territory beyond
Modules 1-5. Flagging for a future module alongside Week 4's drop-in fundamentals.

## Primer

**What you'll learn:** how to actually customize a drop-in without breaking it, why a committed
`config.json` silently overrides production, and the checklist to run through before a Commerce
storefront goes live.

### Drop-in customization

- Drop-ins are ready-made packages (sign-in, guest wishlist, cart, etc.) pulled into a commerce
  block/container — 12+ available today, with a gift-card drop-in and more B2B drop-ins in
  progress.
- **Three ways to customize:** **Extend** (safe, preferred), **Substitute**, **Create**. Check with
  Adobe/the commerce team before substituting or creating — both risk breaking Adobe's data-layer
  lifecycle (e.g. the Adobe Client Data Layer).
- **Slots** — pre/post/replace placeholder regions inside a drop-in container, wired up via
  `setContainer` from a block's `decorate()` function.
  - **Gotcha (hit live):** register `off` listeners *after* `on` listeners, or you risk duplicate
    handlers.
- **Events** — the event bus connects components across a page (same page only — not cross-page
  state transfer, per Week 4's clarification).
- **Commerce block conventions** — a `commerce-` prefix is required to distinguish commerce blocks
  from plain EDS blocks; paired `commerce-<feature>.js`/`.css` files live under `blocks/`.
- **`commerce.js` vs `build.mjs`** — `commerce.js` holds most init/config; `build.mjs` is where
  custom GraphQL operations get overridden (example given live: adding a "gift messages" field to
  cart without a new drop-in package).
- **Design tokens** — five categories: color, typography, spacing, shape/border, layout grid.
  Modify token *values*, don't override or copy whole templates.
- **Localization** — every drop-in ships its own placeholder file; use `getPlaceholder` from
  `aem.js` inside `decorate()`. Rule: never hard-code labels/text.

### Live block demo (closing Q&A, ~1:06:38)

The trainer walked through adding a commerce login block to a homepage, as a concrete "this isn't
just theory" example:
- Same mechanism as any other block: go to the respective page/template, copy its authored table
  structure, paste it where you want the block (e.g. copy a PDP template's product-recommendation
  table onto the homepage), then connect it to Commerce.
- **Product recommendations specifically need a receiver ID** — plus whatever product-value
  parameter the formatter expects — before they'll render real data.
- **Event bus, concretely:** create an event with a name (the drop-in/component it's tied to, plus
  what changed — e.g. a "data update" event), then read that event from a *different* component on
  the same page to retrieve the updated data. This is the actual mechanism behind "everything on a
  page is shareable" — one component's change becomes visible to another via the event, not through
  direct component-to-component calls.
- Recommendation: don't just watch this — actually add a block, connect it to a real GraphQL
  endpoint (aemshop.net for practice, a real ACCS/Optimizer endpoint once available), and see data
  render. "It's not like just I'll show it, you'll get it" — the syntax differences between blocks
  only click with hands-on repetition.

### Configuration & go-live — the session's centerpiece

- **The bug:** during Session 4's demo, `config.json` had been committed to `main` as a shortcut.
  A committed `config.json` on `main` silently overrides the Configuration Service in production —
  exactly the gotcha Week 4 documented in the abstract, now hit for real.
- **The live fix:**
  1. Remove `config.json` from `main` (gitignore it there; keep it only on local/test branches).
  2. Push production config via the Configuration Service's REST endpoint instead:
     ```
     curl -v -X POST "https://admin.hlx.page/config/{org}/sites/{site}/public.json" \
       -H "content-type: application/json" \
       -H "authorization: token $TOKEN" \
       --data '{ "default": { ... } }'
     ```
     The `{org}`/`{site}` values are the repo's own GitHub org and site slug. The `$TOKEN` came
     from a browser cookie (session login), not a static secret. Payload values pulled from
     `config.json` or DA.live's **Config Generator**
     (`da.live/app/adobe-commerce/storefront-tools/tools/config-generator`), adjusted for the real
     environment.
  3. Took two failed attempts (an export error, twice) before it succeeded — the fix went live with
     **no propagation delay** once the request was correct.
  - Full guide: https://www.aem.live/docs/config-service-setup#update-public-custom-configuration
- **AEM Assets integration** — `commerce-assets-enabled` toggle, set via the same config mechanism.
  When enabled, use `tryRenderAEMAssetImage` for optimized images. Misconfiguration → a 400 error.
- **CORS** — same-origin recommended; avoid wildcard `*`; watch for a missing
  `Access-Control-Allow-Origin` header.
- **Go-live / SEO checklist:**
  - JSON-LD must be syntactically perfect — one invalid annotation invalidates the *whole page* for
    search indexing.
  - Canonical URLs for configurable/child products — never 301 redirects.
  - Lighthouse gating recommended on every commit/MR.
  - WCAG audit and P1 Adobe support enablement recommended before launch.
- **Platform limits (stated live):** 200 req/sec per IP per host (429 beyond that); sitemap ~50K
  pages / 50MB max; redirects ~100K max; site ~1M pages max; branch limits — 500 files/branch, 100
  active branches, 500MB/branch. Full list: aem.live/docs/limits.

### AI integrations (brief, assumed familiarity)

Ready-made agent skills (project manager, researcher, block developer, tester roles), a Wayfinder
config line, and an `llms.txt`-style static fallback file — mentioned but not walked through in
depth.

### Universal Editor / DA.live

Brief live demo of the context-editor toggle (Google-Docs/SharePoint-style authoring vs.
Universal-Editor-style click-to-highlight), hampered by system slowness. Structured schemas
(`block.json`) control how components appear and behave in the editor.

### Real-world debugging tips (shared live, not on the original slides)

- A GraphQL-specific cache flush sometimes isn't enough — a real customer project needed a **full
  page cache flush** to see a config change take effect.
- When a drop-in misbehaves, compare against **aemshop.net** (Adobe's reference storefront) for the
  same block to isolate a platform-level bug from a project-specific one.
- **PDP pages at scale:** small catalogs can get by copying the product folder's default page
  structure per SKU; large catalogs (1000+) should use the **AEM Commerce Prerender** App Builder
  tool instead — though the trainer noted this tool's automated sync behavior hasn't been deeply
  explored yet. Uses GraphQL-driven runtime data fetching and generates static HTML for crawlers.

## Program closing

Presented explicitly as the final session of the 5-week program. The trainer framed the outcome as
taking the team "from zero to beginner," with the upcoming **Commerce Capstone** expected to push
participants to "intermediate." Thanked the co-presenters for launching and running the program,
and highlighted that a participant had converted the full 5-session program into an installable AI
skill package on the wiki — called out as sometimes more complete/accurate than the live sessions
themselves. A co-presenter offered to schedule additional sessions on request. ~30+ attendees. The
Capstone is the next concrete deliverable, not another numbered session.

**The trainer's self-assessed retro (closing remarks, ~1:08:35):** two acknowledged trade-offs —
(1) pace was fast because the priority was producing *reusable content* over covering everything in
5 sessions; a longer/more-sessions format is planned for future cohorts. (2) **Content corrections
across sessions were real, not hypothetical** — Session 3 had inaccuracies that were flagged, a
correction landed in Session 4, and something from Session 4 was itself further corrected/updated in
this session (matches the `config.json`-committed-to-`main` bug above — introduced as a shortcut in
Session 4's demo, fixed live here). The trainer's explicit recommendation: go through *all* sessions
(not just the latest), and specifically **use that AI skill tool** as the resource that answers
follow-up questions — in addition to, not instead of, watching the actual recordings.

## Action items (from session)

- Team to generate production config using the curl/token-based approach instead of `config.json`.
- Team to remove `config.json` from `main` to avoid overriding production settings.
- Team to complete the shared configuration/token-generation hands-on exercise.
- Participants to install and try the Git-based AI skill tool from the wiki.
- Team to practice PDP/product block implementation and integration in the storefront.
- Participants to revisit recordings and wiki materials for complete understanding.

## Resources

- Commerce Drop-Ins — Extend, Substitute, or Create?, Slots, Events, Design Tokens, Labeling and
  Localization (Adobe docs)
- Config Service setup guide: `admin.hlx.page/config/{org}/sites/{site}/public.json` —
  https://www.aem.live/docs/config-service-setup#update-public-custom-configuration
- AEM Assets integration configuration
- Launch Checklist, SEO Metadata/Indexing, Platform limits — https://www.aem.live/docs/limits
- AEM Commerce Prerender (App Builder)
- AI Integrations — Wayfinder, Boilerplate Skills, static text files

## Your notes

_(fill in after you try the config-service curl flow yourself — key takeaways, screenshots,
questions)_

## Self-check

1. What are the three ways to customize a drop-in, and which one should you check with Adobe/the
   commerce team before doing?
2. What's the slots gotcha with `on`/`off` listener registration order?
3. Where does `build.mjs` come in, and what's an example of something it's used for?
4. Why does a committed `config.json` on `main` silently override the Configuration Service in
   production, and what's the correct fix?
5. What does the `admin.hlx.page/config/{org}/sites/{site}/public.json` endpoint need in its
   request (auth, payload), and where does the token come from?
6. What does `commerce-assets-enabled` control, and what happens if it's misconfigured?
7. Name two of the platform limits stated live (rate limit, sitemap size, branch limits, etc.).
8. When should you reach for the AEM Commerce Prerender tool instead of per-SKU page copies?
9. If a drop-in is misbehaving, what's a quick way to tell a platform bug from a project-specific
   one?

Offer `/quiz eds` for a graded version of this self-check.
