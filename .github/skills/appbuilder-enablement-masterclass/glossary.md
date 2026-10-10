# App Builder Glossary — plain English

Every term in this kit, defined simply. Backs `/define appbuilder`.

| Term | Plain-English meaning |
|---|---|
| **App Builder** | Adobe's platform for running your own serverless Node.js code (actions) *next to* Adobe products, extending them without editing their core. |
| **Out-of-process extensibility** | Adding features by running code *outside* Adobe Commerce (on App Builder) instead of *inside* it (PHP). Loosely coupled, upgrade-safe. |
| **Adobe I/O Runtime** | Adobe's serverless platform (built on Apache OpenWhisk) that actually runs your actions on demand. No servers to manage. |
| **aio / Adobe I/O** | "Adobe I/O" — the umbrella brand for the developer platform. `aio` is also the CLI command. |
| **Action** | One Node.js function (`exports.main`) that takes `params` and returns `{ statusCode, headers, body }`. The unit of code you deploy. |
| **Web action** | An action exposed over HTTPS at a URL, callable by a browser, storefront, curl, etc. (`web: 'yes'` in the manifest). |
| **`aio` CLI** | The command-line tool (`npm i -g @adobe/aio-cli`) you use to log in, link a workspace, and deploy. |
| **Adobe Developer Console** | The web portal (`developer.adobe.com/console`) where orgs, projects, and workspaces live. |
| **Org / Project / Workspace** | The 3-level hierarchy that defines a deployment target. Workspace = one namespace = its own actions + State. |
| **Namespace** | Your deployment target's address: `<orgId>-<project>-<workspace>` (e.g. `123456-myproject-integration`). Part of every action URL. |
| **`app.config.yaml`** | The manifest listing every action, its file, runtime, inputs, and web/auth settings. **Not listed = not deployed.** |
| **`inputs:`** | Values injected into an action at deploy time, often from `.env` (e.g. `MAP_PROVIDER: $MAP_PROVIDER`). Available as `params.*` in code. |
| **`params`** | The single argument your action receives: query-string values, JSON body fields, and `inputs:` all merged together. |
| **Adobe I/O State** | A built-in key-value store (`@adobe/aio-lib-state`): `put`/`get`/`delete`/`list`. No SQL. Max TTL 365 days. Per-workspace. |
| **`@adobe/aio-sdk`** | The SDK bundling common helpers, incl. `Core.Logger` for logging inside actions. |
| **`require-adobe-auth`** | Annotation: `false` = public action (anyone can call the URL); `true` = requires an Adobe (IMS) token. Use `true` for write actions. |
| **`final: true`** | Annotation that locks an action's default params so callers can't override them. Common on web actions. |
| **`aio login`** | Interactive browser sign-in that authenticates the CLI to Adobe (IMS). Prints an access token — treat as a secret. |
| **`aio app use`** | Links your local app folder to a Console workspace; writes `.aio` and `.env` (namespace + credentials). |
| **`aio app deploy`** | Builds and uploads every action in the manifest to your workspace's namespace; prints the live URLs. |
| **`.aio` / `.env`** | Per-developer local files created by `aio app use`. `.env` holds credentials + input values. Both gitignored. |
| **CORS** | Browser security rule about cross-origin calls. Runtime auto-adds CORS headers to web actions; if your code adds them too you get `*,*` and the browser rejects it. |
| **IMS** | Adobe Identity Management System — Adobe's login/identity layer. `aio login` authenticates through it. |
| **Apache OpenWhisk** | The open-source serverless engine Adobe I/O Runtime is built on. Explains the action/package/namespace model. |
| **API Mesh** | An App Builder capability that unifies multiple APIs behind one GraphQL endpoint. (Not covered in depth here.) |
| **Adobe I/O Events** | Event bus that lets actions react to things like "order placed." (Not covered in depth here.) |
| **Admin UI SDK** | Framework for embedding a custom React app inside the Adobe Commerce Admin. (Not covered in depth here.) |
| **ACCS** | Adobe Commerce as a Cloud Service — the SaaS Commerce that pushes customization out to App Builder. |
| **EDS** | Edge Delivery Services — the storefront/presentation layer that *calls* App Builder actions. See the EDS kit. |
| **Haversine** | The formula for great-circle distance between two lat/lng points; used in `store-locator-search` to sort by distance. |
| **Nominatim / OpenStreetMap** | Free geocoding service used by `map-geocode` by default (needs a contact email in the User-Agent; ~1 req/sec). |
