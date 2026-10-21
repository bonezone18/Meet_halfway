import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

/// Wire format of a Places API (New) `Place` (only the fields we request).
/// https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places
@freezed
abstract class PlaceDto with _$PlaceDto {
  const factory PlaceDto({
    required String id,
    LocalizedTextDto? displayName,
    String? formattedAddress,
    String? shortFormattedAddress,
    GeoPoint? location,
    @Default(<String>[]) List<String> types,
    LocalizedTextDto? primaryTypeDisplayName,
    double? rating,
    int? userRatingCount,
    String? priceLevel,
    OpeningHoursDto? currentOpeningHours,
    OpeningHoursDto? regularOpeningHours,
    @Default(<PhotoDto>[]) List<PhotoDto> photos,
    String? googleMapsUri,
    String? nationalPhoneNumber,
    String? websiteUri,
    LocalizedTextDto? editorialSummary,
  }) = _PlaceDto;

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);

  const PlaceDto._();

  /// Returns null when the place lacks the minimum data we need.
  Venue? toVenue() {
    final name = displayName?.text;
    final point = location;
    if (name == null || point == null) return null;
    return Venue(
      id: id,
      name: name,
      location: point,
      address: shortFormattedAddress ?? formattedAddress ?? '',
      types: types,
      primaryTypeLabel: primaryTypeDisplayName?.text,
      rating: rating,
      ratingCount: userRatingCount,
      priceLevel: _priceLevels[priceLevel],
      openNow: currentOpeningHours?.openNow,
      photoName: photos.firstOrNull?.name,
      googleMapsUri: googleMapsUri,
    );
  }

  VenueDetails? toDetails() {
    final venue = toVenue();
    if (venue == null) return null;
    return VenueDetails(
      venue: venue,
      phoneNumber: nationalPhoneNumber,
      websiteUri: websiteUri,
      summary: editorialSummary?.text,
      weeklyHours:
          (regularOpeningHours ?? currentOpeningHours)?.weekdayDescriptions ??
          const [],
    );
  }

  static const Map<String, PriceLevel> _priceLevels = {
    'PRICE_LEVEL_FREE': PriceLevel.free,
    'PRICE_LEVEL_INEXPENSIVE': PriceLevel.inexpensive,
    'PRICE_LEVEL_MODERATE': PriceLevel.moderate,
    'PRICE_LEVEL_EXPENSIVE': PriceLevel.expensive,
    'PRICE_LEVEL_VERY_EXPENSIVE': PriceLevel.veryExpensive,
  };
}

@freezed
abstract class LocalizedTextDto with _$LocalizedTextDto {
  const factory LocalizedTextDto({String? text}) = _LocalizedTextDto;

  factory LocalizedTextDto.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextDtoFromJson(json);
}

@freezed
abstract class OpeningHoursDto with _$OpeningHoursDto {
  const factory OpeningHoursDto({
    bool? openNow,
    @Default(<String>[]) List<String> weekdayDescriptions,
  }) = _OpeningHoursDto;

  factory OpeningHoursDto.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursDtoFromJson(json);
}

@freezed
abstract class PhotoDto with _$PhotoDto {
  const factory PhotoDto({required String name}) = _PhotoDto;

  factory PhotoDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoDtoFromJson(json);
}
