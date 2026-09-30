# EDS Glossary

Plain-English definitions for every term used across this skill and the internal EDS Enablement
Program. Alphabetical.

- **AEM as a Cloud Service (AEMaaCS)** — Adobe's managed, cloud-hosted AEM offering. Runs on an
  Author (create) tier and a Publish (serve) tier; EDS is a module inside it, not a separate
  product.
- **AEM CLI** — the command-line tool (`@adobe/aem-cli`, installed via `npm i -g @adobe/aem-cli`)
  used for local development (`aem up`).
- **AEM Code Sync** — the GitHub App that listens for `push` events on your code repository,
  publishes code to AEM's code bus, and purges CDN caches when changes land. Without it, your
  `.aem.page` URL never comes alive. **Installing it does not retroactively sync commits that
  already exist** — it only reacts to the next push; see the "real incident" in
  [Module 4](04-hands-on-setup-and-code-sync.md).
- **AEM Franklin / Helix** — earlier names for the same technology now called Edge Delivery
  Services. All three terms appear interchangeably in Adobe docs.
- **Author** (the glossary term) — content creation in Google Docs, Word, or DA.live. Not to be
  confused with **AEM Author**, the product tier.
- **Block** — a self-contained, reusable content component (e.g. a hero, a carousel) implemented in
  vanilla JS/CSS, the unit of EDS's block-based development model.
- **Boilerplate (`aem-boilerplate`)** — Adobe's official starter GitHub template
  (`github.com/adobe/aem-boilerplate`) used to bootstrap a new EDS project via "Use this template."
- **Code Bus** — the part of the Content Hub carrying frontend code and configuration, always
  sourced from GitHub. There is no backend code in EDS.
- **Content Bus** — the part of the Content Hub carrying the actual structured/unstructured content
  of a page.
- **Content Hub** — the layer of the EDS architecture holding the three buses (content, media,
  code), populated from AEM Authoring, 3rd-party sources, document-based editing, or GitHub.
- **Core Web Vitals** — Google's real-user page-experience metrics (loading, interactivity, visual
  stability); EDS is designed around them by default.
- **DA / Document Authoring / da.live** — the browser-based document editor
  (`da.live/#/<owner>/<repo>`) where content lives as one doc per page/fragment, edited in a
  Word-like interface.
- **Dev** (the glossary term) — frontend code & configuration, always kept in GitHub.
- **Document-based authoring** — writing site content in a Google Doc, Word file, or DA.live doc
  instead of a CMS form; EDS's core authoring model.
- **Edge** — delivery through the CDN/edge computing platform; the "E" in EDS.
- **EDS (Edge Delivery Services)** — the module inside AEM as a Cloud Service that renders
  documents into edge-cached HTML with no build pipeline.
- **Helix Admin API (`admin.hlx.page`)** — the diagnostic/control API behind Sidekick and Code
  Sync. `GET /status/<owner>/<repo>/<branch>` reports the health of the content and code buses
  separately (handy when one is broken and the other isn't); `POST /code/<owner>/<repo>/<branch>/*`
  forces an immediate code-bus sync from GitHub without waiting for a push-triggered webhook. See
  [Module 4](04-hands-on-setup-and-code-sync.md).
- **helix-html-pipeline** — the framework used by `helix-pipeline-service` to render HTML (and
  filtered JSON) from documents.
- **helix-pipeline-service** — the main pipeline service that transforms documents into
  "hyper-media"/HTML, pulling content from the content bus and code/config from the code bus.
- **Inner CDN** — the Preview Service tier (`*.aem.page`); serves preview-only content, not cached.
- **Lighthouse score** — Google's automated page-quality score (0-100); the program treats a
  consistent 100 as the *baseline* expectation for EDS, not a stretch goal.
- **PSI check (`aem-psi-check`)** — the `aem-code-sync` bot's own automated PageSpeed Insights check
  posted on every PR: a mobile/desktop scores table plus SI/FCP/LCP/TBT/CLS audit metrics, with
  tickable checkboxes to re-run it or re-sync the branch. Runs independently of any other repo CI
  (e.g. a generic `Build` GitHub Action) — one failing doesn't imply the other did. See
  [Module 4](04-hands-on-setup-and-code-sync.md).
- **Live tier (`*.aem.live`)** — the outer CDN, serving cached, published, production content to
  real visitors.
- **Media Bus** — the part of the Content Hub carrying images, video, and other assets.
- **Outer CDN** — the EDS layer itself (`*.aem.live`); serves cached, live content.
- **Pipe / pipeline services** — services that transform documents into HTML/hyper-media. Not a
  CI/CD build pipeline — a rendering pipeline.
- **Preview tier (`*.aem.page`)** — the inner CDN, serving previewed-but-not-yet-published content;
  not cached.
- **Push vs. Sync** — two different actions that get confused constantly. **Push** is a git action:
  your commits going *to* GitHub, under your control. **Sync** is a Helix action: the code bus
  *fetching from* GitHub, normally auto-triggered by a push but forceable via the Helix Admin API.
  A push that never happened can't be synced by any amount of retrying the sync.
- **Sidekick** — the Chrome browser extension used to preview, publish, unpublish, and delete
  content when the authoring source is Google Docs, Word, or SharePoint (not needed for DA.live,
  which has native publish built in).
- **Universal Editor / Page Editor** — the optional bridge that lets an existing AEM Author instance
  feed content into EDS, mainly for VIP/premium-support customers migrating an existing AEM site.
