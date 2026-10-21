import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Compile-time configuration supplied with
/// `--dart-define-from-file=config/<env>.json`.
///
/// Nothing secret is bundled as an asset; values are baked in at build time.
/// Client-side keys are always extractable, so restrict them in the Google
/// Cloud console (by app id / bundle id / HTTP referrer and by API).
class AppConfig {
  const AppConfig({required this.googleMapsApiKey});

  factory AppConfig.fromEnvironment() => const AppConfig(
    googleMapsApiKey: String.fromEnvironment('GOOGLE_MAPS_API_KEY'),
  );

  final String googleMapsApiKey;

  bool get isValid =>
      googleMapsApiKey.isNotEmpty &&
      googleMapsApiKey != 'REPLACE_WITH_YOUR_KEY';
}

/// Overridden in `main.dart`; tests override it with a fake config.
final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);
