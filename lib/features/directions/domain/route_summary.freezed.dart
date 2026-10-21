// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouteSummary {

 Duration get duration; int get distanceMeters;
/// Create a copy of RouteSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteSummaryCopyWith<RouteSummary> get copyWith => _$RouteSummaryCopyWithImpl<RouteSummary>(this as RouteSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RouteSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteSummary&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters));
}


@override
int get hashCode {
  final _this = this as RouteSummary;
  return Object.hash(runtimeType,_this.duration,_this.distanceMeters);
}

@override
String toString() {
  final _this = this as RouteSummary;
  return 'RouteSummary(duration: ${_this.duration}, distanceMeters: ${_this.distanceMeters})';
}


}

/// @nodoc
abstract mixin class $RouteSummaryCopyWith<$Res>  {
  factory $RouteSummaryCopyWith(RouteSummary value, $Res Function(RouteSummary) _then) = _$RouteSummaryCopyWithImpl;
@useResult
$Res call({
 Duration duration, int distanceMeters
});




}
/// @nodoc
class _$RouteSummaryCopyWithImpl<$Res>
    implements $RouteSummaryCopyWith<$Res> {
  _$RouteSummaryCopyWithImpl(this._self, this._then);

  final RouteSummary _self;
  final $Res Function(RouteSummary) _then;

/// Create a copy of RouteSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? duration = null,Object? distanceMeters = null,}) {
  return _then(RouteSummary(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteSummary].
extension RouteSummaryPatterns on RouteSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteSummary value)  $default,){
final _that = this;
switch (_that) {
case _RouteSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RouteSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration duration,  int distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteSummary() when $default != null:
return $default(_that.duration,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration duration,  int distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _RouteSummary():
return $default(_that.duration,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration duration,  int distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _RouteSummary() when $default != null:
return $default(_that.duration,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _RouteSummary implements RouteSummary {
  const _RouteSummary({required this.duration, required this.distanceMeters});
  

@override final  Duration duration;
@override final  int distanceMeters;

/// Create a copy of RouteSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteSummaryCopyWith<_RouteSummary> get copyWith => __$RouteSummaryCopyWithImpl<_RouteSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteSummary&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}


@override
int get hashCode {
    return Object.hash(runtimeType,duration,distanceMeters);
}

@override
String toString() {
    return 'RouteSummary(duration: $duration, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$RouteSummaryCopyWith<$Res> implements $RouteSummaryCopyWith<$Res> {
  factory _$RouteSummaryCopyWith(_RouteSummary value, $Res Function(_RouteSummary) _then) = __$RouteSummaryCopyWithImpl;
@override @useResult
$Res call({
 Duration duration, int distanceMeters
});




}
/// @nodoc
class __$RouteSummaryCopyWithImpl<$Res>
    implements _$RouteSummaryCopyWith<$Res> {
  __$RouteSummaryCopyWithImpl(this._self, this._then);

  final _RouteSummary _self;
  final $Res Function(_RouteSummary) _then;

/// Create a copy of RouteSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? duration = null,Object? distanceMeters = null,}) {
  return _then(_RouteSummary(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
