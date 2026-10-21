import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';

part 'venue.freezed.dart';

enum PriceLevel {
  free('Free', 0),
  inexpensive(r'$', 1),
  moderate(r'$$', 2),
  expensive(r'$$$', 3),
  veryExpensive(r'$$$$', 4);

  const PriceLevel(this.symbol, this.rank);

  final String symbol;
  final int rank;
}

/// A candidate meeting place.
@freezed
abstract class Venue with _$Venue {
  const factory Venue({
    required String id,
    required String name,
    required GeoPoint location,
    @Default('') String address,
    @Default(<String>[]) List<String> types,
    String? primaryTypeLabel,
    double? rating,
    int? ratingCount,
    PriceLevel? priceLevel,
    bool? openNow,
    String? photoName,
    String? googleMapsUri,
  }) = _Venue;
}

/// Extra information loaded for the details screen.
@freezed
abstract class VenueDetails with _$VenueDetails {
  const factory VenueDetails({
    required Venue venue,
    String? phoneNumber,
    String? websiteUri,
    String? summary,
    @Default(<String>[]) List<String> weeklyHours,
  }) = _VenueDetails;
}
