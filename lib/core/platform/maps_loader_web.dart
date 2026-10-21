import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Injects the Maps JavaScript API using the compile-time key, so the key is
/// not hardcoded in `web/index.html`.
Future<void> loadGoogleMapsScript(String apiKey) {
  if (web.document.querySelector('script[data-google-maps]') != null) {
    return Future.value();
  }
  final completer = Completer<void>();
  final script = web.HTMLScriptElement()
    ..src =
        'https://maps.googleapis.com/maps/api/js'
        '?key=${Uri.encodeQueryComponent(apiKey)}'
    ..async = true
    ..setAttribute('data-google-maps', '')
    ..onload = ((web.Event _) => completer.complete()).toJS
    ..onerror = ((web.Event _) => completer.completeError(
      StateError('Failed to load the Google Maps JavaScript API.'),
    )).toJS;
  web.document.head!.append(script);
  return completer.future;
}
