# Architect Mode — Output Format

The structure for a from-scratch commerce/ERP/WMS integration design. Not every section needs to
be long — a section with nothing material to add should say so in one line rather than being
skipped, so the reader can tell it was considered.

1. **Requirements** — the business/functional ask restated in the architect's own words, so the
   rest of the document is anchored to a shared understanding of what's being connected and why.
2. **Assumptions** — every fact treated as given but not actually confirmed by the user (order
   volume, SKU count, location count, freshness tolerance) — stated explicitly so they can be
   corrected.
3. **Discovery Questions** — the questions that would change the recommendation, asked (or noted
   as still open) rather than silently defaulted. See this playbook's discovery questions in `SKILL.md`.
4. **Systems Involved & Source of Truth** — which systems are in play (ERP, WMS, TMS, Adobe
   Commerce, 3PL) and which one owns which piece of data — this is usually the single most
   important thing to get right before anything else is designed.
5. **Integration Options** — the 2-3 real alternatives considered (see `decision-framework.md`).
6. **Recommended Approach** — the specific integration pattern recommended, stated plainly.
7. **Data Flow** — what moves between systems, in which direction, how often, and what triggers
   it (a GRN posting, an order placement, a scheduled batch window).
8. **Component Decisions** — the specific Adobe Commerce concepts involved (which Sources/Stocks
   are affected, whether Reservations or Shipments need updates) and any external-system
   components (queue, EDI processor, webhook consumer).
9. **Trade-offs** — why the recommended approach won on the stated requirements, and what it gives
   up relative to the alternatives.
10. **Failure Behavior** — what happens, concretely, when the external system is down, slow, or
    sends malformed/unexpected data — not just that it's "handled."
11. **Security Considerations** — auth between systems, data handling for any PII/payment-adjacent
    data crossing the integration, network exposure.
12. **Cost Considerations** — build effort, ongoing operational complexity, and any
    licensing/vendor cost drivers.
13. **Diagram** — a Mermaid diagram of the data flow/systems involved, when it clarifies more than
    prose alone would; skip if the integration is simple enough that a diagram adds no information.
14. **Open Questions / Risks** — anything still unresolved that the customer/stakeholder should
    answer before this design is treated as final.
15. **Final Recommendation** — the specific approach recommended, stated plainly in one place so
    it isn't buried in the surrounding analysis.
