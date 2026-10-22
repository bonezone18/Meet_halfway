// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Venue {

 String get id; String get name; GeoPoint get location; String get address; List<String> get types; String? get primaryTypeLabel; double? get rating; int? get ratingCount; PriceLevel? get priceLevel; bool? get openNow; String? get photoName; String? get googleMapsUri;
/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueCopyWith<Venue> get copyWith => _$VenueCopyWithImpl<Venue>(this as Venue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Venue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Venue&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.address, _this.address) || other.address == _this.address)&&const DeepCollectionEquality().equals(other.types, _this.types)&&(identical(other.primaryTypeLabel, _this.primaryTypeLabel) || other.primaryTypeLabel == _this.primaryTypeLabel)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&(identical(other.priceLevel, _this.priceLevel) || other.priceLevel == _this.priceLevel)&&(identical(other.openNow, _this.openNow) || other.openNow == _this.openNow)&&(identical(other.photoName, _this.photoName) || other.photoName == _this.photoName)&&(identical(other.googleMapsUri, _this.googleMapsUri) || other.googleMapsUri == _this.googleMapsUri));
}


@override
int get hashCode {
  final _this = this as Venue;
  return Object.hash(runtimeType,_this.id,_this.name,_this.location,_this.address,const DeepCollectionEquality().hash(_this.types),_this.primaryTypeLabel,_this.rating,_this.ratingCount,_this.priceLevel,_this.openNow,_this.photoName,_this.googleMapsUri);
}

@override
String toString() {
  final _this = this as Venue;
  return 'Venue(id: ${_this.id}, name: ${_this.name}, location: ${_this.location}, address: ${_this.address}, types: ${_this.types}, primaryTypeLabel: ${_this.primaryTypeLabel}, rating: ${_this.rating}, ratingCount: ${_this.ratingCount}, priceLevel: ${_this.priceLevel}, openNow: ${_this.openNow}, photoName: ${_this.photoName}, googleMapsUri: ${_this.googleMapsUri})';
}


}

/// @nodoc
abstract mixin class $VenueCopyWith<$Res>  {
  factory $VenueCopyWith(Venue value, $Res Function(Venue) _then) = _$VenueCopyWithImpl;
@useResult
$Res call({
 String id, String name, GeoPoint location, String address, List<String> types, String? primaryTypeLabel, double? rating, int? ratingCount, PriceLevel? priceLevel, bool? openNow, String? photoName, String? googleMapsUri
});


$GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class _$VenueCopyWithImpl<$Res>
    implements $VenueCopyWith<$Res> {
  _$VenueCopyWithImpl(this._self, this._then);

  final Venue _self;
  final $Res Function(Venue) _then;

/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,Object? address = null,Object? types = null,Object? primaryTypeLabel = freezed,Object? rating = freezed,Object? ratingCount = freezed,Object? priceLevel = freezed,Object? openNow = freezed,Object? photoName = freezed,Object? googleMapsUri = freezed,}) {
  return _then(Venue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,primaryTypeLabel: freezed == primaryTypeLabel ? _self.primaryTypeLabel : primaryTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,priceLevel: freezed == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as PriceLevel?,openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,photoName: freezed == photoName ? _self.photoName : photoName // ignore: cast_nullable_to_non_nullable
as String?,googleMapsUri: freezed == googleMapsUri ? _self.googleMapsUri : googleMapsUri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Venue].
extension VenuePatterns on Venue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Venue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Venue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Venue value)  $default,){
final _that = this;
switch (_that) {
case _Venue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Venue value)?  $default,){
final _that = this;
switch (_that) {
case _Venue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint location,  String address,  List<String> types,  String? primaryTypeLabel,  double? rating,  int? ratingCount,  PriceLevel? priceLevel,  bool? openNow,  String? photoName,  String? googleMapsUri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Venue() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.address,_that.types,_that.primaryTypeLabel,_that.rating,_that.ratingCount,_that.priceLevel,_that.openNow,_that.photoName,_that.googleMapsUri);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint location,  String address,  List<String> types,  String? primaryTypeLabel,  double? rating,  int? ratingCount,  PriceLevel? priceLevel,  bool? openNow,  String? photoName,  String? googleMapsUri)  $default,) {final _that = this;
switch (_that) {
case _Venue():
return $default(_that.id,_that.name,_that.location,_that.address,_that.types,_that.primaryTypeLabel,_that.rating,_that.ratingCount,_that.priceLevel,_that.openNow,_that.photoName,_that.googleMapsUri);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  GeoPoint location,  String address,  List<String> types,  String? primaryTypeLabel,  double? rating,  int? ratingCount,  PriceLevel? priceLevel,  bool? openNow,  String? photoName,  String? googleMapsUri)?  $default,) {final _that = this;
switch (_that) {
case _Venue() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.address,_that.types,_that.primaryTypeLabel,_that.rating,_that.ratingCount,_that.priceLevel,_that.openNow,_that.photoName,_that.googleMapsUri);case _:
  return null;

}
}

}

/// @nodoc


class _Venue implements Venue {
  const _Venue({required this.id, required this.name, required this.location, this.address = '',  List<String> types = const <String>[], this.primaryTypeLabel, this.rating, this.ratingCount, this.priceLevel, this.openNow, this.photoName, this.googleMapsUri}): _types = types;
  

@override final  String id;
@override final  String name;
@override final  GeoPoint location;
@override@JsonKey() final  String address;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  String? primaryTypeLabel;
@override final  double? rating;
@override final  int? ratingCount;
@override final  PriceLevel? priceLevel;
@override final  bool? openNow;
@override final  String? photoName;
@override final  String? googleMapsUri;

/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueCopyWith<_Venue> get copyWith => __$VenueCopyWithImpl<_Venue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Venue&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.types, _types)&&(identical(other.primaryTypeLabel, primaryTypeLabel) || other.primaryTypeLabel == primaryTypeLabel)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.openNow, openNow) || other.openNow == openNow)&&(identical(other.photoName, photoName) || other.photoName == photoName)&&(identical(other.googleMapsUri, googleMapsUri) || other.googleMapsUri == googleMapsUri));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,location,address,const DeepCollectionEquality().hash(_types),primaryTypeLabel,rating,ratingCount,priceLevel,openNow,photoName,googleMapsUri);
}

@override
String toString() {
    return 'Venue(id: $id, name: $name, location: $location, address: $address, types: $types, primaryTypeLabel: $primaryTypeLabel, rating: $rating, ratingCount: $ratingCount, priceLevel: $priceLevel, openNow: $openNow, photoName: $photoName, googleMapsUri: $googleMapsUri)';
}


}

/// @nodoc
abstract mixin class _$VenueCopyWith<$Res> implements $VenueCopyWith<$Res> {
  factory _$VenueCopyWith(_Venue value, $Res Function(_Venue) _then) = __$VenueCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, GeoPoint location, String address, List<String> types, String? primaryTypeLabel, double? rating, int? ratingCount, PriceLevel? priceLevel, bool? openNow, String? photoName, String? googleMapsUri
});


@override $GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class __$VenueCopyWithImpl<$Res>
    implements _$VenueCopyWith<$Res> {
  __$VenueCopyWithImpl(this._self, this._then);

  final _Venue _self;
  final $Res Function(_Venue) _then;

/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,Object? address = null,Object? types = null,Object? primaryTypeLabel = freezed,Object? rating = freezed,Object? ratingCount = freezed,Object? priceLevel = freezed,Object? openNow = freezed,Object? photoName = freezed,Object? googleMapsUri = freezed,}) {
  return _then(_Venue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,primaryTypeLabel: freezed == primaryTypeLabel ? _self.primaryTypeLabel : primaryTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,priceLevel: freezed == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as PriceLevel?,openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,photoName: freezed == photoName ? _self.photoName : photoName // ignore: cast_nullable_to_non_nullable
as String?,googleMapsUri: freezed == googleMapsUri ? _self.googleMapsUri : googleMapsUri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Venue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc
mixin _$VenuePhoto {

 String get url; Map<String, String> get headers;
/// Create a copy of VenuePhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenuePhotoCopyWith<VenuePhoto> get copyWith => _$VenuePhotoCopyWithImpl<VenuePhoto>(this as VenuePhoto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VenuePhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenuePhoto&&(identical(other.url, _this.url) || other.url == _this.url)&&const DeepCollectionEquality().equals(other.headers, _this.headers));
}


@override
int get hashCode {
  final _this = this as VenuePhoto;
  return Object.hash(runtimeType,_this.url,const DeepCollectionEquality().hash(_this.headers));
}

@override
String toString() {
  final _this = this as VenuePhoto;
  return 'VenuePhoto(url: ${_this.url}, headers: ${_this.headers})';
}


}

/// @nodoc
abstract mixin class $VenuePhotoCopyWith<$Res>  {
  factory $VenuePhotoCopyWith(VenuePhoto value, $Res Function(VenuePhoto) _then) = _$VenuePhotoCopyWithImpl;
@useResult
$Res call({
 String url, Map<String, String> headers
});




}
/// @nodoc
class _$VenuePhotoCopyWithImpl<$Res>
    implements $VenuePhotoCopyWith<$Res> {
  _$VenuePhotoCopyWithImpl(this._self, this._then);

  final VenuePhoto _self;
  final $Res Function(VenuePhoto) _then;

/// Create a copy of VenuePhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? headers = null,}) {
  return _then(VenuePhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [VenuePhoto].
extension VenuePhotoPatterns on VenuePhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenuePhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenuePhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenuePhoto value)  $default,){
final _that = this;
switch (_that) {
case _VenuePhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenuePhoto value)?  $default,){
final _that = this;
switch (_that) {
case _VenuePhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  Map<String, String> headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenuePhoto() when $default != null:
return $default(_that.url,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  Map<String, String> headers)  $default,) {final _that = this;
switch (_that) {
case _VenuePhoto():
return $default(_that.url,_that.headers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  Map<String, String> headers)?  $default,) {final _that = this;
switch (_that) {
case _VenuePhoto() when $default != null:
return $default(_that.url,_that.headers);case _:
  return null;

}
}

}

/// @nodoc


class _VenuePhoto implements VenuePhoto {
  const _VenuePhoto({required this.url,  Map<String, String> headers = const <String, String>{}}): _headers = headers;
  

@override final  String url;
 final  Map<String, String> _headers;
@override@JsonKey() Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}


/// Create a copy of VenuePhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenuePhotoCopyWith<_VenuePhoto> get copyWith => __$VenuePhotoCopyWithImpl<_VenuePhoto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenuePhoto&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.headers, _headers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,const DeepCollectionEquality().hash(_headers));
}

@override
String toString() {
    return 'VenuePhoto(url: $url, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$VenuePhotoCopyWith<$Res> implements $VenuePhotoCopyWith<$Res> {
  factory _$VenuePhotoCopyWith(_VenuePhoto value, $Res Function(_VenuePhoto) _then) = __$VenuePhotoCopyWithImpl;
@override @useResult
$Res call({
 String url, Map<String, String> headers
});




}
/// @nodoc
class __$VenuePhotoCopyWithImpl<$Res>
    implements _$VenuePhotoCopyWith<$Res> {
  __$VenuePhotoCopyWithImpl(this._self, this._then);

  final _VenuePhoto _self;
  final $Res Function(_VenuePhoto) _then;

/// Create a copy of VenuePhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? headers = null,}) {
  return _then(_VenuePhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
mixin _$VenueDetails {

 Venue get venue; String? get phoneNumber; String? get websiteUri; String? get summary; List<String> get weeklyHours;
/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueDetailsCopyWith<VenueDetails> get copyWith => _$VenueDetailsCopyWithImpl<VenueDetails>(this as VenueDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VenueDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueDetails&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.websiteUri, _this.websiteUri) || other.websiteUri == _this.websiteUri)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.weeklyHours, _this.weeklyHours));
}


@override
int get hashCode {
  final _this = this as VenueDetails;
  return Object.hash(runtimeType,_this.venue,_this.phoneNumber,_this.websiteUri,_this.summary,const DeepCollectionEquality().hash(_this.weeklyHours));
}

@override
String toString() {
  final _this = this as VenueDetails;
  return 'VenueDetails(venue: ${_this.venue}, phoneNumber: ${_this.phoneNumber}, websiteUri: ${_this.websiteUri}, summary: ${_this.summary}, weeklyHours: ${_this.weeklyHours})';
}


}

/// @nodoc
abstract mixin class $VenueDetailsCopyWith<$Res>  {
  factory $VenueDetailsCopyWith(VenueDetails value, $Res Function(VenueDetails) _then) = _$VenueDetailsCopyWithImpl;
@useResult
$Res call({
 Venue venue, String? phoneNumber, String? websiteUri, String? summary, List<String> weeklyHours
});


$VenueCopyWith<$Res> get venue;

}
/// @nodoc
class _$VenueDetailsCopyWithImpl<$Res>
    implements $VenueDetailsCopyWith<$Res> {
  _$VenueDetailsCopyWithImpl(this._self, this._then);

  final VenueDetails _self;
  final $Res Function(VenueDetails) _then;

/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? venue = null,Object? phoneNumber = freezed,Object? websiteUri = freezed,Object? summary = freezed,Object? weeklyHours = null,}) {
  return _then(VenueDetails(
venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as Venue,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,websiteUri: freezed == websiteUri ? _self.websiteUri : websiteUri // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,weeklyHours: null == weeklyHours ? _self.weeklyHours : weeklyHours // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VenueCopyWith<$Res> get venue {
  
  return $VenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}
}


/// Adds pattern-matching-related methods to [VenueDetails].
extension VenueDetailsPatterns on VenueDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueDetails value)  $default,){
final _that = this;
switch (_that) {
case _VenueDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueDetails value)?  $default,){
final _that = this;
switch (_that) {
case _VenueDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Venue venue,  String? phoneNumber,  String? websiteUri,  String? summary,  List<String> weeklyHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueDetails() when $default != null:
return $default(_that.venue,_that.phoneNumber,_that.websiteUri,_that.summary,_that.weeklyHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Venue venue,  String? phoneNumber,  String? websiteUri,  String? summary,  List<String> weeklyHours)  $default,) {final _that = this;
switch (_that) {
case _VenueDetails():
return $default(_that.venue,_that.phoneNumber,_that.websiteUri,_that.summary,_that.weeklyHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Venue venue,  String? phoneNumber,  String? websiteUri,  String? summary,  List<String> weeklyHours)?  $default,) {final _that = this;
switch (_that) {
case _VenueDetails() when $default != null:
return $default(_that.venue,_that.phoneNumber,_that.websiteUri,_that.summary,_that.weeklyHours);case _:
  return null;

}
}

}

/// @nodoc


class _VenueDetails implements VenueDetails {
  const _VenueDetails({required this.venue, this.phoneNumber, this.websiteUri, this.summary,  List<String> weeklyHours = const <String>[]}): _weeklyHours = weeklyHours;
  

@override final  Venue venue;
@override final  String? phoneNumber;
@override final  String? websiteUri;
@override final  String? summary;
 final  List<String> _weeklyHours;
@override@JsonKey() List<String> get weeklyHours {
  if (_weeklyHours is EqualUnmodifiableListView) return _weeklyHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyHours);
}


/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueDetailsCopyWith<_VenueDetails> get copyWith => __$VenueDetailsCopyWithImpl<_VenueDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueDetails&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.websiteUri, websiteUri) || other.websiteUri == websiteUri)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.weeklyHours, _weeklyHours));
}


@override
int get hashCode {
    return Object.hash(runtimeType,venue,phoneNumber,websiteUri,summary,const DeepCollectionEquality().hash(_weeklyHours));
}

@override
String toString() {
    return 'VenueDetails(venue: $venue, phoneNumber: $phoneNumber, websiteUri: $websiteUri, summary: $summary, weeklyHours: $weeklyHours)';
}


}

/// @nodoc
abstract mixin class _$VenueDetailsCopyWith<$Res> implements $VenueDetailsCopyWith<$Res> {
  factory _$VenueDetailsCopyWith(_VenueDetails value, $Res Function(_VenueDetails) _then) = __$VenueDetailsCopyWithImpl;
@override @useResult
$Res call({
 Venue venue, String? phoneNumber, String? websiteUri, String? summary, List<String> weeklyHours
});


@override $VenueCopyWith<$Res> get venue;

}
/// @nodoc
class __$VenueDetailsCopyWithImpl<$Res>
    implements _$VenueDetailsCopyWith<$Res> {
  __$VenueDetailsCopyWithImpl(this._self, this._then);

  final _VenueDetails _self;
  final $Res Function(_VenueDetails) _then;

/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? venue = null,Object? phoneNumber = freezed,Object? websiteUri = freezed,Object? summary = freezed,Object? weeklyHours = null,}) {
  return _then(_VenueDetails(
venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as Venue,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,websiteUri: freezed == websiteUri ? _self.websiteUri : websiteUri // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,weeklyHours: null == weeklyHours ? _self._weeklyHours : weeklyHours // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of VenueDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VenueCopyWith<$Res> get venue {
  
  return $VenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}
}

// dart format on
