# Developer Mode — Implementation Framework

A step-by-step framework for turning "implement X integration with Adobe Commerce" into concrete,
usable guidance instead of a restated architecture description.

## Step 1 — Identify the specific integration point and the concrete task

Name the exact Adobe Commerce concept involved (Source Item sync, Shipment write-back, order
webhook, BOM/kit modeling) and classify the task as one of:

- **Implement** — build a new piece of integration functionality (e.g. "implement the Source Item
  quantity sync from our WMS feed")
- **Configure** — set/tune a specific setting (e.g. "configure Stock source priority for
  BOPIS fulfillment")
- **Debug** — diagnose why something is broken or behaving unexpectedly (e.g. "why does the
  storefront still show the old quantity after the WMS sync ran")
- **Review** — check existing integration code/config against known good practice before shipping

The classification changes the shape of the answer: Implement needs code structure and steps,
Configure needs the actual setting and its consequences, Debug needs a diagnostic path before a
fix, Review needs a checklist walk-through against common mistakes.

## Step 2 — Pull from the right glossary sections

Use `erp-wms-glossary/adobe-commerce-integration-points.md` for the Adobe Commerce concept mapping
(Source, Source Item, Stock, Salable Quantity, Reservation, Shipment) — that file is
implementation-facing by design. Use `retail-glossary/ecommerce-order-lifecycle.md` for the
quote/cart/order vocabulary if the task touches checkout rather than pure inventory.

Do not re-run the glossary's "conversation-ready framing" discovery questions — those are
Architect-mode's job; the integration approach is already decided by the time this mode is active.

## Step 3 — Give the actual code/API/config, not a description of it

The deliverable is something the developer can paste, run, or configure, not a description of what
they should do. Concretely:

- Bad: "Sync the WMS's inventory data into Adobe Commerce's inventory system."
- Good: name the specific mechanism (e.g. a scheduled consumer calling
  `POST /V1/inventory/source-items` with the SKU/Source/quantity payload, or an async bulk API call
  if volume requires batching), the plugin/module it lives in, and the specific error handling
  around a partial-batch failure.

- Bad: "Handle the case where the WMS is unavailable."
- Good: the actual retry/circuit-breaker behavior, what happens to Salable Quantity during the
  outage (does the last-known Source Item value hold, or does something get flagged
  unavailable), and what's logged/alerted on.

## Step 4 — Always address indexing/timing explicitly

This is the most common Adobe-Commerce-specific gap in an otherwise-correct integration answer:
updating a Source Item's quantity does not necessarily mean the storefront reflects it
immediately — it depends on the relevant indexer's mode (update on save vs. scheduled). Every
Implement/Debug answer touching inventory or pricing must state whether the change is expected to
be immediate or delayed, and why.

## Step 5 — Ask for a missing fact only if it changes the recommendation materially

Do not run Architect mode's discovery list. If the concrete answer depends on exactly one fact
that isn't in the conversation (e.g. whether the WMS sends a full snapshot or a delta on each
sync — which changes whether the handler should overwrite or increment quantity), ask for that one
thing and explain why it matters.

## Step 6 — Include the operational edges even in a code-level answer

Every Implement/Debug answer should touch: timeout behavior on the external call, retry policy
(with backoff and a cap), what happens to in-progress orders if a sync fails mid-way, and what's
tested for it (unit test for the handler logic, integration test against a stubbed external
system, or a manual reconciliation check comparing Adobe Commerce quantities against the WMS's own
report).
