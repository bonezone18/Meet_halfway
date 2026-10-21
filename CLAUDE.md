# CLAUDE.md

Flutter app (Android/iOS/web) for finding a fair meeting place. It uses Riverpod 3, go_router, freezed, Dio, Places API (New) and the Routes API.

## Commands

- Run: `flutter run --dart-define-from-file=config/dev.json` (needs a key; see the README)
- Codegen after editing `@freezed` models: `dart run build_runner build --delete-conflicting-outputs`. Commit the generated files.
- Checks: `dart format lib test && flutter analyze && flutter test`

## Conventions

- **Layout:** feature-first under `lib/features/<feature>/{domain,data,application,presentation}`. Cross-cutting code goes in `lib/core/`. See CONTRIBUTING.md for the layer rules.
- **Providers:** hand-written Riverpod providers (no riverpod_generator). Repository providers are typed by the domain interface.
- **Errors:** repositories throw `Failure` subtypes only (`lib/core/error/failure.dart`).
- **Models:** freezed v3 syntax, i.e. `abstract class X with _$X`.
- **Tests:** shared fakes live in `test/helpers/fakes.dart`. Use `ProviderContainer.test(retry: retryTransientFailures)` when asserting on errors; otherwise Riverpod's default retry keeps the provider loading.
- **Secrets:** never commit API keys. Config goes in `config/*.json`, `android/local.properties` and `ios/Flutter/Secrets.xcconfig`, all of which are gitignored.
