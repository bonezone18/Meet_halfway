# Meet Halfway

Find a fair place to meet. Enter where each person is starting from. Meet Halfway finds the midpoint, suggests nearby venues ranked by how evenly they split the trip, and shows each person's travel time and turn-by-turn directions.

Built for friends, couples, coworkers and co-parents. It runs on Android, iOS and the web from one Flutter codebase.

## Features

- **Starting points:** address and place autocomplete (Places API New), or "use my current location".
- **Midpoint:** the spherical centroid, which stays correct across long north–south trips and the antimeridian.
- **Venues near the midpoint:** search across categories (cafes, restaurants, bars, parks, museums…). The search radius scales with how far apart people are and widens automatically if the area is empty.
- **Fairness ranking:** venues are sorted by the gap between each person's distance by default. You can also sort by distance to the midpoint, rating or price, and filter to places open now.
- **Interactive map:** markers for each person, the midpoint and the venues, plus the search radius. On wide screens the map and list sit side by side.
- **Venue details:** photo, rating, price, hours, phone and website.
- **Travel times:** each person's time by car, transit, walking or bike (Routes API), with a travel-time fairness badge.
- **Directions:** one tap opens them in Google Maps (Apple Maps on iOS).
- **Display:** light and dark jewel-tone themes; miles or kilometres.

## Getting started

### 1. Prerequisites

- Flutter **3.47+** (Dart 3.13+). See `.github/workflows/ci.yml` for the exact version CI uses.
- A Google Cloud project with these APIs enabled:
  - **Places API (New)**
  - **Routes API**
  - **Maps SDK for Android**, **Maps SDK for iOS**, and **Maps JavaScript API** (for the platforms you target)

### 2. API keys

Client-side keys always ship inside the app, so **restrict every key** in the Cloud console. Restrict by app (Android package + SHA-1, iOS bundle ID, or HTTP referrer for web) and by API.

| Where | File (gitignored) | Contents |
|---|---|---|
| Dart (Places, Routes, web Maps JS) | `config/dev.json` (copy from `config/example.json`) | `{"GOOGLE_MAPS_API_KEY": "…"}` |
| Android map tiles | `android/local.properties` | `MAPS_API_KEY=…` (or the `MAPS_API_KEY` env var) |
| iOS map tiles | `ios/Flutter/Secrets.xcconfig` (copy from `Secrets.xcconfig.example`) | `MAPS_API_KEY = …` |

On the web, the Maps JavaScript API is loaded at startup using the Dart-side key, so `web/index.html` holds no key.

### 3. Run

```bash
flutter pub get
flutter run --dart-define-from-file=config/dev.json
```

If the key is missing, the app shows a setup screen instead of making failing API calls.

## Development

```bash
dart run build_runner build --delete-conflicting-outputs   # after editing @freezed models
dart format lib test
flutter analyze
flutter test
```

Generated `*.freezed.dart` and `*.g.dart` files are committed, so a fresh clone builds without running codegen. CI fails if they are out of date.

## Architecture

The code is organised by feature first, then by layer within each feature. State management uses [Riverpod](https://riverpod.dev) and routing uses [go_router](https://pub.dev/packages/go_router).

```
lib/
  main.dart            bootstrap: config check, web Maps loader, ProviderScope
  app/                 MaterialApp.router, routes, theme
  core/                cross-cutting: config, HTTP client + Failure types,
                       geo math, formatters, platform shims
  shared/widgets/      reusable UI (AsyncValueView, MessageView)
  features/
    locations/         who is meeting and where they start
    meetup/            midpoint strategy, MeetupPlan, fairness, home screen
    places/            venue search, ranking, filters, results + details UI
    directions/        travel times (Routes API) and map-app deep links
```

Each feature is split into these layers:

| Layer | Contains | May depend on |
|---|---|---|
| `domain/` | Immutable models (freezed), enums, repository **interfaces**, pure logic | `core/` only |
| `data/` | Repository implementations (Google APIs), DTOs, plugin wrappers | `domain/`, `core/` |
| `application/` | Riverpod providers/notifiers and use-case services | `domain/`, `data/` providers |
| `presentation/` | Screens and widgets | `application/`, `domain/` |

Key conventions:

- **Widgets never call APIs directly.** They watch providers. Repositories are exposed as providers, so tests and new data sources replace them with `overrideWithValue`.
- **Errors are typed.** Repositories throw a `Failure` subtype (`core/error/failure.dart`), and screens render `AsyncValue` errors with `describeError`. Only `NetworkFailure`s are retried automatically.
- **Pure logic stays pure.** Geo math, fairness, ranking and radius escalation are plain Dart with unit tests.

### Extension points (roadmap)

| Planned feature | Where it plugs in |
|---|---|
| Group mode (3+ people) | `ParticipantsController.add/remove` already exists, and `MeetupPlan`, `GeoMath.centroid` and fairness all handle N people. Only the home screen UI is needed. |
| Midpoint by travel time | Implement `MidpointStrategy` (e.g. iteratively minimise max drive time with `DirectionsRepository`) and override `midpointStrategyProvider`. |
| History of meeting spots | Add a `features/history/` feature with a local-storage repository; save the `MeetupPlan` + chosen `Venue` from the details screen. |
| More filters (price range, rating) | Add fields to `VenueFilter` (`minRating` is already supported) and controls to `VenueFilterBar`. |
| Yelp / OpenTable / other sources | Implement `PlacesRepository`, or a composite that merges several, and override `placesRepositoryProvider`. |
| Calendar / sharing | A new `features/share/` that consumes `MeetupPlan` + `Venue`. |
| AI suggestions, sponsored listings | A ranking stage after `rankVenues` in `features/places/domain/ranked_venue.dart`. |

## Security notes

- No API keys live in source control. Earlier revisions of this repository committed a key in `ios/Runner/AppDelegate.swift`. **That key must be rotated** in the Google Cloud console.
- Logging of HTTP traffic is limited to debug builds. The API key is sent as a header, so it never appears in logged URLs.
