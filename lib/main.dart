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
      retry: retryTransientFailures,
      child: const MeetHalfwayApp(),
    ),
  );
}
