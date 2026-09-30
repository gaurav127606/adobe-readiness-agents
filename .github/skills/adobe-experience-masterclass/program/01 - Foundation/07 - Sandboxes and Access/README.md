# Sandboxes and Access

**Track:** Foundation
**Goal:** Understand sandbox concept and purpose
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/journey-optimizer-learn/tutorials/access-control/create-and-manage-sandboxes

## Masterclass companion
This is an environments/governance topic rather than a spine stage, so it maps loosely to
**Module 04 — Schema Registry** (governance) in the AEP masterclass. Run `/define aep sandbox`.
Local: [04-schema-registry.md](../../../04-schema-registry.md)

## Primer (read before you watch)

**What you'll learn:** what a **sandbox** is, why AEP separates work into sandboxes, and how access
control (roles/permissions) is managed around them.

**Key concepts:**
- **Sandbox** — an isolated copy of the platform (its own schemas, datasets, profiles, journeys).
  It's the *container* everything else in this course runs inside.
- **Development vs. Production sandboxes** — build and test safely in a dev sandbox without touching
  live customer data or live journeys; promote to production when ready.
- Sandboxes share the same underlying platform but keep data and configuration isolated from each
  other.
- **Access control** — roles/permissions (often via Adobe Admin Console) decide who can view or edit
  schemas, profiles, journeys, and who can create/manage sandboxes.

**Common mistakes to avoid:** building or testing directly in production; assuming data in one
sandbox is visible in another (it isn't); over-granting permissions.

**Where it fits the spine:** cross-cutting — a sandbox is the *environment* the entire spine
(Ingest → … → Analyze) executes within. Get the environment/access model right before you build.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What is a sandbox, and why would you use a development sandbox?
2. If you ingest test data into a dev sandbox, does it appear in production? Why or why not?
3. Who typically manages sandbox creation and user permissions?
