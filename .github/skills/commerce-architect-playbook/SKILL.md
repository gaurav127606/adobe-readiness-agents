---
name: commerce-architect-playbook
description: "Commerce layer for the architect agent on Adobe Commerce ⇄ ERP/WMS/3PL/retail integrations: source-of-truth and freshness focus, the commerce discovery questions, the 5-step decision framework (EDI/batch vs message queue vs direct API) and the 15-section output format. Use when: designing or scoping an Adobe Commerce inventory, order, shipment or retail integration."
user-invocable: false
---

# Commerce Architect Playbook

## Focus

- Source of truth for inventory, price and order status (ERP vs WMS) — Source Items are fed from exactly one
- Freshness tolerance before stale data causes oversell, a wrong price or a stuck order
- Volume shape — orders/day, SKU count, location count, peaks
- Failure behavior when the ERP/WMS is down, slow or sends malformed data

## Discovery questions (ask only what's unanswered and would change the recommendation)

- Is the WMS or the ERP the source of truth for on-hand inventory? (Decides what feeds Source Items.)
- Real-time sync, or is a scheduled batch (hourly/nightly) acceptable?
- How many Sources (warehouses/stores/3PLs), and is fulfillment-priority logic needed across them?
- Does the customer need customer-visible shipment tracking, or is WMS-side tracking enough?
- On a sync failure, should the last-known-good state hold, or is "temporarily unavailable" acceptable?

## Load only what the current step needs

| Current step | Load |
|---|---|
| Comparing 2-3 integration approaches and picking one | [decision-framework.md](./decision-framework.md) |
| Writing the final design response | [output-format.md](./output-format.md) |
