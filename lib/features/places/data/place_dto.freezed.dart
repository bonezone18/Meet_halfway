// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceDto {

 String get id; LocalizedTextDto? get displayName; String? get formattedAddress; String? get shortFormattedAddress; GeoPoint? get location; List<String> get types; LocalizedTextDto? get primaryTypeDisplayName; double? get rating; int? get userRatingCount; String? get priceLevel; OpeningHoursDto? get currentOpeningHours; OpeningHoursDto? get regularOpeningHours; List<PhotoDto> get photos; String? get googleMapsUri; String? get nationalPhoneNumber; String? get websiteUri; LocalizedTextDto? get editorialSummary;
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDtoCopyWith<PlaceDto> get copyWith => _$PlaceDtoCopyWithImpl<PlaceDto>(this as PlaceDto, _$identity);

  /// Serializes this PlaceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.formattedAddress, _this.formattedAddress) || other.formattedAddress == _this.formattedAddress)&&(identical(other.shortFormattedAddress, _this.shortFormattedAddress) || other.shortFormattedAddress == _this.shortFormattedAddress)&&(identical(other.location, _this.location) || other.location == _this.location)&&const DeepCollectionEquality().equals(other.types, _this.types)&&(identical(other.primaryTypeDisplayName, _this.primaryTypeDisplayName) || other.primaryTypeDisplayName == _this.primaryTypeDisplayName)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.userRatingCount, _this.userRatingCount) || other.userRatingCount == _this.userRatingCount)&&(identical(other.priceLevel, _this.priceLevel) || other.priceLevel == _this.priceLevel)&&(identical(other.currentOpeningHours, _this.currentOpeningHours) || other.currentOpeningHours == _this.currentOpeningHours)&&(identical(other.regularOpeningHours, _this.regularOpeningHours) || other.regularOpeningHours == _this.regularOpeningHours)&&const DeepCollectionEquality().equals(other.photos, _this.photos)&&(identical(other.googleMapsUri, _this.googleMapsUri) || other.googleMapsUri == _this.googleMapsUri)&&(identical(other.nationalPhoneNumber, _this.nationalPhoneNumber) || other.nationalPhoneNumber == _this.nationalPhoneNumber)&&(identical(other.websiteUri, _this.websiteUri) || other.websiteUri == _this.websiteUri)&&(identical(other.editorialSummary, _this.editorialSummary) || other.editorialSummary == _this.editorialSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceDto;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.formattedAddress,_this.shortFormattedAddress,_this.location,const DeepCollectionEquality().hash(_this.types),_this.primaryTypeDisplayName,_this.rating,_this.userRatingCount,_this.priceLevel,_this.currentOpeningHours,_this.regularOpeningHours,const DeepCollectionEquality().hash(_this.photos),_this.googleMapsUri,_this.nationalPhoneNumber,_this.websiteUri,_this.editorialSummary);
}

@override
String toString() {
  final _this = this as PlaceDto;
  return 'PlaceDto(id: ${_this.id}, displayName: ${_this.displayName}, formattedAddress: ${_this.formattedAddress}, shortFormattedAddress: ${_this.shortFormattedAddress}, location: ${_this.location}, types: ${_this.types}, primaryTypeDisplayName: ${_this.primaryTypeDisplayName}, rating: ${_this.rating}, userRatingCount: ${_this.userRatingCount}, priceLevel: ${_this.priceLevel}, currentOpeningHours: ${_this.currentOpeningHours}, regularOpeningHours: ${_this.regularOpeningHours}, photos: ${_this.photos}, googleMapsUri: ${_this.googleMapsUri}, nationalPhoneNumber: ${_this.nationalPhoneNumber}, websiteUri: ${_this.websiteUri}, editorialSummary: ${_this.editorialSummary})';
}


}

/// @nodoc
abstract mixin class $PlaceDtoCopyWith<$Res>  {
  factory $PlaceDtoCopyWith(PlaceDto value, $Res Function(PlaceDto) _then) = _$PlaceDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto? displayName, String? formattedAddress, String? shortFormattedAddress, GeoPoint? location, List<String> types, LocalizedTextDto? primaryTypeDisplayName, double? rating, int? userRatingCount, String? priceLevel, OpeningHoursDto? currentOpeningHours, OpeningHoursDto? regularOpeningHours, List<PhotoDto> photos, String? googleMapsUri, String? nationalPhoneNumber, String? websiteUri, LocalizedTextDto? editorialSummary
});


$LocalizedTextDtoCopyWith<$Res>? get displayName;$GeoPointCopyWith<$Res>? get location;$LocalizedTextDtoCopyWith<$Res>? get primaryTypeDisplayName;$OpeningHoursDtoCopyWith<$Res>? get currentOpeningHours;$OpeningHoursDtoCopyWith<$Res>? get regularOpeningHours;$LocalizedTextDtoCopyWith<$Res>? get editorialSummary;

}
/// @nodoc
class _$PlaceDtoCopyWithImpl<$Res>
    implements $PlaceDtoCopyWith<$Res> {
  _$PlaceDtoCopyWithImpl(this._self, this._then);

  final PlaceDto _self;
  final $Res Function(PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = freezed,Object? formattedAddress = freezed,Object? shortFormattedAddress = freezed,Object? location = freezed,Object? types = null,Object? primaryTypeDisplayName = freezed,Object? rating = freezed,Object? userRatingCount = freezed,Object? priceLevel = freezed,Object? currentOpeningHours = freezed,Object? regularOpeningHours = freezed,Object? photos = null,Object? googleMapsUri = freezed,Object? nationalPhoneNumber = freezed,Object? websiteUri = freezed,Object? editorialSummary = freezed,}) {
  return _then(PlaceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,formattedAddress: freezed == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String?,shortFormattedAddress: freezed == shortFormattedAddress ? _self.shortFormattedAddress : shortFormattedAddress // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,primaryTypeDisplayName: freezed == primaryTypeDisplayName ? _self.primaryTypeDisplayName : primaryTypeDisplayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,userRatingCount: freezed == userRatingCount ? _self.userRatingCount : userRatingCount // ignore: cast_nullable_to_non_nullable
as int?,priceLevel: freezed == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as String?,currentOpeningHours: freezed == currentOpeningHours ? _self.currentOpeningHours : currentOpeningHours // ignore: cast_nullable_to_non_nullable
as OpeningHoursDto?,regularOpeningHours: freezed == regularOpeningHours ? _self.regularOpeningHours : regularOpeningHours // ignore: cast_nullable_to_non_nullable
as OpeningHoursDto?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoDto>,googleMapsUri: freezed == googleMapsUri ? _self.googleMapsUri : googleMapsUri // ignore: cast_nullable_to_non_nullable
as String?,nationalPhoneNumber: freezed == nationalPhoneNumber ? _self.nationalPhoneNumber : nationalPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,websiteUri: freezed == websiteUri ? _self.websiteUri : websiteUri // ignore: cast_nullable_to_non_nullable
as String?,editorialSummary: freezed == editorialSummary ? _self.editorialSummary : editorialSummary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get primaryTypeDisplayName {
    if (_self.primaryTypeDisplayName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.primaryTypeDisplayName!, (value) {
    return _then(_self.copyWith(primaryTypeDisplayName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursDtoCopyWith<$Res>? get currentOpeningHours {
    if (_self.currentOpeningHours == null) {
    return null;
  }

  return $OpeningHoursDtoCopyWith<$Res>(_self.currentOpeningHours!, (value) {
    return _then(_self.copyWith(currentOpeningHours: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursDtoCopyWith<$Res>? get regularOpeningHours {
    if (_self.regularOpeningHours == null) {
    return null;
  }

  return $OpeningHoursDtoCopyWith<$Res>(_self.regularOpeningHours!, (value) {
    return _then(_self.copyWith(regularOpeningHours: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get editorialSummary {
    if (_self.editorialSummary == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.editorialSummary!, (value) {
    return _then(_self.copyWith(editorialSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDto].
extension PlaceDtoPatterns on PlaceDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto? displayName,  String? formattedAddress,  String? shortFormattedAddress,  GeoPoint? location,  List<String> types,  LocalizedTextDto? primaryTypeDisplayName,  double? rating,  int? userRatingCount,  String? priceLevel,  OpeningHoursDto? currentOpeningHours,  OpeningHoursDto? regularOpeningHours,  List<PhotoDto> photos,  String? googleMapsUri,  String? nationalPhoneNumber,  String? websiteUri,  LocalizedTextDto? editorialSummary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.id,_that.displayName,_that.formattedAddress,_that.shortFormattedAddress,_that.location,_that.types,_that.primaryTypeDisplayName,_that.rating,_that.userRatingCount,_that.priceLevel,_that.currentOpeningHours,_that.regularOpeningHours,_that.photos,_that.googleMapsUri,_that.nationalPhoneNumber,_that.websiteUri,_that.editorialSummary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto? displayName,  String? formattedAddress,  String? shortFormattedAddress,  GeoPoint? location,  List<String> types,  LocalizedTextDto? primaryTypeDisplayName,  double? rating,  int? userRatingCount,  String? priceLevel,  OpeningHoursDto? currentOpeningHours,  OpeningHoursDto? regularOpeningHours,  List<PhotoDto> photos,  String? googleMapsUri,  String? nationalPhoneNumber,  String? websiteUri,  LocalizedTextDto? editorialSummary)  $default,) {final _that = this;
switch (_that) {
case _PlaceDto():
return $default(_that.id,_that.displayName,_that.formattedAddress,_that.shortFormattedAddress,_that.location,_that.types,_that.primaryTypeDisplayName,_that.rating,_that.userRatingCount,_that.priceLevel,_that.currentOpeningHours,_that.regularOpeningHours,_that.photos,_that.googleMapsUri,_that.nationalPhoneNumber,_that.websiteUri,_that.editorialSummary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto? displayName,  String? formattedAddress,  String? shortFormattedAddress,  GeoPoint? location,  List<String> types,  LocalizedTextDto? primaryTypeDisplayName,  double? rating,  int? userRatingCount,  String? priceLevel,  OpeningHoursDto? currentOpeningHours,  OpeningHoursDto? regularOpeningHours,  List<PhotoDto> photos,  String? googleMapsUri,  String? nationalPhoneNumber,  String? websiteUri,  LocalizedTextDto? editorialSummary)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.id,_that.displayName,_that.formattedAddress,_that.shortFormattedAddress,_that.location,_that.types,_that.primaryTypeDisplayName,_that.rating,_that.userRatingCount,_that.priceLevel,_that.currentOpeningHours,_that.regularOpeningHours,_that.photos,_that.googleMapsUri,_that.nationalPhoneNumber,_that.websiteUri,_that.editorialSummary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDto extends PlaceDto {
  const _PlaceDto({required this.id, this.displayName, this.formattedAddress, this.shortFormattedAddress, this.location,  List<String> types = const <String>[], this.primaryTypeDisplayName, this.rating, this.userRatingCount, this.priceLevel, this.currentOpeningHours, this.regularOpeningHours,  List<PhotoDto> photos = const <PhotoDto>[], this.googleMapsUri, this.nationalPhoneNumber, this.websiteUri, this.editorialSummary}): _types = types,_photos = photos,super._();
  factory _PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto? displayName;
@override final  String? formattedAddress;
@override final  String? shortFormattedAddress;
@override final  GeoPoint? location;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  LocalizedTextDto? primaryTypeDisplayName;
@override final  double? rating;
@override final  int? userRatingCount;
@override final  String? priceLevel;
@override final  OpeningHoursDto? currentOpeningHours;
@override final  OpeningHoursDto? regularOpeningHours;
 final  List<PhotoDto> _photos;
@override@JsonKey() List<PhotoDto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  String? googleMapsUri;
@override final  String? nationalPhoneNumber;
@override final  String? websiteUri;
@override final  LocalizedTextDto? editorialSummary;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDtoCopyWith<_PlaceDto> get copyWith => __$PlaceDtoCopyWithImpl<_PlaceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.shortFormattedAddress, shortFormattedAddress) || other.shortFormattedAddress == shortFormattedAddress)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.types, _types)&&(identical(other.primaryTypeDisplayName, primaryTypeDisplayName) || other.primaryTypeDisplayName == primaryTypeDisplayName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.userRatingCount, userRatingCount) || other.userRatingCount == userRatingCount)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.currentOpeningHours, currentOpeningHours) || other.currentOpeningHours == currentOpeningHours)&&(identical(other.regularOpeningHours, regularOpeningHours) || other.regularOpeningHours == regularOpeningHours)&&const DeepCollectionEquality().equals(other.photos, _photos)&&(identical(other.googleMapsUri, googleMapsUri) || other.googleMapsUri == googleMapsUri)&&(identical(other.nationalPhoneNumber, nationalPhoneNumber) || other.nationalPhoneNumber == nationalPhoneNumber)&&(identical(other.websiteUri, websiteUri) || other.websiteUri == websiteUri)&&(identical(other.editorialSummary, editorialSummary) || other.editorialSummary == editorialSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,formattedAddress,shortFormattedAddress,location,const DeepCollectionEquality().hash(_types),primaryTypeDisplayName,rating,userRatingCount,priceLevel,currentOpeningHours,regularOpeningHours,const DeepCollectionEquality().hash(_photos),googleMapsUri,nationalPhoneNumber,websiteUri,editorialSummary);
}

@override
String toString() {
    return 'PlaceDto(id: $id, displayName: $displayName, formattedAddress: $formattedAddress, shortFormattedAddress: $shortFormattedAddress, location: $location, types: $types, primaryTypeDisplayName: $primaryTypeDisplayName, rating: $rating, userRatingCount: $userRatingCount, priceLevel: $priceLevel, currentOpeningHours: $currentOpeningHours, regularOpeningHours: $regularOpeningHours, photos: $photos, googleMapsUri: $googleMapsUri, nationalPhoneNumber: $nationalPhoneNumber, websiteUri: $websiteUri, editorialSummary: $editorialSummary)';
}


}

/// @nodoc
abstract mixin class _$PlaceDtoCopyWith<$Res> implements $PlaceDtoCopyWith<$Res> {
  factory _$PlaceDtoCopyWith(_PlaceDto value, $Res Function(_PlaceDto) _then) = __$PlaceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto? displayName, String? formattedAddress, String? shortFormattedAddress, GeoPoint? location, List<String> types, LocalizedTextDto? primaryTypeDisplayName, double? rating, int? userRatingCount, String? priceLevel, OpeningHoursDto? currentOpeningHours, OpeningHoursDto? regularOpeningHours, List<PhotoDto> photos, String? googleMapsUri, String? nationalPhoneNumber, String? websiteUri, LocalizedTextDto? editorialSummary
});


@override $LocalizedTextDtoCopyWith<$Res>? get displayName;@override $GeoPointCopyWith<$Res>? get location;@override $LocalizedTextDtoCopyWith<$Res>? get primaryTypeDisplayName;@override $OpeningHoursDtoCopyWith<$Res>? get currentOpeningHours;@override $OpeningHoursDtoCopyWith<$Res>? get regularOpeningHours;@override $LocalizedTextDtoCopyWith<$Res>? get editorialSummary;

}
/// @nodoc
class __$PlaceDtoCopyWithImpl<$Res>
    implements _$PlaceDtoCopyWith<$Res> {
  __$PlaceDtoCopyWithImpl(this._self, this._then);

  final _PlaceDto _self;
  final $Res Function(_PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = freezed,Object? formattedAddress = freezed,Object? shortFormattedAddress = freezed,Object? location = freezed,Object? types = null,Object? primaryTypeDisplayName = freezed,Object? rating = freezed,Object? userRatingCount = freezed,Object? priceLevel = freezed,Object? currentOpeningHours = freezed,Object? regularOpeningHours = freezed,Object? photos = null,Object? googleMapsUri = freezed,Object? nationalPhoneNumber = freezed,Object? websiteUri = freezed,Object? editorialSummary = freezed,}) {
  return _then(_PlaceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,formattedAddress: freezed == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String?,shortFormattedAddress: freezed == shortFormattedAddress ? _self.shortFormattedAddress : shortFormattedAddress // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,primaryTypeDisplayName: freezed == primaryTypeDisplayName ? _self.primaryTypeDisplayName : primaryTypeDisplayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,userRatingCount: freezed == userRatingCount ? _self.userRatingCount : userRatingCount // ignore: cast_nullable_to_non_nullable
as int?,priceLevel: freezed == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as String?,currentOpeningHours: freezed == currentOpeningHours ? _self.currentOpeningHours : currentOpeningHours // ignore: cast_nullable_to_non_nullable
as OpeningHoursDto?,regularOpeningHours: freezed == regularOpeningHours ? _self.regularOpeningHours : regularOpeningHours // ignore: cast_nullable_to_non_nullable
as OpeningHoursDto?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoDto>,googleMapsUri: freezed == googleMapsUri ? _self.googleMapsUri : googleMapsUri // ignore: cast_nullable_to_non_nullable
as String?,nationalPhoneNumber: freezed == nationalPhoneNumber ? _self.nationalPhoneNumber : nationalPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,websiteUri: freezed == websiteUri ? _self.websiteUri : websiteUri // ignore: cast_nullable_to_non_nullable
as String?,editorialSummary: freezed == editorialSummary ? _self.editorialSummary : editorialSummary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get primaryTypeDisplayName {
    if (_self.primaryTypeDisplayName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.primaryTypeDisplayName!, (value) {
    return _then(_self.copyWith(primaryTypeDisplayName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursDtoCopyWith<$Res>? get currentOpeningHours {
    if (_self.currentOpeningHours == null) {
    return null;
  }

  return $OpeningHoursDtoCopyWith<$Res>(_self.currentOpeningHours!, (value) {
    return _then(_self.copyWith(currentOpeningHours: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursDtoCopyWith<$Res>? get regularOpeningHours {
    if (_self.regularOpeningHours == null) {
    return null;
  }

  return $OpeningHoursDtoCopyWith<$Res>(_self.regularOpeningHours!, (value) {
    return _then(_self.copyWith(regularOpeningHours: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get editorialSummary {
    if (_self.editorialSummary == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.editorialSummary!, (value) {
    return _then(_self.copyWith(editorialSummary: value));
  });
}
}


/// @nodoc
mixin _$LocalizedTextDto {

 String? get text;
/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<LocalizedTextDto> get copyWith => _$LocalizedTextDtoCopyWithImpl<LocalizedTextDto>(this as LocalizedTextDto, _$identity);

  /// Serializes this LocalizedTextDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LocalizedTextDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedTextDto&&(identical(other.text, _this.text) || other.text == _this.text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LocalizedTextDto;
  return Object.hash(runtimeType,_this.text);
}

@override
String toString() {
  final _this = this as LocalizedTextDto;
  return 'LocalizedTextDto(text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $LocalizedTextDtoCopyWith<$Res>  {
  factory $LocalizedTextDtoCopyWith(LocalizedTextDto value, $Res Function(LocalizedTextDto) _then) = _$LocalizedTextDtoCopyWithImpl;
@useResult
$Res call({
 String? text
});




}
/// @nodoc
class _$LocalizedTextDtoCopyWithImpl<$Res>
    implements $LocalizedTextDtoCopyWith<$Res> {
  _$LocalizedTextDtoCopyWithImpl(this._self, this._then);

  final LocalizedTextDto _self;
  final $Res Function(LocalizedTextDto) _then;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,}) {
  return _then(LocalizedTextDto(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalizedTextDto].
extension LocalizedTextDtoPatterns on LocalizedTextDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizedTextDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizedTextDto value)  $default,){
final _that = this;
switch (_that) {
case _LocalizedTextDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizedTextDto value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that.text);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text)  $default,) {final _that = this;
switch (_that) {
case _LocalizedTextDto():
return $default(_that.text);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text)?  $default,) {final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalizedTextDto implements LocalizedTextDto {
  const _LocalizedTextDto({this.text});
  factory _LocalizedTextDto.fromJson(Map<String, dynamic> json) => _$LocalizedTextDtoFromJson(json);

@override final  String? text;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedTextDtoCopyWith<_LocalizedTextDto> get copyWith => __$LocalizedTextDtoCopyWithImpl<_LocalizedTextDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalizedTextDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedTextDto&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'LocalizedTextDto(text: $text)';
}


}

/// @nodoc
abstract mixin class _$LocalizedTextDtoCopyWith<$Res> implements $LocalizedTextDtoCopyWith<$Res> {
  factory _$LocalizedTextDtoCopyWith(_LocalizedTextDto value, $Res Function(_LocalizedTextDto) _then) = __$LocalizedTextDtoCopyWithImpl;
@override @useResult
$Res call({
 String? text
});




}
/// @nodoc
class __$LocalizedTextDtoCopyWithImpl<$Res>
    implements _$LocalizedTextDtoCopyWith<$Res> {
  __$LocalizedTextDtoCopyWithImpl(this._self, this._then);

  final _LocalizedTextDto _self;
  final $Res Function(_LocalizedTextDto) _then;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,}) {
  return _then(_LocalizedTextDto(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OpeningHoursDto {

 bool? get openNow; List<String> get weekdayDescriptions;
/// Create a copy of OpeningHoursDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpeningHoursDtoCopyWith<OpeningHoursDto> get copyWith => _$OpeningHoursDtoCopyWithImpl<OpeningHoursDto>(this as OpeningHoursDto, _$identity);

  /// Serializes this OpeningHoursDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OpeningHoursDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpeningHoursDto&&(identical(other.openNow, _this.openNow) || other.openNow == _this.openNow)&&const DeepCollectionEquality().equals(other.weekdayDescriptions, _this.weekdayDescriptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OpeningHoursDto;
  return Object.hash(runtimeType,_this.openNow,const DeepCollectionEquality().hash(_this.weekdayDescriptions));
}

@override
String toString() {
  final _this = this as OpeningHoursDto;
  return 'OpeningHoursDto(openNow: ${_this.openNow}, weekdayDescriptions: ${_this.weekdayDescriptions})';
}


}

/// @nodoc
abstract mixin class $OpeningHoursDtoCopyWith<$Res>  {
  factory $OpeningHoursDtoCopyWith(OpeningHoursDto value, $Res Function(OpeningHoursDto) _then) = _$OpeningHoursDtoCopyWithImpl;
@useResult
$Res call({
 bool? openNow, List<String> weekdayDescriptions
});




}
/// @nodoc
class _$OpeningHoursDtoCopyWithImpl<$Res>
    implements $OpeningHoursDtoCopyWith<$Res> {
  _$OpeningHoursDtoCopyWithImpl(this._self, this._then);

  final OpeningHoursDto _self;
  final $Res Function(OpeningHoursDto) _then;

/// Create a copy of OpeningHoursDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? openNow = freezed,Object? weekdayDescriptions = null,}) {
  return _then(OpeningHoursDto(
openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,weekdayDescriptions: null == weekdayDescriptions ? _self.weekdayDescriptions : weekdayDescriptions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpeningHoursDto].
extension OpeningHoursDtoPatterns on OpeningHoursDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpeningHoursDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpeningHoursDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpeningHoursDto value)  $default,){
final _that = this;
switch (_that) {
case _OpeningHoursDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpeningHoursDto value)?  $default,){
final _that = this;
switch (_that) {
case _OpeningHoursDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? openNow,  List<String> weekdayDescriptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpeningHoursDto() when $default != null:
return $default(_that.openNow,_that.weekdayDescriptions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? openNow,  List<String> weekdayDescriptions)  $default,) {final _that = this;
switch (_that) {
case _OpeningHoursDto():
return $default(_that.openNow,_that.weekdayDescriptions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? openNow,  List<String> weekdayDescriptions)?  $default,) {final _that = this;
switch (_that) {
case _OpeningHoursDto() when $default != null:
return $default(_that.openNow,_that.weekdayDescriptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpeningHoursDto implements OpeningHoursDto {
  const _OpeningHoursDto({this.openNow,  List<String> weekdayDescriptions = const <String>[]}): _weekdayDescriptions = weekdayDescriptions;
  factory _OpeningHoursDto.fromJson(Map<String, dynamic> json) => _$OpeningHoursDtoFromJson(json);

@override final  bool? openNow;
 final  List<String> _weekdayDescriptions;
@override@JsonKey() List<String> get weekdayDescriptions {
  if (_weekdayDescriptions is EqualUnmodifiableListView) return _weekdayDescriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekdayDescriptions);
}


/// Create a copy of OpeningHoursDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpeningHoursDtoCopyWith<_OpeningHoursDto> get copyWith => __$OpeningHoursDtoCopyWithImpl<_OpeningHoursDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpeningHoursDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpeningHoursDto&&(identical(other.openNow, openNow) || other.openNow == openNow)&&const DeepCollectionEquality().equals(other.weekdayDescriptions, _weekdayDescriptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,openNow,const DeepCollectionEquality().hash(_weekdayDescriptions));
}

@override
String toString() {
    return 'OpeningHoursDto(openNow: $openNow, weekdayDescriptions: $weekdayDescriptions)';
}


}

/// @nodoc
abstract mixin class _$OpeningHoursDtoCopyWith<$Res> implements $OpeningHoursDtoCopyWith<$Res> {
  factory _$OpeningHoursDtoCopyWith(_OpeningHoursDto value, $Res Function(_OpeningHoursDto) _then) = __$OpeningHoursDtoCopyWithImpl;
@override @useResult
$Res call({
 bool? openNow, List<String> weekdayDescriptions
});




}
/// @nodoc
class __$OpeningHoursDtoCopyWithImpl<$Res>
    implements _$OpeningHoursDtoCopyWith<$Res> {
  __$OpeningHoursDtoCopyWithImpl(this._self, this._then);

  final _OpeningHoursDto _self;
  final $Res Function(_OpeningHoursDto) _then;

/// Create a copy of OpeningHoursDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? openNow = freezed,Object? weekdayDescriptions = null,}) {
  return _then(_OpeningHoursDto(
openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,weekdayDescriptions: null == weekdayDescriptions ? _self._weekdayDescriptions : weekdayDescriptions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PhotoDto {

 String get name;
/// Create a copy of PhotoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoDtoCopyWith<PhotoDto> get copyWith => _$PhotoDtoCopyWithImpl<PhotoDto>(this as PhotoDto, _$identity);

  /// Serializes this PhotoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhotoDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoDto&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhotoDto;
  return Object.hash(runtimeType,_this.name);
}

@override
String toString() {
  final _this = this as PhotoDto;
  return 'PhotoDto(name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $PhotoDtoCopyWith<$Res>  {
  factory $PhotoDtoCopyWith(PhotoDto value, $Res Function(PhotoDto) _then) = _$PhotoDtoCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$PhotoDtoCopyWithImpl<$Res>
    implements $PhotoDtoCopyWith<$Res> {
  _$PhotoDtoCopyWithImpl(this._self, this._then);

  final PhotoDto _self;
  final $Res Function(PhotoDto) _then;

/// Create a copy of PhotoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(PhotoDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoDto].
extension PhotoDtoPatterns on PhotoDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoDto value)  $default,){
final _that = this;
switch (_that) {
case _PhotoDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoDto value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoDto() when $default != null:
return $default(_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _PhotoDto():
return $default(_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _PhotoDto() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoDto implements PhotoDto {
  const _PhotoDto({required this.name});
  factory _PhotoDto.fromJson(Map<String, dynamic> json) => _$PhotoDtoFromJson(json);

@override final  String name;

/// Create a copy of PhotoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoDtoCopyWith<_PhotoDto> get copyWith => __$PhotoDtoCopyWithImpl<_PhotoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoDto&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name);
}

@override
String toString() {
    return 'PhotoDto(name: $name)';
}


}

/// @nodoc
abstract mixin class _$PhotoDtoCopyWith<$Res> implements $PhotoDtoCopyWith<$Res> {
  factory _$PhotoDtoCopyWith(_PhotoDto value, $Res Function(_PhotoDto) _then) = __$PhotoDtoCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$PhotoDtoCopyWithImpl<$Res>
    implements _$PhotoDtoCopyWith<$Res> {
  __$PhotoDtoCopyWithImpl(this._self, this._then);

  final _PhotoDto _self;
  final $Res Function(_PhotoDto) _then;

/// Create a copy of PhotoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_PhotoDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
