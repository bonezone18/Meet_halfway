import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/locations/domain/location_repository.dart';

/// [DeviceLocationSource] backed by the geolocator plugin.
class GeolocatorLocationSource implements DeviceLocationSource {
  const GeolocatorLocationSource();

  @override
  Future<GeoPoint> currentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const PermissionFailure('Location services are turned off.');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw const PermissionFailure('Location permission was denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw const PermissionFailure(
        'Location permission is blocked. Enable it in system settings.',
      );
    }
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 15),
        ),
      );
      return GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on Object catch (e) {
      throw UnknownFailure(e, 'Could not get your current location.');
    }
  }
}

final deviceLocationSourceProvider = Provider<DeviceLocationSource>(
  (ref) => const GeolocatorLocationSource(),
);
