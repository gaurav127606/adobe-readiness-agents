# Week 2 — DA & Sidekick Deep-Dive (+ First Custom Block & PR Workflow)

**Session:** Session 2 (2026-08-19, per the program roadmap)
**Goal:** Hands-on practice — set up a real page with metadata, build a first custom block, install
Sidekick, and go through a real PR-based publish workflow.
**Status:** Assignment captured 2026-08-26 (real "Hands-on Practice 2" instructions shared by the
team) — the learner's own attempt not yet completed as of this update.

## Note on scope vs. the original roadmap

The roadmap slide framed this week as just "DA & Sidekick deep-dive." The actual assignment is
broader: it also introduces **custom block creation** (originally slated for Week 4) and a **PR +
CI workflow** (the `aem-code-sync` bot's automated Lighthouse/PageSpeed check), neither of which is
covered by any masterclass module yet. Flagging this now so later weeks aren't assumed to duplicate
it.

## Session 2 recording notes — "Under the hood" (architecture deep-dive)

Session 2's agenda: recap Session 1 → **under the hood** (Helix Admin Service, content/code bus,
dual delivery stacks) → EDS vs. AEM Sites (coexistence, not replacement) → document authoring &
blocks deep-dive → Sidekick deep-dive (preview/publish/unpublish/delete) → forms & Commerce drop-ins
(intro) → live practice → key takeaways/roadmap. What's captured so far is the **recap + under the
hood** portion (from slides + recording chapter summaries); the rest lands as more of the recording
is reviewed.

**Recap of Session 1, as restated in Session 2** (mostly confirms what we already had, one nuance
worth flagging): the "100 Lighthouse" framing softened slightly — it's now described as **"the
target, powered by eager/lazy/delayed loading phases — real-world sites land very close to it, even
when not every single check is perfect,"** rather than an absolute guarantee.

**New: the Helix Admin Service.** Sidekick and the AEM Code Sync GitHub App are both just
*triggers* — the real work (converting documents, syncing code, managing publish state) is done by
the **Helix Admin Service**, which routes into the content bus and code bus. The code connection
(GitHub ↔ site) and the content connection (GitHub ↔ da.live/Docs) are configured separately, both
living in the **Configuration Service at `tools.aem.live`**.

**New: how a document becomes Markdown.** Two adapters do the conversion — a Word-to-Markdown
adapter and a Google-Docs-to-Markdown adapter. Spreadsheets are the exception: they become **JSON**,
not Markdown.

**New: what "Publish" actually does.** The content bus is one folder per customer, split into a
**Preview partition** (`*.aem.page`, non-cached) and a **Live partition** (`*.aem.live`, cached).
Publishing doesn't rebuild or regenerate anything — it's literally a **copy** of content from the
Preview partition to the Live partition.

**Confirmed: why URLs look the way they do.** `main--<repo>--<owner>.aem.page` is built directly
from Owner (GitHub username/org) + Repo + Branch. The slide explicitly calls out that account
mix-ups broke real demos in Session 1 — matching exactly the repo-name/owner typo the learner hit
and fixed during the Week 1 walkthrough here.

**New: dual implementation stack for resilience.** EDS runs on two parallel stacks — default is
AWS (S3 + Lambda + Fastly), backup is Cloudflare (R2 + Worker + Cloudflare CDN). If a major CDN
provider has an outage, sites automatically fail over to the second stack and stay up.

**Update on capture progress:** the recap + under-the-hood + document-authoring/blocks portions
below were already captured. Since then, the **forms & Commerce drop-ins intro** and a **live
block-creation demo** (see new sections below) have also been captured. Sidekick deep-dive detail
(preview/publish/unpublish/delete specifics) and the rest of live practice/key-takeaways are still
outstanding.

**Reinforced: authoring tools.** Google Docs/Sheets (via Google Drive), Word/Excel (via SharePoint),
or DA.live — Adobe's own tool and "the direction future EDS projects are heading." The "zero
training" pitch is specifically about the *tool* (authors already know Docs/Word) — the real
learning curve is a given site's own content conventions, not new software.

This deep-dive has been folded into [Module 2](../../02-architecture-and-content-hub.md) of
the masterclass skill (`/learn eds architecture` or `/define eds Helix Admin Service`).

## Session 2 recording notes — "Anatomy of a Project"

Part of the same "document authoring deep-dive & blocks" agenda item. Source cited on the slide:
`aem.live/developer/anatomy-of-a-project`. This is a buildless project — everything below runs
straight from GitHub, no build step:

| File/folder | Role |
|---|---|
| `head.html` | Injected into every page's `<head>` — one place to control markup with no build step. Only for base-URL remapping/legacy-browser support; no inline scripts/martech (performance hit). |
| `404.html` | Custom error page at the repo root, authored/committed like a normal page. |
| `.hlxignore` | `.gitignore`-style file keeping private/irrelevant files (tests, build artifacts) out of delivery. |
| `robots.txt` | Only takes effect on the real production domain — `.aem.page`/`.aem.live` always force disallow-all regardless. |
| `/scripts` | `scripts.js`, `aem.js` — lazy-phase trigger logic. |
| `/styles` | `styles.css` (LCP-critical) + `lazy-styles.css`. |
| `/blocks` | One subfolder per block: `blockname/blockname.css` + `blockname.js`. |
| `/icons` | SVGs, referenced in content as `:iconname:`. |

**Block naming rule (important debugging trap):** folder name = CSS class = CSS filename = JS
filename, all identical. A mismatched table header in the source doc is why a block silently fails
to render — no error, it just doesn't apply.

This has been folded into [Module 4](../../04-hands-on-setup-and-code-sync.md) of the
masterclass skill. Note: this content also covers a good chunk of what the roadmap originally
expected to land in **Week 3** ("project structure, `scripts.js`/`styles.css`") — flagging the
overlap rather than assuming Week 3 will be redundant once its own session happens.

## Session 2 recording notes — "Creating a da.live Project" (da.live/start)

Presented by the trainer. Four-step flow to scaffold a brand-new DA.live project:

1. Go to `da.live/start`.
2. Paste your **AEM codebase** GitHub URL (the repo Code Sync is watching).
3. Choose demo content — **None**, **AEM Block Collection** (recommended — ready-made blocks, no
   custom dev work, fits fast/consistent onboarding), or **Author Kit** (flexible authoring).
4. Click **"Make something wonderful."**

**Trivia:** `da.live` began life internally as **"Dark Alley"** — now officially **Adobe Document
Authoring (DA) for Edge Delivery Services**.

**`fstab.yaml`** — a UNIX-`fstab`-style file defining the content mountpoint, always read from
`main`; generated automatically when you scaffold via `da.live/start`. With **Helix 5** it's
optional — content sources can be set via the Configuration Service API instead, for a **repoless
setup** (same code repo reused across multiple sites). Only one mountpoint per `fstab.yaml`; extra
sources need a Configuration Service overlay (**BYOM** — Bring Your Own Mount).

**Troubleshooting note:** broken/missing images on a freshly scaffolded page trace back to block
selection during setup — picking AEM Block Collection and following the steps in order avoids it.

This has been folded into [Module 5](../../05-da-live-authoring-and-publishing.md).

## Session 2 recording notes — Page/Bulk Metadata & Placeholders

Directly relevant to Hands-On Practice steps 1 & 2 below — this is the exact mechanics for them.

**Page-level metadata:** a table at the end of the doc. First row: literally the word "Metadata"
(tells AEM everything below is page metadata). Then one row per property — left = property name
(`title`, `description`, `image`...), right = value. Preview/publish like any content change; leave
a value cell empty to remove that property.

**Bulk/global metadata:** a sheet named `metadata` (`metadata.xlsx` on SharePoint) in the site root.
Columns: URL pattern (wildcards, e.g. `/docs/**`) + one column per property. Evaluated top-to-bottom
— site-wide `**` rules must come before specific ones. `""` as a value explicitly removes a property
from matching pages. **Confirms the assignment's own precedence note: page-level metadata always
wins over the bulk sheet.** The sheet itself must be previewed + published for changes to apply.

**Placeholders:** a `placeholders` sheet (`placeholders.xlsx`), root or per-locale folder, columns
`Key` (used in code) + `Text` (literal string) — centralizes repeated strings, especially for
multilingual sites. Preview via Sidekick, have stakeholders check `.page` before going to
production.

This has been folded into [Module 5](../../05-da-live-authoring-and-publishing.md).

## Session 2 recording notes — Forms with EDS (intro)

Slide-level intro only, per the roadmap's "forms & Commerce drop-ins (intro)" agenda item.

- A **spreadsheet defines the form's fields** — EDS generates a **JSON definition** from it.
- Previewing that spreadsheet creates a URL; a **Form block** on the page renders it.
- Integrated with AEM (the Universal Editor flow), the same forms switch to AEM's **Adaptive
  Form** block/editor instead.
- Same spreadsheet-to-API mechanism generalizes beyond forms — any spreadsheet can back nav, data
  tables, or feature comparisons, not just forms.

This has been folded into [Module 5](../../05-da-live-authoring-and-publishing.md)
(spreadsheet-as-data pattern).

## Session 2 recording notes — Commerce Drop-ins (intro)

Also slide-level intro only.

- Adobe Commerce ships pre-built, Commerce-specific blocks called **drop-ins** — cart, product
  listing, checkout, and more.
- Same idea as AEM's out-of-box components, purpose-built for Commerce storefronts running on EDS.
- Explicitly framed as the concrete, technical path to Session 1's "EDS + ACCS (Adobe Commerce as
  a Cloud Service)" pairing goal.
- Reference cited on the slide: `github.com/adobe-commerce`.

Not yet in any masterclass module — flagging for a future cross-link once ACCS drop-ins get their
own module.

## Session 2 recording notes — Hands-On demo: Creating and Publishing Custom Blocks

Recording chapter (~45:47), led by the trainer, live-building on the "Anatomy of a Project" and
block-naming-rule material above.

- **Block Creation Workflow:** define the block in the document (a table whose header row is the
  block name), then add matching `blockname.css` + `blockname.js` under `/blocks/blockname/` in
  GitHub — naming has to match exactly or the block silently fails to render on the page.
- **Styling and Scripting Blocks:** JS uses `export default async function decorate(block) {
  ... }`; CSS is scoped per block but can also draw on global styles for a consistent look.
- **Testing and Debugging — confirms the naming-rule trap concretely:** live preview showed real
  404s (`eds-custom-block.js`, `eds-custom-block.css`, `eds-enablement.js`, `eds-enablement.css`)
  and console errors (`failed to load module`, `failed to load block`) for two blocks referenced in
  the doc whose `/blocks/<name>/` folders didn't exist yet in GitHub. A third block on the same
  page (`testing-block`) loaded fine (`data-block-status="loaded"`) because its files already
  existed — same page, side-by-side pass/fail, isolated to whichever block is missing its files.
  **Nuance vs. the "no error" framing above:** the page itself shows no visible error — the block
  area is just blank — but DevTools Console/Network shows the 404s loudly.
- **Branching and Performance Checks:** use a branch + PR for block changes (not committing
  straight to `main`), and wait for the `aem-code-sync` bot's Lighthouse/PageSpeed comment before
  merging — same mechanic as Hands-On Practice 2, steps 6-7 below.

Not yet in any masterclass module.

## Session 2 recording notes — Sidekick Deep-Dive: Author, Preview, Publish, Unpublish

This fills in the "Sidekick deep-dive (preview/publish/unpublish/delete)" agenda item flagged
above as not yet captured.

**Before We Start — prerequisites for the authoring practice:**
- A GitHub account and access to DA.live (or your Google Drive/SharePoint document).
- Sidekick installed, if you're using Google Docs or SharePoint.
- Local dev via `aem up` and the AEM CLI.
- **Confirmed:** document-based authoring never actually requires local dev — that's only for
  previewing code changes in your own editor.

**The practice loop:** edit content directly in DA.live or your doc → preview with Sidekick →
publish → unpublish a page → re-publish it.

**Watch for (gotchas called out on the slide):**
- Cache-related false negatives — hard-reload first before assuming something's broken.
- Preview vs. live confusion — double-check the URL (`.aem.page` vs `.aem.live`).
- GitHub account/org mismatches — called out as "our biggest snag last time," matching the
  account/repo-name mix-up the learner hit and fixed during the Week 1 walkthrough.

This has been folded into [Module 5](../../05-da-live-authoring-and-publishing.md).

## Flag: possible Week 3 scope shift (not yet confirmed)

Near the end of the Session 2 recording, a closing note said the next session will "shift focus to
commerce integration, specifically working with drop-ins and advanced block setups for e-commerce
scenarios." That doesn't match Week 3's roadmap framing in `LEARNING-PLAN.md` ("project structure,
`scripts.js`/`styles.css`"). Session 3 was scheduled for 2026-08-26 and has already passed as of
this note (2026-08-30) — confirm this against the actual Session 3 recording once it's reviewed,
the same way Week 2 turned out broader than its own roadmap slide.

## A learner's own hands-on session — local block testing + the Code Sync sync gap (2026-08-30)

Real debugging session on the learner's own fork (`github.com/<your-username>/<your-repo>`), not
the recording — a live worked example of several concepts above happening for real.

**What was built:** a brand-new `my-first-block` (JS + CSS from scratch), plus the missing JS for
an already-half-created `eds-custom-block` that was referenced in the real doc content but
404ing exactly per the naming-rule trap above.

**The bigger discovery — Code Sync installed, but the whole page was unstyled, zero console
errors:** turned out Code Sync had never actually synced *anything* for this repo, because it was
installed after the repo's only commit — and installing the app doesn't retroactively sync old
commits, it only reacts to the next push. Diagnosed via `curl
https://admin.hlx.page/status/<your-username>/<your-repo>/main` (the `code` field showed `400`
while `preview`/`live` showed `200` — content bus fine, code bus empty), then fixed with a
one-time forced sync: `curl -X POST
https://admin.hlx.page/code/<your-username>/<your-repo>/main/*`. This pulled the existing commit's
`head.html`/`scripts.js`/`styles.css`/blocks into the code bus for the first time, and the site
immediately rendered fully styled.

**Key nuance confirmed:** `aem up` (local dev) always serves your own local files for `/blocks`,
`/scripts`, `/styles` regardless of git status — so `my-first-block` rendered correctly on
`localhost:3000` immediately, while remaining completely invisible on the real `.aem.page`/
`.aem.live` site, since those only ever see what's actually reached GitHub *and* the code bus.

This whole incident has been generalized into the masterclass skill's
[Module 4](../../04-hands-on-setup-and-code-sync.md#real-incident-code-sync-is-installed-but-the-site-has-zero-styling)
(the sync-gap diagnosis) and [Module 5](../../05-da-live-authoring-and-publishing.md) (the
Sidekick loop content, separately captured from the recording).

## Hands-On Practice 2 — for everyone

1. **Set up your first page** — with valid images (per the shared reference slide). Meta title:
   `session-2 setup first page`.
2. **Add global/bulk metadata.** Note: page-level metadata takes precedence over bulk metadata.
   Meta title: `session-2 setup`.
3. **Create a custom block "EDS Enablement Block"** — add the JS/CSS to GitHub and make it live; add
   the classes `session-two` and `session-practice`.
4. **Install the Sidekick extension** — "AEM Sidekick" on the Chrome Web Store (search by name; no
   direct link captured yet). Docs: https://www.aem.live/docs/sidekick
5. **Review DA.live's live-preview limitations**:
   https://docs.da.live/authors/reference/live-preview#limitations
6. **Open a PR** with your block changes — e.g. a PR titled `Update eds-custom-block.js` against
   your own fork. **Wait before merging** so the `aem-code-sync` bot can post its automated check
   first.
7. **Expect this result:** the bot comments directly on the PR with a Lighthouse/PageSpeed Insights
   table — mobile and desktop rows, each with Performance/Accessibility/SEO/Best Practices scores
   and SI/FCP/LCP/TBT/CLS audit metrics, plus links to the full Google PageSpeed report.

Expectation from the team: everyone practices this once and sets it up across **local, GitHub, and
da.live** — not just one of the three.

## Key concepts this practice confirms

- **Metadata precedence:** page-level metadata overrides global/bulk metadata when both exist.
- **Blocks are shipped via GitHub, not local-only** — a custom block's JS/CSS has to be pushed and
  synced (via `aem-code-sync`) before it's live, same code-bus mechanism as Week 1.
- **Every PR gets an automated performance check** — this is the concrete version of the
  boilerplate's own "Peak performance" blurb from Week 1 ("Use AEM's PageSpeed Insights Github
  action to evaluate every Pull-Request for Lighthouse Score"). It's not a manual step anyone
  configures; it's on by default via the Code Sync bot.
- **Why wait to merge:** merging before the bot comments means shipping a block to Live without
  having seen its performance/accessibility/SEO impact first.

## Links

- Sidekick docs: https://www.aem.live/docs/sidekick
- DA.live live-preview limitations: https://docs.da.live/authors/reference/live-preview#limitations
## Masterclass companion

Partial coverage only — [Module 5](../../05-da-live-authoring-and-publishing.md) covers
DA.live/Sidekick basics. Custom blocks and the PR/CI workflow aren't in any module yet (blocks were
expected in a future Week 4 module).

## Your notes

_(fill in once you complete the hands-on practice — key takeaways, screenshots, questions)_

## Self-check

1. If a page sets its own metadata and global/bulk metadata also sets a value for the same field,
   which one wins?
2. What two file types does a custom block need in GitHub before it can go live?
3. Why should you wait before merging a PR that adds or changes a block?
4. Name the five audit metrics shown in the `aem-code-sync` bot's automated PR report.
5. When is the Sidekick extension actually required versus using DA.live directly?

Offer `/quiz eds` for a graded version of this self-check.
