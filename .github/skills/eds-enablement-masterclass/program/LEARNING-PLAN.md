# EDS Enablement Program — Learning Plan

Source: the internal EDS Enablement Program.

**Target:** ≥80% of the team independent EDS contributors, ready to work on future Adobe Commerce
projects (EDS pairs with ACCS — Adobe Commerce as a Cloud Service).
**Duration:** 5 weeks, 2026-08-12 → 2026-09-09, one live session per week. Sessions are recorded for
anyone who misses the live session. Attendance is expected.

## Roadmap

| # | Week of | Session | Focus | Status | Folder |
|---|---------|---------|-------|--------|--------|
| 1 | 2026-08-12 | Session 1 | Intro, architecture deep-dive, Install/Setup/Publish, Code Sync (live) | Not started | [01 - Week 1 - Introduction, Architecture and Setup](01%20-%20Week%201%20-%20Introduction%2C%20Architecture%20and%20Setup) |
| 2 | 2026-08-19 | Session 2 | DA & Sidekick deep-dive + first custom block + PR/CI workflow (hands-on practice) | Not started | [02 - Week 2 - DA and Sidekick Deep-Dive](02%20-%20Week%202%20-%20DA%20and%20Sidekick%20Deep-Dive) |
| 3 | 2026-08-26 | Session 3 | How to customize code — project structure, `scripts.js`/`styles.css` | Not started | [03 - Week 3 - Customizing Code](03%20-%20Week%203%20-%20Customizing%20Code) |
| 4 | 2026-09-02 | Session 4 | Commerce Storefront — drop-ins, GraphQL/REST, and the Commerce page-load flow | Not started | [04 - Week 4 - Blocks and CSS](04%20-%20Week%204%20-%20Blocks%20and%20CSS) |
| 5 | 2026-09-09 | Session 5 | Drop-in customization (Extend/Substitute/Create, slots, events, tokens), config-service go-live fix, SEO/limits checklist | Done | [05 - Week 5 - Recap and Showcase](05%20-%20Week%205%20-%20Recap%20and%20Showcase) |

> Weeks 2-5 folders are intentionally lightweight stubs — topic and goal only, taken from the
> program's own roadmap slide. They'll be fleshed out with real primers, links, and self-checks as
> each live session happens and gets captured, the same way Week 1 was built from Session 1's actual
> slides, PDF guide, and live-discussion transcript.

> **Flag resolved:** a closing note in the Session 2 recording said a future session would shift
> focus to "commerce integration... drop-ins and advanced block setups for e-commerce scenarios."
> Week 3's README initially resolved this as "did not happen in Session 3" — correct, but only
> because it happened one session later instead: **Session 4** is exactly this commerce-integration
> pivot (Commerce Storefront, drop-ins, GraphQL/REST). See [Week 4's
> README](04%20-%20Week%204%20-%20Blocks%20and%20CSS/README.md#resolving-week-2s-possible-scope-shift-flag--take-two).

## How to use this repo

- Each week's folder has a `README.md` with the goal, a **Primer**, a **Masterclass companion**
  cross-link into the `eds-enablement-masterclass` skill, a **Your notes** section, and a
  **Self-check**.
- Update the `Status` column here (Not started → In progress → Done) as you progress.

## Easiest way to start — the `/enablement eds` command

Brand new and not sure where to begin? Just run **`/enablement eds`** (no arguments) in GitHub Copilot Chat.
It welcomes you, checks your Status here, and walks you through **one week at a time** in order —
reading the primer, pointing you to the masterclass module, quizzing you, and updating your Status
when you're done. Jump to a specific week with `/enablement eds architecture`,
`/enablement eds sidekick`, etc.

## Optional companion — EDS Enablement Masterclass skill

Each week's README cross-links to matching modules in the **EDS Enablement Masterclass**
Copilot skill (`eds-enablement-masterclass`) that adds plain-English explanations, Mermaid
diagrams, and quizzes, grounded in the same real program content. It's an *aid*, not a replacement
for the live sessions and their recordings. Handy commands:

- `/learn eds <topic>` — teach a module in depth
- `/define eds <term>` — quick glossary lookup
- `/simulate eds <scenario>` — trace a document/code change through the pipeline, or walk the setup
  demo step by step
- `/quiz eds <topic>` — quiz + grade
