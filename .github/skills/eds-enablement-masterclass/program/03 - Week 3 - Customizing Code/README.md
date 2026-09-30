# Week 3 — Customizing Code (Project Structure, Blocks & Config)

**Session:** Session 3 (2026-08-26, per the program roadmap)
**Goal:** Go from "I can publish a page" to "I can build and ship a real custom block" — project
structure, the `decorate(block)` lifecycle, section metadata, JSON-backed data, and the config files
that control redirects/headers/robots/ignored paths.
**Status:** Fully captured (slides + live demos), presented by the trainer.

## Resolving Week 2's "possible scope shift" flag

Week 2's README flagged a closing remark suggesting Session 3 might "shift focus to commerce
integration... drop-ins and advanced block setups for e-commerce scenarios." That did **not**
happen. Session 3 matches the **original roadmap framing** almost exactly — project structure,
`scripts.js`/`styles.css` conventions, and (going further than the roadmap slide promised) the full
block/`decorate()` development lifecycle. Commerce drop-ins are still just the Week 2 slide-level
intro; nothing commerce-specific was added this session.

## Why local dev uses branches, not Dev/QA/UAT tiers

EDS is serverless — there's no dedicated Dev, QA, or UAT environment to provision. Every Git branch
stands in for one instead:

```
Feature Branch (your changes) → <branch>--<repo>--<owner>.aem.page (verify your change)
                                        ↓ merge/PR
                                 main (production)
```

**Local setup (recap + new detail):**
1. Install Node.js.
2. `npm install -g @adobe/aem-cli` — a permissions error here is common; re-run with admin/sudo.
3. Clone your repo locally and check out the branch you're working on.
4. From the repo root, run `aem up` — starts a local server at `localhost:3000`.
5. **Live reload**: local file changes reflect instantly, no commit/push needed.

**`aem up` serves live content, local code (common mistake, called out explicitly):** `aem up`
serves your **code** locally, but not necessarily all **content** — it serves from a local
`content/` folder if one exists, and proxies anything missing from the `.aem.page` preview domain.
Don't assume `aem up` is a fully offline sandbox, and don't assume the content you see is
published/live — it may just be whatever's already been previewed.

**GitHub workflow basics:**
- **Never push directly to `main`** — protect it with required PR review.
- A PR's template requires both the **existing/live URL** and the **feature-branch preview URL** of
  the change — omit them and the PR itself gets flagged, not just frowned upon.
- Keep PR scope tight; use Draft PRs for work still in progress.
- The `aem-code-sync` bot comments on the PR with a Lighthouse-style table per page/viewport
  (Performance/A11y/SEO/Best Practices scores, plus SI/FCP/LCP/TBT/CLS metrics) — the same mechanic
  introduced in [Week 2](../02%20-%20Week%202%20-%20DA%20and%20Sidekick%20Deep-Dive/README.md), now
  reinforced as the default gate before every merge.

## Project anatomy, revisited

Buildless — runs straight from GitHub, no build step:

| Folder | Contents |
|---|---|
| `/scripts` | `scripts.js`, `aem.js` — eager/lazy/delayed loading phases |
| `/styles` | `styles.css` (LCP-critical) + `lazy-styles.css` |
| `/blocks` | `blockname/blockname.css` + `blockname.js` |
| `/icons` | SVGs, referenced in content as `:iconname:` |
| `/fonts` | font files |

**Block naming rule:** folder name = CSS class = CSS filename = JS filename — a mismatch causes a
real, visible rendering error. **Worth verifying live:** multiple sources this session suggested the
match may actually be case-insensitive (a capitalized block name in the doc still resolved) — this
would soften the strict "case-sensitive" caution carried over from Week 2. Treat as unconfirmed
until checked directly.

**Loading phases:** eager (first viewport, affects LCP) → lazy (post-initial-render/scroll) →
delayed (non-critical/third-party — analytics, auth).

## CSS/JS conventions for blocks

- **Scope every CSS selector to the block's own class** — prefix block-private classes/variables
  with the block name.
- **Mobile-first**: write unscoped CSS for mobile, add `min-width` breakpoints at 600/900/1200px —
  don't mix `min-` and `max-width`.
- **Avoid `!important`** almost entirely, and avoid complex/brittle selectors — add a class instead.
- **Don't adopt a CSS/JS framework**, preprocessor, or build tool without full team buy-in — the
  simplest answer is usually to stay buildless.
- **Minification verdict: don't bother** — code already ships in small, parallelized chunks per
  block, so the benefit is negligible while the cost (a build step, source maps) is real.
- **Protected core files:** don't edit `head.html` without a documented need — it carries the CSP
  meta tag, viewport meta, and the standard `aem.js`/`scripts.js`/`styles.css` references. Changes
  here (e.g. adding tracking code) can affect LCP or Lighthouse results.

## Why blocks exist, and how `decorate(block)` works

Document authoring can only ever generate divs and basic text elements — headings, paragraphs,
lists, pictures. There's no way to create a button, a form field, or any specialized UI element
through the document alone. Blocks exist so a developer can take that plain, auto-generated DOM and
manipulate or replace it into the real UI that's actually needed. Content authoring and block coding
happen **in parallel** — not sequentially like a typical AEM component-first workflow.

**Default DOM, before any code:** even before writing any JS, every table-as-block auto-generates a
parent div with its class set to the block name. One child div per row, and inside each row, one
child div per cell. A merged/single-cell row becomes one un-nested div for that entire row. This
default markup is exactly what `decorate()` reads and manipulates:

```html
<div class="eds-custom-block">
  <div>
    <div>Name</div>
    <div>Jane Doe</div>
  </div>
  <div>
    <div>EDS Enablements 2026</div>
  </div>
  <div>
    <div>Session-1</div>
    <div>Session-2</div>
    <div>Session-3</div>
    <div>Session-4</div>
  </div>
</div>
```

**DOM vs. markup:** the markup delivered from the server gets further augmented into a richer DOM
used for most dev tasks — wrapping in `section`/`default-content-wrapper`/`blockname-wrapper` divs
and adding CSS classes plus `data-block-name`/`data-block-status`/`data-section-status` attributes,
all used by the AEM block loader.

**The `decorate(block)` function:** every block's JS exports a default function named
`decorate(block)`, called automatically when the block loads. `block.children` gives you the row
divs; each row's own `.children` gives you its column/cell divs. Standard pattern: loop over rows,
then loop over columns inside each row, to read the authored content. Inside `decorate()`, replace
or manipulate those default divs into real elements — buttons, forms, whatever the UI needs.

```js
export default async function decorate(block) {
  [...block.children].forEach((row) => {
    [...row.children].forEach((cell) => {
      // read cell.textContent, replace with real markup
    });
  });
}
```

**Confirmed live (naming-rule enforcement):** a mismatch between folder/CSS class/CSS file/JS file
names produces a real console error and the block's JS fails to load — demoed directly in DevTools
on a `testing-block` example, distinct from the Week 2 "silent 404, no visible page error" framing;
worth reconciling once more live examples are seen.

## Sections, wrappers, and block variants

**Sections** are top-level containers under `<main>`, created when content is split with a section
splitter or the supported separator syntax. Each section can contain default content and one or
more blocks. EDS adds section and block wrapper classes, including block-container classes, usable
for styling while keeping block-specific selectors scoped.

**Block variant syntax** — variants go in parentheses after the block name in the document's table
header:
- Single word — `Columns (wide)` — becomes one additional class: `wide`.
- Multi-word — `Columns (super wide)` — becomes hyphenated: `super-wide`.
- Comma-separated — `Columns (dark, wide)` — becomes two separate classes: `dark wide`.
- The same comma/space rule applies to Section Metadata's `Style` field (below).

## Section Metadata

A special table (header row: "Section Metadata"), placed at the end of a section, scoped to just
that section — not the whole page.

- **`Style` row → classes**: the value adds one or more CSS classes to that section. Commas separate
  distinct class names; spaces within a name get hyphenated — same rule as block variants.
- **Any other row → data attribute**: e.g. `author` → `kanhaiya` becomes a `data-author="kanhaiya"`
  attribute on the rendered section — confirmed live in DevTools, readable by global or
  section-specific JS/CSS.
- **Use case**: mark a section as hero/product-grid/testimonial/etc. and target it individually,
  without forking the block implementation or creating a new block type per variant. Keeps blocks
  reusable while sections stay page-specific.
- Inserted in DA.live the same way as a block (Library → Blocks, or the block toolbar's "insert
  row"/"section" tools), sitting right above the `--- SECTION BREAK ---` divider.

## JSON data, pagination, and localization

**Spreadsheet → JSON rendition:** any spreadsheet-style content gets auto-exposed as JSON with
sheets/tabs, `total`, `offset`, `limit`, and a `data` array of records. `?sheet=<name>` selects a
specific tab (confirmed live: `?sheet=sec` filtered to just that sheet's rows); `offset`/`limit`
support pagination over large datasets.

**Placeholders:** placeholder sheets use a `Key` column plus a translated `Value`/`Text` column.
`fetchPlaceholders()` retrieves the relevant data; custom block logic then replaces authored keys
with the localized values.

**Localization pattern:**
- Structure content in per-language folders — e.g. `en/`, `fr/`.
- Use bulk metadata with wildcard URL patterns (`/en/**`, `/fr/**`) to tag each language's pages
  with custom metadata.
- Placeholders can be split per-locale too — pass the page's locale metadata into
  `fetchPlaceholders()` to pull the right language sheet.
- **Real gotcha:** a placeholder sheet's human-readable `Key` column gets normalized into a
  camelCase-style property name in code — guess that transformation wrong and the lookup silently
  returns nothing. No error, just a missing string.

**Block Library reuse:** project docs/library files can expose ready-made block templates through
the DA.live authoring UI (Library → Blocks). Authors insert a predefined structure; developers adapt
the implementation as needed.

## Redirects, headers, robots, and hidden files

- **Redirects**: defined in a root-level redirect file/sheet (source → destination columns). A
  redirect takes precedence **even when the source page still exists** — so the file has to be kept
  accurate and free of unintended entries. Destinations can point to another site or path.
- **Custom headers**: configured via the site config interface (`tools.aem.live` → HTTP Headers
  Editor) and a `headers.json` file. A path pattern identifies which resources receive the header;
  the configured key-value pair is returned in the actual response — confirmed live via browser
  Network tools (a `Test: good` header showed up on the real response).
- **Robots and indexing**: robots behavior applies differently across production vs. preview —
  no-crawl is recommended on preview (`.aem.page`/`.aem.live` always force disallow-all regardless
  of `robots.txt`, per Week 1). Sitemap/indexing tooling exists in EDS's admin tools, but the
  presenter noted they were still reviewing the current setup details — treat as **not yet confirmed**.
- **`.hlxignore`**: a `.gitignore`-style file that keeps selected repo files/paths from becoming
  publicly reachable through the site URL — e.g. `.*`, `*.md`, `karma.config.js`, `LICENSE`,
  `package.json`, `package-lock.json`, `test/*`. Use it for technical files that shouldn't be
  exposed.
- **Admin Tools surface** (`tools.aem.live`): Site Admin, User Admin, CDN Setup, Index Admin,
  Sitemap Admin, Robots.txt Editor, HTTP Headers Editor, Simple Config Editor, plus Publish & Manage
  tools (Bulk Operations, Page Status, Snapshot Admin).

## Sidekick custom extensions

A custom **"My Assets"** Sidekick action was demoed as a workaround for accessing assets stored in
an AEM asset library: an author opens the asset location, signs in, copies the required content, and
pastes it into DA.live — instead of repeatedly navigating the asset repository manually.

**Plugin configuration** lives in `tools/sidekick/config.json` — each plugin entry sets a name,
target host, environment visibility, a fixed URL, and panel-vs-popup placement. **Caution called out
explicitly:** environment visibility should be scoped carefully so development/workaround tools
don't unintentionally appear in production.

## Links

- Anatomy of a project: https://www.aem.live/developer/anatomy-of-a-project

## Masterclass companion

Partial coverage. Project anatomy and the block-naming rule were already folded into
[Module 4](../../04-hands-on-setup-and-code-sync.md); metadata/placeholders basics into
[Module 5](../../05-da-live-authoring-and-publishing.md). Everything else this week is new and
not yet in any module: the full `decorate(block)` lifecycle, section metadata, block variants,
JSON/pagination endpoints, the localization key-normalization gotcha, redirects/headers/robots/
`.hlxignore`, and Sidekick custom extension config. Flagging for a future module (block development
was originally slated as its own Week 4 module — this session already covers most of that ground).

## Your notes

_(fill in once you complete any hands-on practice for this week — key takeaways, screenshots,
questions)_

## Self-check

1. Why does EDS use Git branches instead of dedicated Dev/QA/UAT environments?
2. What's the difference between what `aem up` serves for code versus what it serves for content?
3. Walk through what `block.children` and a row's `.children` give you inside `decorate(block)`.
4. A block is authored as `Columns (dark, wide)`. What classes does the rendered block end up with?
5. What's the difference between a Section Metadata `Style` row and any other row in that table?
6. Why can a correctly-spelled placeholder `Key` still silently fail to resolve to its translated value?
7. Why does a redirect rule take precedence even if the source page still exists?

Offer `/quiz eds` for a graded version of this self-check.
