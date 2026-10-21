# Contributing

Read the [Architecture](README.md#architecture) section of the README first.

## Workflow

- Branch from `main` and use a descriptive branch name (`feature/history`, `fix/radius-escalation`).
- Keep commits small, and write messages that say *why* the change was made.
- Before pushing, run the same checks CI runs:

  ```bash
  dart run build_runner build --delete-conflicting-outputs
  dart format lib test
  flutter analyze
  flutter test
  ```

## Adding a feature

1. Create `lib/features/<name>/` with `domain/`, `data/`, `application/`, and `presentation/` as needed. Skip any layer you don't use.
2. Start in `domain/`: immutable models (`@freezed abstract class … with _$…`) and an `abstract interface class` for any external dependency.
3. Implement the interface in `data/`. Map every error to a `Failure` (use `guardRequest` for HTTP calls). Expose the implementation as a provider typed by the **interface**.
4. Put state and use cases in `application/` as `Notifier`, `FutureProvider` or plain services. Keep them free of `BuildContext`.
5. Build the UI in `presentation/`. Widgets read state through `ref.watch` and render async state with `AsyncValueView`.
6. Add a route in `lib/app/router.dart` if the feature has its own screen.
7. Test it:
   - unit-test the domain logic
   - test providers with `ProviderContainer.test(overrides: …)`
   - test widgets by overriding repositories with fakes (see `test/helpers/fakes.dart`)

## Code style

- Strict lints come from `very_good_analysis` plus `riverpod_lint`. Keep `flutter analyze` at zero issues.
- Use `package:meet_halfway/...` imports. Features may import another feature's `domain/` and `application/`, but never its `data/` internals. The exception is the repository *provider*.
- Keep lines at 80 characters or fewer (`dart format` handles this).
- Mark unfinished work with `TODO(username): …`.
