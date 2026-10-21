import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/core/network/dio_client.dart';
import 'package:meet_halfway/features/locations/domain/location_repository.dart';
import 'package:meet_halfway/features/locations/domain/place_suggestion.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

/// [LocationRepository] backed by Places API (New).
/// https://developers.google.com/maps/documentation/places/web-service/place-autocomplete
class GoogleLocationRepository implements LocationRepository {
  GoogleLocationRepository(this._dio);

  final Dio _dio;

  static const _baseUrl = 'https://places.googleapis.com/v1';

  @override
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    String? sessionToken,
    GeoPoint? bias,
  }) async {
    final query = input.trim();
    if (query.isEmpty) return const [];
    final response = await guardRequest(
      () => _dio.post<Map<String, dynamic>>(
        '$_baseUrl/places:autocomplete',
        data: {
          'input': query,
          'sessionToken': ?sessionToken,
          if (bias != null)
            'locationBias': {
              'circle': {
                'center': {
                  'latitude': bias.latitude,
                  'longitude': bias.longitude,
                },
                'radius': 50000.0,
              },
            },
        },
      ),
    );
    return parseAutocomplete(response.data);
  }

  @override
  Future<SelectedLocation> resolve(
    PlaceSuggestion suggestion, {
    String? sessionToken,
  }) async {
    final response = await guardRequest(
      () => _dio.get<Map<String, dynamic>>(
        '$_baseUrl/places/${suggestion.placeId}',
        queryParameters: {'sessionToken': ?sessionToken},
        options: Options(
          headers: {'X-Goog-FieldMask': 'id,formattedAddress,location'},
        ),
      ),
    );
    final data = response.data ?? const {};
    final location = data['location'] as Map<String, dynamic>?;
    if (location == null) {
      throw const NotFoundFailure('That place has no location.');
    }
    return SelectedLocation(
      label: suggestion.fullText,
      placeId: suggestion.placeId,
      point: GeoPoint(
        latitude: (location['latitude'] as num).toDouble(),
        longitude: (location['longitude'] as num).toDouble(),
      ),
    );
  }

  /// Exposed for testing against recorded API responses.
  static List<PlaceSuggestion> parseAutocomplete(Map<String, dynamic>? data) {
    final suggestions = (data?['suggestions'] as List<dynamic>?) ?? const [];
    return [
      for (final raw in suggestions.cast<Map<String, dynamic>>())
        if (raw['placePrediction'] case final Map<String, dynamic> p)
          PlaceSuggestion(
            placeId: p['placeId'] as String,
            primaryText:
                _text(p, 'mainText') ?? (p['text'] as Map)['text'] as String,
            secondaryText: _text(p, 'secondaryText') ?? '',
          ),
    ];
  }

  static String? _text(Map<String, dynamic> prediction, String key) {
    final format = prediction['structuredFormat'] as Map<String, dynamic>?;
    return (format?[key] as Map<String, dynamic>?)?['text'] as String?;
  }
}

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => GoogleLocationRepository(ref.watch(dioProvider)),
);
