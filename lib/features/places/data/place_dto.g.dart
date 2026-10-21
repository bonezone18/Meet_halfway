// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => _PlaceDto(
  id: json['id'] as String,
  displayName: json['displayName'] == null
      ? null
      : LocalizedTextDto.fromJson(json['displayName'] as Map<String, dynamic>),
  formattedAddress: json['formattedAddress'] as String?,
  shortFormattedAddress: json['shortFormattedAddress'] as String?,
  location: json['location'] == null
      ? null
      : GeoPoint.fromJson(json['location'] as Map<String, dynamic>),
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  primaryTypeDisplayName: json['primaryTypeDisplayName'] == null
      ? null
      : LocalizedTextDto.fromJson(
          json['primaryTypeDisplayName'] as Map<String, dynamic>,
        ),
  rating: (json['rating'] as num?)?.toDouble(),
  userRatingCount: (json['userRatingCount'] as num?)?.toInt(),
  priceLevel: json['priceLevel'] as String?,
  currentOpeningHours: json['currentOpeningHours'] == null
      ? null
      : OpeningHoursDto.fromJson(
          json['currentOpeningHours'] as Map<String, dynamic>,
        ),
  regularOpeningHours: json['regularOpeningHours'] == null
      ? null
      : OpeningHoursDto.fromJson(
          json['regularOpeningHours'] as Map<String, dynamic>,
        ),
  photos:
      (json['photos'] as List<dynamic>?)
          ?.map((e) => PhotoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PhotoDto>[],
  googleMapsUri: json['googleMapsUri'] as String?,
  nationalPhoneNumber: json['nationalPhoneNumber'] as String?,
  websiteUri: json['websiteUri'] as String?,
  editorialSummary: json['editorialSummary'] == null
      ? null
      : LocalizedTextDto.fromJson(
          json['editorialSummary'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PlaceDtoToJson(_PlaceDto instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'formattedAddress': instance.formattedAddress,
  'shortFormattedAddress': instance.shortFormattedAddress,
  'location': instance.location,
  'types': instance.types,
  'primaryTypeDisplayName': instance.primaryTypeDisplayName,
  'rating': instance.rating,
  'userRatingCount': instance.userRatingCount,
  'priceLevel': instance.priceLevel,
  'currentOpeningHours': instance.currentOpeningHours,
  'regularOpeningHours': instance.regularOpeningHours,
  'photos': instance.photos,
  'googleMapsUri': instance.googleMapsUri,
  'nationalPhoneNumber': instance.nationalPhoneNumber,
  'websiteUri': instance.websiteUri,
  'editorialSummary': instance.editorialSummary,
};

_LocalizedTextDto _$LocalizedTextDtoFromJson(Map<String, dynamic> json) =>
    _LocalizedTextDto(text: json['text'] as String?);

Map<String, dynamic> _$LocalizedTextDtoToJson(_LocalizedTextDto instance) =>
    <String, dynamic>{'text': instance.text};

_OpeningHoursDto _$OpeningHoursDtoFromJson(Map<String, dynamic> json) =>
    _OpeningHoursDto(
      openNow: json['openNow'] as bool?,
      weekdayDescriptions:
          (json['weekdayDescriptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$OpeningHoursDtoToJson(_OpeningHoursDto instance) =>
    <String, dynamic>{
      'openNow': instance.openNow,
      'weekdayDescriptions': instance.weekdayDescriptions,
    };

_PhotoDto _$PhotoDtoFromJson(Map<String, dynamic> json) =>
    _PhotoDto(name: json['name'] as String);

Map<String, dynamic> _$PhotoDtoToJson(_PhotoDto instance) => <String, dynamic>{
  'name': instance.name,
};
