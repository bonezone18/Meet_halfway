import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/app/app.dart';
import 'package:meet_halfway/core/config/app_config.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/platform/maps_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  if (!config.isValid) {
    runApp(const MissingConfigApp());
    return;
  }

  try {
    await loadGoogleMapsScript(config.googleMapsApiKey);
  } on Object catch (e) {
    // The app still works without the map widget; log and carry on.
    debugPrint('$e');
  }

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      retry: _retry,
      child: const MeetHalfwayApp(),
    ),
  );
}

/// Only transient network failures are retried automatically; API errors
/// (bad key, quota) and permission problems are surfaced immediately.
Duration? _retry(int retryCount, Object error) {
  if (error is! NetworkFailure || retryCount >= 2) return null;
  return Duration(seconds: 1 << retryCount);
}
