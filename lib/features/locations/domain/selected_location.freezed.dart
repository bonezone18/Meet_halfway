// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectedLocation {

 String get label; GeoPoint get point; LocationSource get source; String? get placeId;
/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedLocationCopyWith<SelectedLocation> get copyWith => _$SelectedLocationCopyWithImpl<SelectedLocation>(this as SelectedLocation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SelectedLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedLocation&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.point, _this.point) || other.point == _this.point)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId));
}


@override
int get hashCode {
  final _this = this as SelectedLocation;
  return Object.hash(runtimeType,_this.label,_this.point,_this.source,_this.placeId);
}

@override
String toString() {
  final _this = this as SelectedLocation;
  return 'SelectedLocation(label: ${_this.label}, point: ${_this.point}, source: ${_this.source}, placeId: ${_this.placeId})';
}


}

/// @nodoc
abstract mixin class $SelectedLocationCopyWith<$Res>  {
  factory $SelectedLocationCopyWith(SelectedLocation value, $Res Function(SelectedLocation) _then) = _$SelectedLocationCopyWithImpl;
@useResult
$Res call({
 String label, GeoPoint point, LocationSource source, String? placeId
});


$GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class _$SelectedLocationCopyWithImpl<$Res>
    implements $SelectedLocationCopyWith<$Res> {
  _$SelectedLocationCopyWithImpl(this._self, this._then);

  final SelectedLocation _self;
  final $Res Function(SelectedLocation) _then;

/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? point = null,Object? source = null,Object? placeId = freezed,}) {
  return _then(SelectedLocation(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as LocationSource,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get point {
  
  return $GeoPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// Adds pattern-matching-related methods to [SelectedLocation].
extension SelectedLocationPatterns on SelectedLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedLocation value)  $default,){
final _that = this;
switch (_that) {
case _SelectedLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedLocation value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  GeoPoint point,  LocationSource source,  String? placeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedLocation() when $default != null:
return $default(_that.label,_that.point,_that.source,_that.placeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  GeoPoint point,  LocationSource source,  String? placeId)  $default,) {final _that = this;
switch (_that) {
case _SelectedLocation():
return $default(_that.label,_that.point,_that.source,_that.placeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  GeoPoint point,  LocationSource source,  String? placeId)?  $default,) {final _that = this;
switch (_that) {
case _SelectedLocation() when $default != null:
return $default(_that.label,_that.point,_that.source,_that.placeId);case _:
  return null;

}
}

}

/// @nodoc


class _SelectedLocation implements SelectedLocation {
  const _SelectedLocation({required this.label, required this.point, this.source = LocationSource.search, this.placeId});
  

@override final  String label;
@override final  GeoPoint point;
@override@JsonKey() final  LocationSource source;
@override final  String? placeId;

/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedLocationCopyWith<_SelectedLocation> get copyWith => __$SelectedLocationCopyWithImpl<_SelectedLocation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedLocation&&(identical(other.label, label) || other.label == label)&&(identical(other.point, point) || other.point == point)&&(identical(other.source, source) || other.source == source)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,point,source,placeId);
}

@override
String toString() {
    return 'SelectedLocation(label: $label, point: $point, source: $source, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$SelectedLocationCopyWith<$Res> implements $SelectedLocationCopyWith<$Res> {
  factory _$SelectedLocationCopyWith(_SelectedLocation value, $Res Function(_SelectedLocation) _then) = __$SelectedLocationCopyWithImpl;
@override @useResult
$Res call({
 String label, GeoPoint point, LocationSource source, String? placeId
});


@override $GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class __$SelectedLocationCopyWithImpl<$Res>
    implements _$SelectedLocationCopyWith<$Res> {
  __$SelectedLocationCopyWithImpl(this._self, this._then);

  final _SelectedLocation _self;
  final $Res Function(_SelectedLocation) _then;

/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? point = null,Object? source = null,Object? placeId = freezed,}) {
  return _then(_SelectedLocation(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as LocationSource,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SelectedLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get point {
  
  return $GeoPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

// dart format on
