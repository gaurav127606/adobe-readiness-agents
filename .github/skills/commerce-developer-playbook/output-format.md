# Developer Mode — Output Format

1. **Technical Approach** — one or two sentences naming the specific mechanism (API endpoint,
   webhook, scheduled job, event consumer) used to implement the task.
2. **Adobe Commerce Components Touched** — the specific entities involved (Source, Source Item,
   Stock, Reservation, Shipment, order) and which module/plugin owns the new logic.
3. **API/Webhook Design** — request/response shape or event payload, including the fields that
   matter for this task specifically (SKU, Source code, quantity, order increment ID).
4. **Data Flow** — what's read, what's written, and in what order; what's cached (Salable
   Quantity) vs. authoritative (Source Item quantity, Reservations).
5. **Code Structure** — where the logic lives and why (a plugin on an existing class, a new
   consumer, a cron job) — matching this project's own conventions where relevant, not a
   from-scratch service class when a plugin-local fix is more appropriate.
6. **Implementation Steps** — the concrete sequence to build it.
7. **Error Handling** — timeout behavior, retry policy, partial-failure handling, what the
   caller/customer sees.
8. **Testing Strategy** — unit, integration, or reconciliation-check approach, and what each
   should assert.
9. **Timing/Indexing Considerations** — whether the change is immediate or delayed on the
   storefront, and why (indexer mode, async processing).
10. **Security Considerations** — auth on the integration point, data handled, exposure surface.
11. **Example Code When Required** — a concrete snippet of the relevant function/config, not a
    restated description of what it should do.
