# Inventory Management Terms

Core vocabulary for how businesses decide what to stock, how much, and how they track it.

## Core identifiers & records

- **SKU (Stock Keeping Unit)** — a unique identifier for one specific sellable variant of a
  product. Inventory management operates at the SKU level, not the "product" level — two sizes
  of the same shirt are two different SKUs with independently tracked quantities.
- **Bill of Materials (BOM)** — a structured list of the raw materials, components, and
  sub-assemblies required to manufacture or assemble a finished product, including quantities. A
  BOM is the recipe; inventory management ensures the ingredients (components) are on hand to
  fulfill it. Relevant whenever a "kit" or "bundle" product is assembled from components tracked
  as separate inventory.
- **Goods Received Note (GRN)** — the document/record created when a shipment physically arrives
  at a warehouse, confirming what was actually received against what was ordered (the purchase
  order) and what the supplier said was shipped (the ASN — see
  [wms-erp-systems-terms.md](wms-erp-systems-terms.md)). A GRN is the trigger that turns "incoming
  goods" into "on-hand inventory" in the system, and discrepancies here (received qty ≠ ordered
  qty ≠ ASN qty) are a primary source of inventory-accuracy problems.
- **Purchase Order (PO)** — a buyer's formal request to a supplier to deliver a specified quantity
  of goods; the GRN reconciles against the PO on receipt.

## Inventory strategies

- **Just-In-Time (JIT)** — an inventory strategy that minimizes on-hand stock by timing deliveries
  to arrive right when needed for production or sale, reducing holding costs at the expense of
  requiring very reliable, tightly coordinated suppliers.
- **ABC analysis** — a classification method that buckets inventory into three tiers by
  business significance: A (high-value/high-priority, tight control), B (moderate), C (low-value,
  loose control) — so limited attention/control effort goes where it matters most.
- **Safety stock (SSTK)** — a buffer quantity held above expected demand to absorb variability in
  either demand or supplier lead time, preventing stockouts without carrying excessive inventory.
- **Reorder point** — the on-hand quantity level that triggers a new purchase/replenishment order,
  calculated from expected demand during lead time plus safety stock.
- **Replenishment** — the (often automated) process of reordering stock based on sales velocity
  and target inventory levels — see also "Demand-driven replenishment," a strategy where
  replenishment quantities/timing respond to actual observed demand signals rather than a fixed
  schedule or forecast alone.
- **Bulk shipments** — ordering/receiving inventory in large quantities to capture per-unit cost
  savings (economies of scale), at the cost of requiring more storage capacity and more accurate
  demand forecasting to avoid overstock.
- **Dropshipping** — an inventory model where the retailer never physically holds the stock; the
  supplier ships directly to the end customer on the retailer's behalf. Minimizes warehousing
  needs and overstock risk, at the cost of less control over fulfillment speed/quality.
- **Perishable inventory management** — inventory strategies specific to goods with a shelf life
  (food, pharma), typically requiring FEFO (First-Expired-First-Out, as opposed to plain FIFO) and
  tighter cycle counting to catch spoilage before it becomes shrink.

## Data accuracy & control processes

- **Cycle count** — a partial, rolling physical inventory count (counting a subset of SKUs/
  locations on a recurring schedule) instead of one full annual count — catches discrepancies
  continuously rather than once a year.
- **Shrinkage / shrink** — the gap between what the system says should be on-hand and what's
  physically there, from theft, damage, spoilage, or administrative/data-entry error.
- **Inventory accuracy** — the degree to which system-recorded quantities match physical reality;
  the foundation every other inventory strategy (safety stock sizing, reorder points, ABC
  prioritization) depends on — inaccurate data makes all downstream decisions unreliable regardless
  of how sophisticated the strategy is.
- **Barcode / RFID tracking** — barcode scanning verifies item identity at each handling step
  (receiving, putaway, picking, shipping) via a discrete scan action; RFID uses radio-frequency
  tags read passively/in bulk without line-of-sight scanning, enabling continuous real-time
  location tracking rather than only point-in-time checkpoints. RFID costs more per unit but
  removes the scan-each-item bottleneck.

## Related files

- [warehouse-operations-terms.md](warehouse-operations-terms.md) — picking, storage, and labor
  vocabulary
- [supply-chain-visibility-terms.md](supply-chain-visibility-terms.md) — visibility & resilience
  concepts these strategies support
- [wms-erp-systems-terms.md](wms-erp-systems-terms.md) — the systems that execute these strategies
- [adobe-commerce-integration-points.md](adobe-commerce-integration-points.md) — how this maps to
  Adobe Commerce's inventory model
- [acronyms.md](acronyms.md) — quick acronym lookup
