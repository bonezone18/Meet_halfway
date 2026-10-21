import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';
import 'package:url_launcher/url_launcher.dart';

/// Builds and opens turn-by-turn navigation links in external map apps.
class MapLauncher {
  const MapLauncher();

  /// Universal Google Maps directions URL; opens the app if installed.
  /// https://developers.google.com/maps/documentation/urls/get-started
  static Uri googleMapsDirections({
    required GeoPoint destination,
    GeoPoint? origin,
    String? destinationPlaceId,
    TravelMode mode = TravelMode.drive,
  }) => Uri.https('www.google.com', '/maps/dir/', {
    'api': '1',
    if (origin != null) 'origin': _latLng(origin),
    'destination': _latLng(destination),
    'destination_place_id': ?destinationPlaceId,
    'travelmode': mode.mapsUrlValue,
  });

  /// Apple Maps directions URL (iOS / macOS).
  static Uri appleMapsDirections({
    required GeoPoint destination,
    GeoPoint? origin,
    TravelMode mode = TravelMode.drive,
  }) => Uri.https('maps.apple.com', '/', {
    if (origin != null) 'saddr': _latLng(origin),
    'daddr': _latLng(destination),
    'dirflg': switch (mode) {
      TravelMode.walk => 'w',
      TravelMode.transit => 'r',
      TravelMode.drive || TravelMode.bicycle => 'd',
    },
  });

  bool get supportsAppleMaps =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  /// Opens [uri] outside the app. Returns false if nothing could handle it.
  Future<bool> open(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);

  static String _latLng(GeoPoint p) => '${p.latitude},${p.longitude}';
}

final mapLauncherProvider = Provider<MapLauncher>((ref) => const MapLauncher());
