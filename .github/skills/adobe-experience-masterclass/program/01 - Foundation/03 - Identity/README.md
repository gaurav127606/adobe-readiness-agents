# Identity

**Track:** Foundation
**Goal:** Avoid identity mistakes
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/platform-learn/tutorials/identities/understanding-identity-and-identity-graphs

## Masterclass companion
Deeper explanation, a stitching sequence diagram, and a graph-collapse example: **Module 05 —
Identity Service** in the AEP masterclass skill. Run `/learn aep identity` or
`/define aep identity graph`.
Local: [05-identity-service.md](../../../05-identity-service.md)

## Primer (read before you watch)

**What you'll learn:** how AEP knows that many different IDs belong to the *same person*, using
identities, namespaces, and the identity graph.

**Key concepts:**
- **AEP does not identify people — it connects identifiers.** It never says "this is Aaron"; it says
  "this ECID is linked to this email, which is linked to this CRM ID."
- **Identity = value + namespace.** A raw `12345` is meaningless; `CRMID:12345` is not. Namespaces
  (ECID, Email, CRMID, Phone, LoyaltyID) give values meaning.
- **ECID** — the anonymous cookie/device ID a visitor gets before logging in; usually their first
  identity.
- **Identity graph** — the network of connected identifiers per person.
- **Stitching** — a login/purchase event that carries *two* identities at once (e.g. ECID + email)
  bridges anonymous behavior to a known person.

**Common mistakes to avoid:** marking a non-unique field (country, tier) as an identity — this
causes **identity graph collapse**, where thousands of unrelated people get merged into one graph
and everything downstream becomes unreliable.

**Where it fits the spine:** Ingest → Model → **Identity** → Profile → Segment → … Identity sits
under almost everything — profiles, segments, journeys, and analytics all depend on it.

## Real-world example (optional)
A commerce-to-AEP integration project used two different kinds of identity in the same pipeline —
a good illustration of how identity isn't just "the person" concept: order events carried the usual
person-level identities (email, loyalty ID) so they'd stitch into a customer's identity graph, while
a separate product price/stock-update event used the **SKU** as its identity — a non-person key that
lets those events be looked up and joined by product, without ever touching or merging into the
customer identity graph. The two never collide because they live in different schemas with different
namespaces. Mixing them up — e.g. accidentally marking a product attribute as a person identity, or
vice versa — is exactly the kind of mistake that causes the "identity graph collapse" problem below.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. Restate correctly: "AEP identifies people." (What does it actually do?)
2. Why can't AEP link the raw value `12345` without a namespace?
3. What is identity graph collapse, and what typically causes it?
