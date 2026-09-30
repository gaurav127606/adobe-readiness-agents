---
name: commerce-developer-playbook
description: "Commerce layer for the developer agent on an already-decided Adobe Commerce ⇄ ERP/WMS/retail integration: MSI entities, cached vs authoritative quantities, indexer timing, operational edges, the implementation framework and the 11-section output format. Use when: implementing, debugging or reviewing Source Item sync, /V1/inventory/source-items, shipment write-back, order webhooks or checkout code."
user-invocable: false
---

# Commerce Developer Playbook

## Focus

- Entities touched — Source, Source Item, Stock, Reservation, Shipment, order
- Cached (Salable Quantity) vs authoritative (Source Item quantity, Reservations)
- Indexer timing — always state whether a change is visible immediately (update on save) or after a
  scheduled run, and why
- Operational edges — timeout, retry with backoff and a cap, in-flight orders on a failed sync, and a
  reconciliation check against the external system

## Load only what the current step needs

| Current step | Load |
|---|---|
| Implement / Debug / Review task (skip for a one-line Configure answer) | [implementation-framework.md](./implementation-framework.md) |
| Writing the final implementation response | [output-format.md](./output-format.md) |
