# Salam Vietnam — Product & Engineering Brief for AI Agent

> **Document type:** Product Requirements Document (PRD) + MVP implementation plan  
> **Working name:** Salam Vietnam  
> **Version:** 1.0  
> **Date:** 2026-10-03  
> **Platforms:** Android and iOS  
> **Languages:** Vietnamese (`vi`), English (`en`), Malay (`ms`)  
> **Initial coverage goal:** Vietnam-wide, with verified data added incrementally  
> **Implementation approach:** Flutter app + Supabase/PostgreSQL backend

---

## 1. Instructions for the AI Agent

Act as a senior Flutter engineer and pragmatic product engineer. Help implement **Salam Vietnam**, a standalone app for finding Halal-related services and exploring Cham culture and travel in Vietnam.

### Working rules

1. **Inspect before changing anything.** Check the repository, Flutter/Dart versions, current Git status, existing code, and project conventions before editing.
2. Do not assume a project directory or overwrite existing work. If no project exists, ask for or confirm the intended path before creating it.
3. Work in small, testable increments. After each increment, run relevant formatting, analysis, and tests; report exactly what passed or failed.
4. Prefer concise, consolidated instructions. Avoid trial-and-error lists and unrelated setup steps.
5. Do not add dependencies without a clear reason. Check package maintenance, compatibility, license, and platform support before recommending or adding packages.
6. Do not put secrets, Supabase `service_role` keys, or privileged credentials in the Flutter app.
7. Never fabricate real locations, addresses, opening hours, phone numbers, Halal status, certifications, reviews, or cultural facts.
8. Clearly mark mock/demo data as sample data. Do not present it as real or verified.
9. Respect data licenses, attribution requirements, image copyrights, privacy, and provider terms.
10. Before destructive operations, migrations that could lose data, or broad refactors, explain the impact and obtain approval.
11. When blocked by a missing decision, ask one concise question. Otherwise make a conservative, reversible choice and document it.
12. Do not claim a command or test succeeded unless it was actually run and its result observed.

### First task

Inspect the current environment and repository before implementation. Report:
- Current directory and repository status.
- Flutter and Dart versions, and relevant `flutter doctor` issues.
- Whether a Salam Vietnam project already exists.
- A short, concrete next-step plan.

Do not create or overwrite a project until the location and existing files are understood.

---

## 2. Product Summary

### Vision

Build a trustworthy travel and discovery app that helps people find Halal food and services, locate mosques/prayer places, find accommodation, and learn about Cham culture and heritage in Vietnam.

### Product promise

**Discover places with clearer information about location, source, freshness, and Halal verification status.**

### Target users

1. Muslims living in Vietnam who need food, prayer places, and useful local information.
2. Muslim visitors from abroad planning trips in Vietnam.
3. Travelers interested in Cham history, architecture, communities, heritage, and local experiences.
4. Local businesses and community members who want to submit or correct place information.

### Product principles

- **Trust first:** make evidence, source, and verification date visible where relevant.
- **Map-aware:** make it easy to find a place and open directions.
- **Culture with context:** publish sourced and respectful cultural information.
- **Multilingual by design:** support Vietnamese, English, and Malay from the beginning.
- **Incremental coverage:** aim for Vietnam-wide coverage, but add and verify records progressively.
- **Privacy and safety:** collect only necessary user data and secure all privileged operations.

---

## 3. MVP Scope

### In scope for MVP

1. **Explore/Home**
   - Search entry point.
   - Category shortcuts.
   - Featured or recently updated places, only when backed by real records.
   - Region/province browsing.
2. **Places directory**
   - Place list and detail screen.
   - Categories and filters.
   - Address, coordinates, contact details, opening hours, and facilities when available and sourced.
   - Source and last-updated/verified information.
3. **Halal information**
   - Halal restaurants and relevant shops/services.
   - A clear status and evidence trail.
   - No unsupported claim that a place is Halal.
4. **Mosques and prayer places**
   - Location and contact details where available.
   - Opening/visiting information only when verified.
   - Respectful visitor guidance when supported by a reliable source.
5. **Accommodation**
   - Place listings and available facilities.
   - Do not imply that an accommodation is certified Halal or fully Sharia-compliant without evidence.
6. **Cham culture and travel**
   - Sourced articles about Cham history, architecture, heritage, communities, crafts, food, and local experiences.
   - Separate editorial content from place records.
7. **Map and directions**
   - Map markers and place selection.
   - Open directions in an appropriate external map app.
   - Provider and attribution requirements must be respected.
8. **Search and filters**
   - Search by name and relevant text.
   - Filter by category, province/region, and verification status.
9. **Favorites**
   - Save and remove places.
   - Decide whether local-only favorites are sufficient for the first release; account sync can be added later.
10. **Community submissions**
    - Submit a new place, suggest an edit, or report outdated/incorrect information.
    - Submissions remain pending until reviewed by an authorized moderator.
11. **Localization**
    - UI languages: Vietnamese (`vi`), English (`en`), Malay (`ms`).
    - Place and article translations are stored separately from UI strings.
    - Missing translations must have a documented fallback, not a blank screen.
12. **Basic quality**
    - Loading, empty, error, and offline/connection states.
    - Accessibility-conscious text sizing, contrast, and touch targets.

### Explicitly out of scope for MVP

- Booking, payment, and reservations.
- In-app chat or social networking.
- Complex review/rating system.
- AI recommendations or AI-generated cultural claims.
- Real-time prayer times unless separately specified and properly sourced.
- User-facing certification issuance.
- Large-scale automatic scraping of websites or map providers.
- A complex custom admin app; an initial protected moderation workflow may use Supabase tooling or a simple internal interface.

### MVP acceptance criteria

- App runs on supported Android and iOS targets.
- User can switch between Vietnamese, English, and Malay.
- User can browse, search, filter, and open place details.
- Place detail distinguishes known data from unavailable data and shows source/freshness where applicable.
- User can open directions for a place with valid coordinates.
- User can save and remove favorites.
- User can submit a place or correction.
- Public users cannot directly publish or approve submissions.
- Unverified Halal information is never displayed as verified.
- Adding or editing a place in the backend does not require a new app release.
- No privileged server key is embedded in the client.
- Core flows have tests and no known critical authorization issue.

---

## 4. Information Architecture and Navigation

Use four primary navigation destinations:

1. **Explore** — search, categories, discovery, and cultural highlights.
2. **Map** — map view and nearby/discoverable places.
3. **Saved** — user’s favorite places.
4. **Profile/Settings** — language, preferences, contributions, and account options.

Suggested Explore shortcuts:
- Halal food
- Mosques / prayer places
- Accommodation
- Cham culture
- All places

Design direction:
- Modern, calm, clear, and culturally respectful.
- Take inspiration from the clarity and restraint of iOS without copying iOS wholesale.
- Create a product-specific design system rather than depending on Material defaults for every visual decision.
- Keep interaction patterns consistent across Android and iOS.
- Do not use culturally or religiously significant symbols decoratively without a reason.

---

## 5. Halal and Place Verification Policy

**Place verification and Halal verification are separate concepts.** A correct address does not establish that the food or business is Halal.

Suggested place publication status:
- `draft`
- `pending_review`
- `published`
- `needs_review`
- `archived`

Suggested general place verification status:
- `unverified`
- `community_confirmed`
- `source_confirmed`
- `field_verified`
- `disputed`

Suggested Halal verification status:
- `unverified`
- `self_declared`
- `verified`
- `expired`
- `disputed`
- `not_applicable`

Rules:
- `verified` must be supported by a documented policy and evidence appropriate to the claim.
- Record what was checked, by whom, and when.
- Where a certification is cited, record the issuing body, certificate details if public and appropriate, validity dates, and a source reference. Do not imply endorsement by a certifier.
- A self-declaration is not the same as independent verification or certification.
- Avoid presenting “no pork” or “Muslim-owned” as proof of Halal status.
- If evidence expires or becomes disputed, show the appropriate status and trigger review.
- Make status labels understandable to users; do not rely on color alone.
- Store a short public explanation of the status where useful.

---

## 6. Data Model

Use PostgreSQL as the primary relational database. Use UUID primary keys and UTC timestamps (`timestamptz`). Use PostGIS if proximity queries are needed. Avoid duplicating the same concept in multiple tables without a reason.

### Core tables

#### `places`
Common data for all locations.

Suggested fields:
- `id UUID PRIMARY KEY`
- `slug TEXT UNIQUE`
- `place_type TEXT`
- `latitude DOUBLE PRECISION`
- `longitude DOUBLE PRECISION`
- `location GEOGRAPHY(POINT, 4326)` when PostGIS is enabled
- `province_code TEXT`
- `address TEXT`
- `website_url TEXT NULL`
- `phone TEXT NULL`
- `publication_status TEXT`
- `verification_status TEXT`
- `created_at TIMESTAMPTZ`
- `updated_at TIMESTAMPTZ`
- `last_verified_at TIMESTAMPTZ NULL`
- `created_by UUID NULL`

Do not store localized display names only in `places`; use translation records.

#### `place_translations`
- `id UUID PRIMARY KEY`
- `place_id UUID REFERENCES places(id)`
- `language_code TEXT` (`vi`, `en`, `ms`)
- `name TEXT`
- `short_description TEXT NULL`
- `description TEXT NULL`
- `address_display TEXT NULL`
- Unique constraint on (`place_id`, `language_code`)

#### `categories`
- `id UUID PRIMARY KEY`
- `slug TEXT UNIQUE`
- `parent_id UUID NULL REFERENCES categories(id)`
- `icon_key TEXT NULL`
- `sort_order INTEGER`

#### `place_category_links`
Join table to allow one place to have multiple categories:
- `place_id UUID REFERENCES places(id)`
- `category_id UUID REFERENCES categories(id)`
- Composite primary key (`place_id`, `category_id`)

Suggested category slugs:
- `halal_food`
- `halal_shop`
- `mosque`
- `prayer_facility`
- `accommodation`
- `cham_heritage`
- `cultural_experience`
- `craft`
- `tourist_attraction`

#### `halal_verifications`
Keep separate from general place verification.
- `id UUID PRIMARY KEY`
- `place_id UUID REFERENCES places(id)`
- `status TEXT`
- `claim_type TEXT NULL`
- `evidence_summary TEXT NULL`
- `issuing_body TEXT NULL`
- `certificate_reference TEXT NULL`
- `valid_from DATE NULL`
- `valid_until DATE NULL`
- `verified_by UUID NULL`
- `verified_at TIMESTAMPTZ NULL`
- `review_due_at TIMESTAMPTZ NULL`
- `public_note TEXT NULL`
- `created_at TIMESTAMPTZ`
- `updated_at TIMESTAMPTZ`

Do not expose private moderation notes or sensitive evidence to public clients.

#### `sources`
Records the provenance of data.
- `id UUID PRIMARY KEY`
- `source_type TEXT`
- `name TEXT`
- `url TEXT NULL`
- `license_or_terms TEXT NULL`
- `attribution_text TEXT NULL`
- `accessed_at TIMESTAMPTZ NULL`
- `notes TEXT NULL`

#### `place_sources`
Join table linking individual claims/places to sources:
- `place_id UUID REFERENCES places(id)`
- `source_id UUID REFERENCES sources(id)`
- `claim_scope TEXT`
- `checked_at TIMESTAMPTZ NULL`
- `notes TEXT NULL`

#### `place_photos`
- `id UUID PRIMARY KEY`
- `place_id UUID REFERENCES places(id)`
- `storage_path TEXT`
- `caption TEXT NULL`
- `credit TEXT NULL`
- `source_url TEXT NULL`
- `license_or_permission TEXT NULL`
- `review_status TEXT`
- `created_at TIMESTAMPTZ`

Only publish photos when usage rights and attribution are clear.

#### `place_submissions`
- `id UUID PRIMARY KEY`
- `submitted_by UUID NULL`
- `place_id UUID NULL`
- `submission_type TEXT` (`new_place`, `edit_place`, `report_issue`)
- `payload JSONB`
- `status TEXT` (`pending`, `in_review`, `approved`, `rejected`)
- `moderator_id UUID NULL`
- `moderation_note TEXT NULL`
- `created_at TIMESTAMPTZ`
- `reviewed_at TIMESTAMPTZ NULL`

Validate submission payloads server-side. Never trust a client-provided approval status.

#### `favorites`
- `user_id UUID REFERENCES auth.users(id)`
- `place_id UUID REFERENCES places(id)`
- `created_at TIMESTAMPTZ`
- Composite primary key (`user_id`, `place_id`)

For a no-account MVP, local favorites can be used instead. Decide based on scope; do not force account creation just to save a place.

#### `cultural_articles`
- `id UUID PRIMARY KEY`
- `slug TEXT UNIQUE`
- `category TEXT`
- `publication_status TEXT`
- `author_name TEXT NULL`
- `published_at TIMESTAMPTZ NULL`
- `updated_at TIMESTAMPTZ`

#### `article_translations`
- `id UUID PRIMARY KEY`
- `article_id UUID REFERENCES cultural_articles(id)`
- `language_code TEXT`
- `title TEXT`
- `summary TEXT NULL`
- `body_markdown TEXT`
- Unique constraint on (`article_id`, `language_code`)

Cultural articles should have source references and editorial review. Do not invent cultural facts or flatten differences between Cham communities.

### Data-model implementation notes

- Add indexes for publication status, place type, province, category links, and geographic queries as appropriate.
- Validate latitude and longitude ranges.
- Normalize phone numbers and URLs where practical.
- Keep `updated_at` accurate through a database trigger or consistent server-side logic.
- Define allowed enum/check values in the database, not only in Flutter.
- Use migrations under version control.
- Avoid collecting precise user location history unless a feature truly requires it.
- If a data source has a license or attribution requirement, retain that information and show required attribution in the app.

---

## 7. Backend Security and Moderation

Use Supabase Auth only when needed. Public browsing should not require sign-in.

Suggested access rules:
- Anonymous/public users can read only published public places, approved translations, approved photos, and published cultural articles.
- Authenticated users can manage only their own favorites.
- Users can create submissions but cannot approve, publish, or modify moderation outcomes.
- Moderators can review submissions through a protected role/permission mechanism.
- Private verification evidence and moderation notes must not be exposed through public queries.
- Configure Row Level Security (RLS) on all tables accessible through the client.
- Keep privileged operations on a trusted server or protected administrative environment.
- Test policies with anonymous, regular-user, and moderator roles.

Do not assume that hiding a button in Flutter is authorization. Enforce access in the database/server.

---

## 8. Flutter Architecture

Use a feature-first structure with clear boundaries between presentation, data access, and business logic. Keep it pragmatic; do not introduce unnecessary abstraction.

Suggested structure:

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    bootstrap.dart
  core/
    config/
    errors/
    localization/
    theme/
    utils/
    widgets/
  shared/
    models/
    repositories/
    services/
  features/
    explore/
      data/
      domain/
      presentation/
    places/
      data/
      domain/
      presentation/
    map/
      data/
      domain/
      presentation/
    search/
      data/
      domain/
      presentation/
    halal/
      data/
      domain/
      presentation/
    mosques/
      data/
      domain/
      presentation/
    accommodation/
      data/
      domain/
      presentation/
    cham_culture/
      data/
      domain/
      presentation/
    favorites/
      data/
      domain/
      presentation/
    contributions/
      data/
      domain/
      presentation/
    settings/
      presentation/
  l10n/
    app_vi.arb
    app_en.arb
    app_ms.arb
```

The directory tree is a target structure, not a requirement to create every folder immediately. Add modules when implementing the corresponding feature.

### Suggested technical choices

Use these as initial recommendations, and verify package compatibility and maintenance before adding:
- Flutter stable and Dart version compatible with the installed SDK.
- Riverpod for state management.
- `go_router` for navigation.
- Flutter’s official localization tooling (`flutter_localizations`, `intl`, ARB files).
- Supabase Flutter SDK for backend access.
- A map package/provider selected after checking current platform support, terms, pricing, and attribution.
- `url_launcher` or an equivalent supported method to open external directions when appropriate.

Do not add a map SDK or large dependency set until the first map requirements are clear. Keep map-specific code behind a small interface.

### Design system requirements

Create tokens for:
- Brand and semantic colors.
- Typography scale and text styles.
- Spacing scale.
- Corner radii.
- Elevation/surface styles.
- Touch target sizes.
- Light/dark themes if included in MVP.

Create reusable components only when they represent a stable product pattern, such as:
- Search field.
- Place card.
- Category shortcut.
- Verification-status label.
- Empty/loading/error states.
- Place information rows.
- Bottom navigation.
- Filter sheet.

Keep the design modern and iOS-inspired, but use a Salam Vietnam design language rather than copying native iOS screens wholesale. Check layout behavior on both iOS and Android.

---

## 9. Localization

Supported UI locale codes:
- Vietnamese: `vi`
- English: `en`
- Malay: `ms`

Rules:
1. UI strings must be localized; avoid hard-coded user-facing strings in widgets.
2. Use ARB files and generated localization classes.
3. Store content translations as database records.
4. Use a documented fallback when a place/article is unavailable in the selected language. Show the content language where helpful.
5. Do not machine-translate sensitive Halal/certification claims and publish them without review.
6. Test long strings, text scaling, date/number formatting, and layouts in all three languages.
7. Keep proper names and official names accurate; translated display names must not replace original names where that would cause confusion.

---

## 10. Data Acquisition and Content Operations

Vietnam-wide is the product goal, not a promise of complete initial coverage.

Potential data sources:
- Direct confirmation from businesses and venue operators.
- Local community contributions.
- Official tourism/cultural sources.
- OpenStreetMap and other sources whose terms permit the intended use.
- Relevant Halal organizations or certifying bodies for claims that they can substantiate.

Rules:
- Review source license and terms before importing or redistributing data.
- Do not bulk-copy Google Maps listings, reviews, photos, or other protected content.
- Do not scrape websites without confirming permission and terms.
- Record provenance at the place/claim level where practical.
- Deduplicate records and validate coordinates.
- Make it easy to report closed, moved, or incorrect places.
- Set review intervals according to data type and reliability.
- Do not label a place “verified Halal” based only on a name, cuisine, ownership, absence of pork, or an unsubstantiated user report.
- Use a small, genuinely checked pilot dataset for initial testing. Never inflate coverage with fake places.

For cultural content:
- Cite credible sources in editorial records.
- Respect community perspectives and differences across Cham communities.
- Obtain permission for interviews, personal stories, and non-public photographs.
- Have culturally sensitive content reviewed when feasible.

---

## 11. Six-Week MVP Plan

This is an indicative plan for one developer; adjust based on actual progress.

### Week 1 — Foundation
- Inspect environment and repository.
- Confirm app path and Git setup.
- Create or initialize the standalone Flutter project if needed.
- Establish architecture, theme tokens, routing, and localization scaffolding.
- Decide database migrations and initial schema.

### Week 2 — Core UI
- Build app shell and four main destinations.
- Build Explore screen, category shortcuts, place card, and place detail.
- Use clearly labeled local mock data behind a repository interface.
- Add loading, empty, and error states.

### Week 3 — Search and map
- Implement search and filters.
- Choose map provider after reviewing terms, attribution, cost, and platform support.
- Display place coordinates and open external directions.
- Add tests for search/filter behavior.

### Week 4 — Backend and localization
- Configure Supabase project outside source control.
- Add versioned database migrations.
- Implement public read queries and translations.
- Add RLS policies and tests.
- Connect repository implementations to Supabase.

### Week 5 — Favorites and contributions
- Implement favorites (local-only first if accounts are not needed).
- Add place submission and correction forms.
- Implement pending/reviewed status.
- Add protected moderation workflow and authorization tests.

### Week 6 — QA and pilot
- Test Android and iOS flows where available.
- Check all three locales.
- Review accessibility and failure states.
- Verify a small pilot dataset and source attribution.
- Fix critical bugs and run a limited user test.
- Document known gaps before wider release.

---

## 12. Testing and Quality Gates

For each increment:
- Run `dart format`.
- Run `flutter analyze`.
- Run relevant unit/widget tests.
- Add tests for data parsing, repository behavior, localization fallback, and filters.
- Test RLS and submission permissions against multiple roles.
- Test empty, loading, error, and missing-translation states.
- Test with no location permission and no network.
- Never assume GPS permission is granted.
- Ensure map attribution is visible as required.
- Do not log credentials, personal information, or sensitive user location data.

Before a release:
- Run the full test suite.
- Build for each supported target available in the environment.
- Review dependencies and licenses.
- Review privacy disclosures and data retention.
- Confirm no secrets are committed.
- Check app icon, app name, store metadata, and permission prompts.

---

## 13. Risks and Mitigations

| Risk | Mitigation |
|---|---|
| Incomplete or outdated venue data | Show source and freshness; provide report/update flow |
| Incorrect Halal claims | Separate verification states, require evidence, and retain audit history |
| Lack of initial data | Launch a small verified pilot, expand incrementally |
| Cultural inaccuracies | Source editorial content and seek appropriate review |
| Licensing/copyright issues | Record licenses, attribution, and photo permissions |
| Map costs or provider restrictions | Review terms and costs before choosing; isolate map integration |
| Scope creep | Keep booking, payment, social, and AI features out of MVP |
| Security problems | RLS, least privilege, server-side validation, and permission tests |
| Multilingual inconsistency | ARB-based UI localization and per-content translation records |

---

## 14. Initial Definition of Done

A feature is done only when:
- It meets the stated acceptance criteria.
- It handles loading, empty, error, and permission-denied states as relevant.
- User-visible text is localized.
- Relevant tests are added and pass.
- `flutter analyze` has no new unexplained issues.
- Security and source-data implications are addressed.
- The agent reports changed files, commands run, results, and any remaining limitations.

---

## 15. Immediate Next Steps for the Agent

Proceed in this order:

1. Inspect the current workspace, project folders, Git status, Flutter version, Dart version, and `flutter doctor`.
2. Report findings before changing files.
3. Confirm the intended standalone project directory. Do not overwrite or convert an existing MuslimVN project.
4. Initialize `salam_vietnam` only if the target path is confirmed and safe.
5. Establish Git and a minimal Flutter app shell.
6. Add localization scaffolding for `vi`, `en`, and `ms`.
7. Implement the first vertical slice using mock data:
   - Explore screen
   - Place card
   - Place detail screen
   - Repository interface
   - Loading/empty/error states
8. Run formatting, analysis, and tests; report actual outcomes.
9. Only then proceed to database migrations and backend integration.

### First response expected from the agent

Start by inspecting the environment and existing files. Summarize what is present, identify blockers, and propose the next concrete step. Do not generate the entire app in one unreviewed change.
