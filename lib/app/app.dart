import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/app/router.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';

class MeetHalfwayApp extends ConsumerWidget {
  const MeetHalfwayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Meet Halfway',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}

/// Shown instead of the app when required configuration is missing, so a
/// misconfigured build fails loudly instead of making doomed API calls.
class MissingConfigApp extends StatelessWidget {
  const MissingConfigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      home: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'GOOGLE_MAPS_API_KEY is not set.\n\n'
              'Copy config/example.json to config/dev.json, add your key, and '
              'run:\n\nflutter run --dart-define-from-file=config/dev.json',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
