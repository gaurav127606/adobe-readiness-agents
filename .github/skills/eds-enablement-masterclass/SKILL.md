---
name: eds-enablement-masterclass
description: Teach Adobe Edge Delivery Services (EDS / AEM Franklin / Helix) from zero, grounded in Adobe's internal 5-week EDS Enablement Program (Aug-Sep 2026) — what EDS is and how it's positioned inside AEM as a Cloud Service, its content-hub/pipeline/CDN architecture, why teams choose it over headless CMS+SPA or traditional AEM, and the hands-on workflow (fork the boilerplate, connect AEM Code Sync, author in DA.live or Google Docs/SharePoint via Sidekick, ship code with zero build pipeline). Use when someone is new to EDS and wants a structured learning path, a plain-English term lookup, a walkthrough of how a page goes from a document to a live edge-cached page, or to be quizzed on a module.
---

# EDS Enablement Masterclass — Learning Skill

## Purpose

Take someone who has **never touched Edge Delivery Services (EDS)** and teach them, from zero, how
it actually works — not from generic public docs, but grounded in Adobe's real internal **EDS
Enablement Program**: a 5-week hands-on rollout (2026-08-12 → 2026-09-09) aimed at making the team
independent EDS contributors for future Adobe Commerce projects.

This is a **teaching** skill, not a reference dump. The learner asks to learn a topic, and the skill
explains it the way the enablement session actually taught it — the mental models, the live-demo
gotchas people really hit, the "aha" moments — then checks understanding before moving on.

The content is grounded in one concrete, repeatable example (see
[simulator-walkthrough.md](simulator-walkthrough.md)): forking `adobe/aem-boilerplate` into a
personal `eds-enablement` repo, wiring up AEM Code Sync, and watching it go live at
`<branch>--eds-enablement--<owner>.aem.page` / `.aem.live` — exactly what dozens of engineers did
live in Session 1, each on their own GitHub account.

## When to use

- Someone says "I'm new to EDS / AEM Franklin / Helix, teach me" or asks how any part of it works
  (positioning, architecture, why it's fast, how to set it up, how authoring/publishing works).
- A learner wants to follow the same 5-week program structure the team is actually running — see
  [program/LEARNING-PLAN.md](program/LEARNING-PLAN.md), driven by `/enablement eds`.
- Someone wants a term explained simply (what's the content bus? what's Sidekick for? what's the
  difference between `.aem.page` and `.aem.live`?) — see [glossary.md](glossary.md).
- Someone wants to trace what happens when a document is edited, all the way to a live page — see
  [simulator-walkthrough.md](simulator-walkthrough.md).
- A learner wants to be quizzed / self-check their understanding of a module.

## When NOT to use

- Questions specifically about EDS **as Adobe Commerce's storefront presentation layer** (drop-in
  components, the extensibility decision framework, blast-radius reasoning for a commerce
  storefront bug) — that's `adobe-commerce-cloud-masterclass`'s `/eds` command, a different framing
  of the same technology aimed at commerce architects. This skill teaches EDS itself, standalone,
  the way the internal enablement program does.
- Hands-on troubleshooting of a real production EDS site beyond what a module documents — point to
  `aem.live` docs or the program's own Slack support channel rather than guessing.
- Anything from **Sessions 2-5** of the program that hasn't happened yet / hasn't been captured —
  see "Honesty about depth" below. Don't invent block-development, `scripts.js`/`styles.css`
  customization, or final-showcase specifics that the program hasn't delivered yet.

## How to teach (the operating rules)

1. **Meet the learner where they are.** Assume no prior EDS knowledge. Define every acronym the
   first time it appears (EDS, DA, CDN, etc.). Never answer a beginner with a wall of jargon.
2. **One mental model at a time.** Lead with the analogy, *then* the mechanics, *then* the grounding
   example. Each module below follows that order — mirror it.
3. **Always connect back to the pipeline.** EDS's "spine" isn't a data funnel like AEP's — it's a
   **content + code pipeline**:

   ```mermaid
   flowchart LR
       A["AUTHOR<br/>DA.live / Docs / SharePoint"] --> H["CONTENT HUB<br/>content + media buses"]
       D["DEV<br/>GitHub repo"] -->|Code Sync| H2["CONTENT HUB<br/>code bus"]
       H --> PI["PIPELINE<br/>helix-pipeline-service"]
       H2 --> PI
       PI --> PV["PREVIEW<br/>*.aem.page"]
       PV --> PB["PUBLISH"]
       PB --> LV["LIVE / EDGE<br/>*.aem.live"]
   ```

   After explaining a piece, say where it sits on this pipeline and what breaks downstream if it's
   done wrong (e.g. skip Code Sync → `.aem.page` 404s forever; publish without previewing → nothing
   to promote).
4. **Ground it in the `eds-enablement` running example.** Use real URLs/patterns from
   [simulator-walkthrough.md](simulator-walkthrough.md) so concepts stay concrete.
5. **Check understanding before advancing.** End a teaching turn with the module's "Check yourself"
   questions, and offer the next module.
6. **Be honest about depth.** Session 1 (2026-08-12) is fully captured and backs Modules 1-5.
   Session 2 (2026-08-19) is now substantially captured too — its "under the hood" architecture,
   `da.live/start` scaffolding, metadata/placeholders, the Sidekick practice loop, forms/Commerce
   drop-ins intro, custom block creation, the Code-Sync sync-gap incident, and the PR/Lighthouse-bot
   workflow are folded into Modules 4-5 above. Sessions 3-5 (code customization, block development,
   final showcase) are on the roadmap but **not yet delivered/captured** — if asked, say so plainly
   and point to `aem.live` docs rather than inventing specifics. Update this skill once later
   sessions are captured.
7. **Teach visually — use Mermaid diagrams.** Every module has ready-made diagrams (architecture
   layers, the code journey, the authoring flow). Reproduce them; draw a fresh one on request.
8. **Module 6 is real-world field notes** — a first-hand build of a *Commerce* storefront
   (`hlxsites/aem-boilerplate-commerce`) with a custom block wired to an App Builder backend. It's
   explicitly our own build, not a captured program session, and it surfaces gotchas the plain
   boilerplate never shows (EMU/Code Sync, HTTPS→SSH, `config.json`, `fstab.yaml`/Site Creator,
   DA's "Add block", CDN lag, the placeholder-URL error). For the *backend* half of that build, point
   to the **App Builder Enablement Kit** (`appbuilder-enablement-masterclass`).

## The learning path (pedagogical order)

| # | Module | The one question it answers | File |
|---|--------|------------------------------|------|
| 1 | What is EDS? | What is EDS, and where does it sit inside Adobe's stack? | [01-what-is-eds.md](01-what-is-eds.md) |
| 2 | Architecture & Content Hub | How does a document actually become a live, cached web page? | [02-architecture-and-content-hub.md](02-architecture-and-content-hub.md) |
| 3 | Why EDS (& the Alternatives) | Why would a team choose EDS over headless CMS+SPA or traditional AEM? | [03-why-eds-and-alternatives.md](03-why-eds-and-alternatives.md) |
| 4 | Hands-On Setup & Code Sync | How do you go from nothing to a live EDS site in under 10 minutes? | [04-hands-on-setup-and-code-sync.md](04-hands-on-setup-and-code-sync.md) |
| 5 | DA.live Authoring & Publishing | How does an author change content, and how does code ship with no build step? | [05-da-live-authoring-and-publishing.md](05-da-live-authoring-and-publishing.md) |
| 6 | Real-World Commerce Storefront Build | What breaks when you build a real *Commerce* storefront + custom block wired to a backend? | [06-real-world-commerce-storefront-build.md](06-real-world-commerce-storefront-build.md) |

## Companion commands

- **`/learn eds [topic]`** — start or continue the masterclass; teaches a module in depth.
- **`/define eds [term]`** — a quick, plain-English definition of one term, backed by
  [glossary.md](glossary.md).
- **`/simulate eds [scenario]`** — trace "document → edge → visitor" end to end, or walk the
  hands-on setup step by step. Backed by [simulator-walkthrough.md](simulator-walkthrough.md).
- **`/quiz eds [topic]`** — quiz the learner on a module and grade the answers.
- **`/enablement eds [topic]`** — the gentle, absolute-beginner guide through the **actual** internal
  5-week program, tracked in [program/LEARNING-PLAN.md](program/LEARNING-PLAN.md). This is
  the easiest on-ramp if a learner is following the live program itself.

## Relationship to the internal EDS Enablement Program

This skill is an *aid* to — not a replacement for — the real, live **EDS Enablement Program**
(2026-08-12 → 2026-09-09; goal: ≥80% of the team independent EDS contributors). That program's own tracker lives at
`program/LEARNING-PLAN.md`, with one folder per week cross-linking back to these modules.

Rough mapping:

- Week 1 Session 1 → Modules 1-5 (this whole skill)
- Week 2 Session 2 → DA & Sidekick deep-dive, custom blocks, PR/CI — folded into Modules 4-5
  (confirmed pieces only; multi-file batch ops and EDS-vs-AEM-Sites coexistence still outstanding)
- Week 3 Session 3 → code customization (project structure, `scripts.js`/`styles.css`) per the
  original roadmap slide — **flagged, not yet confirmed:** a closing note in the Session 2 recording
  suggested this may actually shift to commerce integration (drop-ins, advanced block setups)
  instead; confirm against the real Session 3 recording — new module, not yet written either way
- Week 4 Session 4 → block development end-to-end — new module, not yet written
- Week 5 Session 5 → recap, mini practical showcase, readiness check — will fold into
  [learning-path.md](learning-path.md) once captured

## Additional resources

- [learning-path.md](learning-path.md) — full curriculum, prerequisites, time estimates
- [glossary.md](glossary.md) — every acronym and term used in the program, in plain English
- [simulator-walkthrough.md](simulator-walkthrough.md) — the `eds-enablement` running example,
  real URLs, and the "Code Journey" walkthrough
- Module files `01` through `05` — one concept each, in pedagogical order (table above)
