# Warehouse Operations Terms

Vocabulary for how a physical warehouse actually moves goods: picking orders, storing product,
and staffing/automating the work.

## Order fulfillment / picking strategies

- **Order fulfillment** — the end-to-end process of picking, packing, and shipping products to
  satisfy a customer order; treated as the "heartbeat" of warehouse operations because it's the
  step customers directly experience (speed and accuracy here drive satisfaction).
- **Batch picking** — grouping multiple orders containing similar/overlapping products so a picker
  collects for several orders in a single pass through the warehouse, cutting travel time versus
  picking one order at a time.
- **Zone picking** — dividing the warehouse into zones (each covering specific products/
  categories), with pickers assigned to a zone rather than roaming the whole facility; picked
  items from each zone are consolidated afterward for packing. Reduces travel distance and
  congestion.
- **Wave picking** — organizing orders into scheduled "waves" (grouped by criteria like
  destination, delivery urgency, or product type) so picking, packing, and shipping proceed in
  coordinated batches — useful for handling high order volume during peak periods without
  overwhelming any single stage of the pipeline.
- **Cross-docking** — receiving goods and immediately transferring them to outbound shipping with
  minimal or no intermediate storage, bypassing put-away entirely. Cuts handling time and storage
  cost but requires tight inbound/outbound schedule coordination.

## Storage & space utilization

- **Pallet racks** — the standard vertical storage structure holding palletized goods on
  multiple shelf levels, maximizing use of a warehouse's height rather than just its floor area.
  Variants include selective racks (direct access to any pallet), drive-in racks, and push-back
  racks — the choice depends on whether individual-pallet access or storage density matters more.
- **Cantilever racks** — racking with arms extending from vertical columns instead of enclosed
  shelves, used for long, bulky, or irregularly shaped items (pipe, lumber, furniture) that don't
  fit standard shelving.
- **Drive-in racks** — high-density racking where forklifts drive directly into the rack structure
  along rails; new pallets push existing ones further in, so retrieval is Last-In-First-Out
  (LIFO). Maximizes storage density (no aisles needed between racks) at the cost of only being
  practical for large batches of the same SKU, since older stock isn't reachable until newer
  stock in front of it is cleared.
- **LIFO vs FIFO (vs FEFO)** — LIFO (Last-In-First-Out) retrieves the most recently stored item
  first (a consequence of drive-in racking, not usually a deliberate choice for the goods
  themselves); FIFO (First-In-First-Out) retrieves oldest stock first, standard for most goods to
  avoid obsolescence; FEFO (First-Expired-First-Out) prioritizes by expiration date rather than
  receipt date, required for perishables where a later-received batch might expire sooner.

## Labor & automation

- **Labor management** — staffing, training, and performance-tracking practices for warehouse
  employees; treated as a first-class operational concern because picking/packing accuracy and
  speed are still substantially human-driven even in automated warehouses.
- **Automated Guided Vehicle (AGV)** — a self-navigating vehicle (sensor + control system guided,
  no human driver) that moves goods between fixed points in a warehouse (storage, picking
  stations, shipping docks) along predetermined paths.
- **Robotic arms** — programmable robots performing picking, packing, stacking, or palletizing
  tasks, typically working alongside (not fully replacing) human staff — most valuable in
  high-volume e-commerce fulfillment where repetitive precise handling at speed matters.
- **Conveyor systems** — motorized belts/rollers/chains moving goods between fixed process stages
  (receiving → picking → packing → shipping) without manual carrying, freeing staff to focus on
  tasks that still require judgment (quality checks, labeling).
- **Labor KPIs** — the metrics used to track warehouse workforce performance: order picking speed,
  pick accuracy rate, inventory turnover, and order fulfillment time are the standard set;
  real-time tracking of these against benchmarks is what "labor management" concretely means in
  practice, not just headcount planning.

## Related files

- [inventory-management-terms.md](inventory-management-terms.md) — what's being stored/picked, and
  why in those quantities
- [supply-chain-visibility-terms.md](supply-chain-visibility-terms.md) — how these operations feed
  visibility upstream
- [wms-erp-systems-terms.md](wms-erp-systems-terms.md) — the software coordinating all of the above
- [adobe-commerce-integration-points.md](adobe-commerce-integration-points.md) — how fulfillment
  status here maps back to an Adobe Commerce order
- [acronyms.md](acronyms.md) — quick acronym lookup
