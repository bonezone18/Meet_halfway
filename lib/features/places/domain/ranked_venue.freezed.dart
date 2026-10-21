// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranked_venue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankedVenue {

 Venue get venue;/// Straight-line distance from each participant, in plan order.
 List<double> get distancesMeters; double get distanceFromMidpointMeters; Fairness get fairness;
/// Create a copy of RankedVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankedVenueCopyWith<RankedVenue> get copyWith => _$RankedVenueCopyWithImpl<RankedVenue>(this as RankedVenue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RankedVenue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankedVenue&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&const DeepCollectionEquality().equals(other.distancesMeters, _this.distancesMeters)&&(identical(other.distanceFromMidpointMeters, _this.distanceFromMidpointMeters) || other.distanceFromMidpointMeters == _this.distanceFromMidpointMeters)&&(identical(other.fairness, _this.fairness) || other.fairness == _this.fairness));
}


@override
int get hashCode {
  final _this = this as RankedVenue;
  return Object.hash(runtimeType,_this.venue,const DeepCollectionEquality().hash(_this.distancesMeters),_this.distanceFromMidpointMeters,_this.fairness);
}

@override
String toString() {
  final _this = this as RankedVenue;
  return 'RankedVenue(venue: ${_this.venue}, distancesMeters: ${_this.distancesMeters}, distanceFromMidpointMeters: ${_this.distanceFromMidpointMeters}, fairness: ${_this.fairness})';
}


}

/// @nodoc
abstract mixin class $RankedVenueCopyWith<$Res>  {
  factory $RankedVenueCopyWith(RankedVenue value, $Res Function(RankedVenue) _then) = _$RankedVenueCopyWithImpl;
@useResult
$Res call({
 Venue venue, List<double> distancesMeters, double distanceFromMidpointMeters, Fairness fairness
});


$VenueCopyWith<$Res> get venue;

}
/// @nodoc
class _$RankedVenueCopyWithImpl<$Res>
    implements $RankedVenueCopyWith<$Res> {
  _$RankedVenueCopyWithImpl(this._self, this._then);

  final RankedVenue _self;
  final $Res Function(RankedVenue) _then;

/// Create a copy of RankedVenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? venue = null,Object? distancesMeters = null,Object? distanceFromMidpointMeters = null,Object? fairness = null,}) {
  return _then(RankedVenue(
venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as Venue,distancesMeters: null == distancesMeters ? _self.distancesMeters : distancesMeters // ignore: cast_nullable_to_non_nullable
as List<double>,distanceFromMidpointMeters: null == distanceFromMidpointMeters ? _self.distanceFromMidpointMeters : distanceFromMidpointMeters // ignore: cast_nullable_to_non_nullable
as double,fairness: null == fairness ? _self.fairness : fairness // ignore: cast_nullable_to_non_nullable
as Fairness,
  ));
}
/// Create a copy of RankedVenue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VenueCopyWith<$Res> get venue {
  
  return $VenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}
}


/// Adds pattern-matching-related methods to [RankedVenue].
extension RankedVenuePatterns on RankedVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankedVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankedVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankedVenue value)  $default,){
final _that = this;
switch (_that) {
case _RankedVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankedVenue value)?  $default,){
final _that = this;
switch (_that) {
case _RankedVenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Venue venue,  List<double> distancesMeters,  double distanceFromMidpointMeters,  Fairness fairness)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankedVenue() when $default != null:
return $default(_that.venue,_that.distancesMeters,_that.distanceFromMidpointMeters,_that.fairness);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Venue venue,  List<double> distancesMeters,  double distanceFromMidpointMeters,  Fairness fairness)  $default,) {final _that = this;
switch (_that) {
case _RankedVenue():
return $default(_that.venue,_that.distancesMeters,_that.distanceFromMidpointMeters,_that.fairness);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Venue venue,  List<double> distancesMeters,  double distanceFromMidpointMeters,  Fairness fairness)?  $default,) {final _that = this;
switch (_that) {
case _RankedVenue() when $default != null:
return $default(_that.venue,_that.distancesMeters,_that.distanceFromMidpointMeters,_that.fairness);case _:
  return null;

}
}

}

/// @nodoc


class _RankedVenue extends RankedVenue {
  const _RankedVenue({required this.venue, required  List<double> distancesMeters, required this.distanceFromMidpointMeters, required this.fairness}): _distancesMeters = distancesMeters,super._();
  

@override final  Venue venue;
/// Straight-line distance from each participant, in plan order.
 final  List<double> _distancesMeters;
/// Straight-line distance from each participant, in plan order.
@override List<double> get distancesMeters {
  if (_distancesMeters is EqualUnmodifiableListView) return _distancesMeters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_distancesMeters);
}

@override final  double distanceFromMidpointMeters;
@override final  Fairness fairness;

/// Create a copy of RankedVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankedVenueCopyWith<_RankedVenue> get copyWith => __$RankedVenueCopyWithImpl<_RankedVenue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankedVenue&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other.distancesMeters, _distancesMeters)&&(identical(other.distanceFromMidpointMeters, distanceFromMidpointMeters) || other.distanceFromMidpointMeters == distanceFromMidpointMeters)&&(identical(other.fairness, fairness) || other.fairness == fairness));
}


@override
int get hashCode {
    return Object.hash(runtimeType,venue,const DeepCollectionEquality().hash(_distancesMeters),distanceFromMidpointMeters,fairness);
}

@override
String toString() {
    return 'RankedVenue(venue: $venue, distancesMeters: $distancesMeters, distanceFromMidpointMeters: $distanceFromMidpointMeters, fairness: $fairness)';
}


}

/// @nodoc
abstract mixin class _$RankedVenueCopyWith<$Res> implements $RankedVenueCopyWith<$Res> {
  factory _$RankedVenueCopyWith(_RankedVenue value, $Res Function(_RankedVenue) _then) = __$RankedVenueCopyWithImpl;
@override @useResult
$Res call({
 Venue venue, List<double> distancesMeters, double distanceFromMidpointMeters, Fairness fairness
});


@override $VenueCopyWith<$Res> get venue;

}
/// @nodoc
class __$RankedVenueCopyWithImpl<$Res>
    implements _$RankedVenueCopyWith<$Res> {
  __$RankedVenueCopyWithImpl(this._self, this._then);

  final _RankedVenue _self;
  final $Res Function(_RankedVenue) _then;

/// Create a copy of RankedVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? venue = null,Object? distancesMeters = null,Object? distanceFromMidpointMeters = null,Object? fairness = null,}) {
  return _then(_RankedVenue(
venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as Venue,distancesMeters: null == distancesMeters ? _self._distancesMeters : distancesMeters // ignore: cast_nullable_to_non_nullable
as List<double>,distanceFromMidpointMeters: null == distanceFromMidpointMeters ? _self.distanceFromMidpointMeters : distanceFromMidpointMeters // ignore: cast_nullable_to_non_nullable
as double,fairness: null == fairness ? _self.fairness : fairness // ignore: cast_nullable_to_non_nullable
as Fairness,
  ));
}

/// Create a copy of RankedVenue
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
