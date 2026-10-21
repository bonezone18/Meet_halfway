// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetup_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetupPlan {

/// Participants, all of which have a location.
 List<Participant> get participants; GeoPoint get midpoint;
/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetupPlanCopyWith<MeetupPlan> get copyWith => _$MeetupPlanCopyWithImpl<MeetupPlan>(this as MeetupPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetupPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetupPlan&&const DeepCollectionEquality().equals(other.participants, _this.participants)&&(identical(other.midpoint, _this.midpoint) || other.midpoint == _this.midpoint));
}


@override
int get hashCode {
  final _this = this as MeetupPlan;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.participants),_this.midpoint);
}

@override
String toString() {
  final _this = this as MeetupPlan;
  return 'MeetupPlan(participants: ${_this.participants}, midpoint: ${_this.midpoint})';
}


}

/// @nodoc
abstract mixin class $MeetupPlanCopyWith<$Res>  {
  factory $MeetupPlanCopyWith(MeetupPlan value, $Res Function(MeetupPlan) _then) = _$MeetupPlanCopyWithImpl;
@useResult
$Res call({
 List<Participant> participants, GeoPoint midpoint
});


$GeoPointCopyWith<$Res> get midpoint;

}
/// @nodoc
class _$MeetupPlanCopyWithImpl<$Res>
    implements $MeetupPlanCopyWith<$Res> {
  _$MeetupPlanCopyWithImpl(this._self, this._then);

  final MeetupPlan _self;
  final $Res Function(MeetupPlan) _then;

/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participants = null,Object? midpoint = null,}) {
  return _then(MeetupPlan(
participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Participant>,midpoint: null == midpoint ? _self.midpoint : midpoint // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}
/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get midpoint {
  
  return $GeoPointCopyWith<$Res>(_self.midpoint, (value) {
    return _then(_self.copyWith(midpoint: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeetupPlan].
extension MeetupPlanPatterns on MeetupPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetupPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetupPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetupPlan value)  $default,){
final _that = this;
switch (_that) {
case _MeetupPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetupPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MeetupPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Participant> participants,  GeoPoint midpoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetupPlan() when $default != null:
return $default(_that.participants,_that.midpoint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Participant> participants,  GeoPoint midpoint)  $default,) {final _that = this;
switch (_that) {
case _MeetupPlan():
return $default(_that.participants,_that.midpoint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Participant> participants,  GeoPoint midpoint)?  $default,) {final _that = this;
switch (_that) {
case _MeetupPlan() when $default != null:
return $default(_that.participants,_that.midpoint);case _:
  return null;

}
}

}

/// @nodoc


class _MeetupPlan extends MeetupPlan {
  const _MeetupPlan({required  List<Participant> participants, required this.midpoint}): _participants = participants,super._();
  

/// Participants, all of which have a location.
 final  List<Participant> _participants;
/// Participants, all of which have a location.
@override List<Participant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  GeoPoint midpoint;

/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetupPlanCopyWith<_MeetupPlan> get copyWith => __$MeetupPlanCopyWithImpl<_MeetupPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetupPlan&&const DeepCollectionEquality().equals(other.participants, _participants)&&(identical(other.midpoint, midpoint) || other.midpoint == midpoint));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_participants),midpoint);
}

@override
String toString() {
    return 'MeetupPlan(participants: $participants, midpoint: $midpoint)';
}


}

/// @nodoc
abstract mixin class _$MeetupPlanCopyWith<$Res> implements $MeetupPlanCopyWith<$Res> {
  factory _$MeetupPlanCopyWith(_MeetupPlan value, $Res Function(_MeetupPlan) _then) = __$MeetupPlanCopyWithImpl;
@override @useResult
$Res call({
 List<Participant> participants, GeoPoint midpoint
});


@override $GeoPointCopyWith<$Res> get midpoint;

}
/// @nodoc
class __$MeetupPlanCopyWithImpl<$Res>
    implements _$MeetupPlanCopyWith<$Res> {
  __$MeetupPlanCopyWithImpl(this._self, this._then);

  final _MeetupPlan _self;
  final $Res Function(_MeetupPlan) _then;

/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participants = null,Object? midpoint = null,}) {
  return _then(_MeetupPlan(
participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Participant>,midpoint: null == midpoint ? _self.midpoint : midpoint // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}

/// Create a copy of MeetupPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get midpoint {
  
  return $GeoPointCopyWith<$Res>(_self.midpoint, (value) {
    return _then(_self.copyWith(midpoint: value));
  });
}
}

// dart format on
