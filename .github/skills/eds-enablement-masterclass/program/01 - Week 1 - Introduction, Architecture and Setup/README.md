# Week 1 — Introduction, Architecture & Setup

**Session:** Session 1 (2026-08-12)
**Goal:** Understand what EDS is and how it's architected, and leave with your own live EDS site.
**Status:** Done — fully captured (slides, written PDF guide, and live-discussion transcript)

## Links (official, used live in the session)

- Developer tutorial: https://www.aem.live/developer/tutorial
- Sidekick docs: https://www.aem.live/docs/sidekick
- Boilerplate template: https://github.com/adobe/aem-boilerplate
- AEM Code Sync app: https://github.com/apps/aem-code-sync
- Local development reference: https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/edge-delivery-services/developing/local-development
- Why was this renamed from Helix/Franklin to EDS: https://www.aem.live/docs/faq#why-was-this-site-renamed-from-helix-to-franklin-to-edge-delivery-services
- Is EDS a headless CMS like AEM: https://www.aem.live/docs/faq#is-edge-delivery-services-a-headless-cms-like-aem
- Content velocity metric: https://experienceleague.adobe.com/en/docs/analytics/components/metrics/content-velocity

## Masterclass companion

Deeper explanation and Mermaid diagrams: **Modules 1-5** in the `eds-enablement-masterclass` skill.
Run `/learn eds` (starts from the top) or jump straight in with `/define eds <term>`.

Local:
[01-what-is-eds.md](../../01-what-is-eds.md) ·
[02-architecture-and-content-hub.md](../../02-architecture-and-content-hub.md) ·
[03-why-eds-and-alternatives.md](../../03-why-eds-and-alternatives.md) ·
[04-hands-on-setup-and-code-sync.md](../../04-hands-on-setup-and-code-sync.md) ·
[05-da-live-authoring-and-publishing.md](../../05-da-live-authoring-and-publishing.md)

## Primer (read before you watch the recording)

**What you'll learn:** what EDS actually is, how it's positioned inside Adobe's stack, how a
document becomes a live page, why teams choose it, and how to get your own site live in under 10
minutes.

**Key concepts:**
- EDS (aka AEM Franklin/Helix, aka "document-based authoring") is a **module inside AEM as a Cloud
  Service — not a standalone Adobe product.** You don't need AEM Author to use it.
- Architecture is a **content + code pipeline**: Author/Dev → Content Hub (content/media/code
  buses) → `helix-pipeline-service` → Preview (`*.aem.page`, uncached) → Publish → Live
  (`*.aem.live`, cached).
- The headline pitch: **no build pipeline, sub-second loads, 100 Lighthouse as the baseline**, not
  a stretch goal — because caching and 3-phase (eager/lazy/delayed) loading are architectural, not
  configured.
- Getting live needs exactly two things: a GitHub repo forked from `adobe/aem-boilerplate`, and the
  **AEM Code Sync** app connected to it. Skip Code Sync and your preview URL 404s forever.
- Authoring happens in **DA.live** (or Google Docs/SharePoint via **Sidekick**); publishing is a
  separate deliberate step from previewing, and a hard reload is often needed to see changes.

**Common mistakes to avoid (these actually happened live):**
- Node version mismatches — check `node -v` is 18+ before anything else.
- Confusing which GitHub account/org owns the new repo when creating it from the template.
- Installing Code Sync but forgetting to scope it to "Only select repositories" and pick your repo.
- Assuming a published-looking change is live without a hard reload.
- Assuming EDS's speed is a setting you tune, rather than an architectural default.
- Typo'ing the repo name or GitHub owner in the `.aem.page`/`.aem.live` URL — EDS builds the URL
  directly from `<branch>--<repo-name>--<owner>`, so any mismatch (even one swapped letter, e.g.
  "enabelment" vs "enablement") 404s silently with no helpful error.
- Installing `@adobe/aem-cli` globally with `npm install -g` while nvm is still on an old Node
  version — nvm keeps a separate global `node_modules` per Node version, so switching to Node 18+
  afterward doesn't move the CLI with you. `aem up` then crashes citing a Node version requirement
  even though `node -v` looks correct. Fix: `nvm use <18+>` first, *then* reinstall the CLI.

**Where it fits the pipeline:** this week covers the *entire* pipeline end to end — it's the
foundation every later week (customizing code, building blocks) builds directly on top of.

## Your notes

The learner ran the full hands-on setup end-to-end on 2026-08-26 (forked `eds-enabelment` under
their own GitHub account, Code Sync, DA.live edit → Preview → Publish → Live, then local `aem up`)
and confirmed every stage works. Two real blockers hit and corrected live, now folded into "Common
mistakes to avoid" above: a repo-name/owner typo in the `.aem.page` URL causing a silent 404, and
`aem up` crashing because the CLI had been installed globally under an old Node version via nvm.

## Self-check

1. True or false: EDS is a standalone Adobe product like Commerce or Target. Justify your answer.
2. Name the three buses in the Content Hub and what each one carries.
3. What are the two things you truly need before you have a live EDS site?
4. You just forked the boilerplate and your `.aem.page` URL 404s. What's the single most likely
   missing step?
5. Why is "100 Lighthouse score" described as a baseline expectation, not a stretch goal?
6. When is Sidekick actually required, and when is it unnecessary?

Offer `/quiz eds` for a graded version of this self-check.
