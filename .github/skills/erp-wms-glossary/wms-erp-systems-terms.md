# WMS / ERP / TMS / OMS Systems Terms

Vocabulary for the software systems themselves — what each one is responsible for, and how they
talk to each other.

## The core systems

- **WMS (Warehouse Management System)** — software that manages what happens *inside* a warehouse:
  inventory tracking, put-away, picking strategy execution, and order-fulfillment workflow. Scope
  is physically bounded to warehouse operations.
- **ERP (Enterprise Resource Planning)** — the broader system of record for a business's core
  operations: finance, procurement, manufacturing, HR, and often a company-wide view of inventory
  and orders. A WMS is frequently a specialized satellite system that must sync with the ERP
  rather than replace it — the ERP holds the "official" financial/inventory record, the WMS
  handles the physical execution detail the ERP isn't built to manage in real time.
- **TMS (Transportation Management System)** — software managing the planning, execution, and
  optimization of the movement of goods *between* locations (carrier selection, routing, freight
  cost) — picks up where the WMS's scope (inside the four walls) ends.
- **OMS (Order Management System)** — the system of record for order lifecycle across channels
  (create, allocate to a fulfillment location, ship, return) — often the system that decides
  *which* warehouse/store fulfills an order before the WMS executes the pick there.
- **Cloud WMS** — a WMS delivered as a hosted/cloud service rather than on-premise software.
  Practical implications customers care about: centralized real-time data access from anywhere,
  easier scaling up/down without new infrastructure purchases, and vendor-managed
  updates/security — traded against less control over customization and data residency compared
  to self-hosted.

## Cloud WMS feature vocabulary (what vendors pitch, and what it actually means)

- **Real-time inventory management** — stock level/location/movement data reflected immediately
  system-wide, so a sale in one channel is instantly visible everywhere else — the alternative
  (batch sync) risks overselling or stockout blindness between sync windows.
- **Data accuracy & visibility** — automating data capture (barcode/RFID scans rather than manual
  entry) to reduce human transcription error, which is the single most commonly cited root cause
  of inventory-record drift.
- **Scalability and flexibility** — the ability to handle increased order volume, more SKUs, or
  new locations without a corresponding new infrastructure purchase — a cloud-hosted system's
  main structural argument over on-premise.
- **Automation and efficiency** — reducing manual labor in picking/packing/shipping via the
  automation mechanisms in
  [warehouse-operations-terms.md](warehouse-operations-terms.md) (AGVs, robotic arms, conveyors),
  bundled as a system-level capability rather than individual hardware purchases.
- **Seamless integration with other systems** — the WMS exposing APIs/EDI connections to ERP, TMS,
  and e-commerce platforms so data moves automatically rather than through manual re-entry between
  systems — see "Integration mechanics" below for how this is actually implemented.
- **Enhanced security and compliance** — encryption, multi-factor authentication, and audit
  practices meeting industry data-handling regulations — a baseline expectation for any system
  handling order/customer/financial data, called out separately because compliance failures carry
  direct regulatory penalty risk, not just a generic "best practice."

## Integration mechanics

- **EDI (Electronic Data Interchange)** — standardized document formats (purchase orders,
  invoices, ASNs) exchanged between trading partners' systems; still the dominant integration
  method in traditional B2B supply chains, even though newer systems increasingly also expose
  modern APIs alongside it.
- **ASN (Advance Ship Notice)** — a supplier's electronic notice that a shipment is en route, with
  expected contents and arrival time, sent before physical arrival — the WMS reconciles the ASN
  against the GRN (see [inventory-management-terms.md](inventory-management-terms.md)) once goods
  physically arrive, and mismatches between the two are a standard integration failure point worth
  asking about during discovery.
- **API-based integration** — real-time, request/response system-to-system communication
  (webhooks, REST/GraphQL calls) as opposed to EDI's batch-document exchange — increasingly what
  "seamless integration" claims from cloud WMS vendors actually rely on under the hood, especially
  for e-commerce platforms.

## Related files

- [inventory-management-terms.md](inventory-management-terms.md) — the data these systems manage
- [warehouse-operations-terms.md](warehouse-operations-terms.md) — the operations these systems
  execute
- [supply-chain-visibility-terms.md](supply-chain-visibility-terms.md) — the outcome these systems
  are meant to deliver
- [adobe-commerce-integration-points.md](adobe-commerce-integration-points.md) — how Adobe
  Commerce specifically fits into this system landscape
- [acronyms.md](acronyms.md) — quick acronym lookup
