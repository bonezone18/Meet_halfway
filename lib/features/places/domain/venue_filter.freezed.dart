// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueFilter {

 Set<VenueCategory> get categories; SortOption get sort; bool get openNowOnly; double get minRating;
/// Create a copy of VenueFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueFilterCopyWith<VenueFilter> get copyWith => _$VenueFilterCopyWithImpl<VenueFilter>(this as VenueFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VenueFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueFilter&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.sort, _this.sort) || other.sort == _this.sort)&&(identical(other.openNowOnly, _this.openNowOnly) || other.openNowOnly == _this.openNowOnly)&&(identical(other.minRating, _this.minRating) || other.minRating == _this.minRating));
}


@override
int get hashCode {
  final _this = this as VenueFilter;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.categories),_this.sort,_this.openNowOnly,_this.minRating);
}

@override
String toString() {
  final _this = this as VenueFilter;
  return 'VenueFilter(categories: ${_this.categories}, sort: ${_this.sort}, openNowOnly: ${_this.openNowOnly}, minRating: ${_this.minRating})';
}


}

/// @nodoc
abstract mixin class $VenueFilterCopyWith<$Res>  {
  factory $VenueFilterCopyWith(VenueFilter value, $Res Function(VenueFilter) _then) = _$VenueFilterCopyWithImpl;
@useResult
$Res call({
 Set<VenueCategory> categories, SortOption sort, bool openNowOnly, double minRating
});




}
/// @nodoc
class _$VenueFilterCopyWithImpl<$Res>
    implements $VenueFilterCopyWith<$Res> {
  _$VenueFilterCopyWithImpl(this._self, this._then);

  final VenueFilter _self;
  final $Res Function(VenueFilter) _then;

/// Create a copy of VenueFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? sort = null,Object? openNowOnly = null,Object? minRating = null,}) {
  return _then(VenueFilter(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Set<VenueCategory>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortOption,openNowOnly: null == openNowOnly ? _self.openNowOnly : openNowOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueFilter].
extension VenueFilterPatterns on VenueFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueFilter value)  $default,){
final _that = this;
switch (_that) {
case _VenueFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueFilter value)?  $default,){
final _that = this;
switch (_that) {
case _VenueFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<VenueCategory> categories,  SortOption sort,  bool openNowOnly,  double minRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueFilter() when $default != null:
return $default(_that.categories,_that.sort,_that.openNowOnly,_that.minRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<VenueCategory> categories,  SortOption sort,  bool openNowOnly,  double minRating)  $default,) {final _that = this;
switch (_that) {
case _VenueFilter():
return $default(_that.categories,_that.sort,_that.openNowOnly,_that.minRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<VenueCategory> categories,  SortOption sort,  bool openNowOnly,  double minRating)?  $default,) {final _that = this;
switch (_that) {
case _VenueFilter() when $default != null:
return $default(_that.categories,_that.sort,_that.openNowOnly,_that.minRating);case _:
  return null;

}
}

}

/// @nodoc


class _VenueFilter implements VenueFilter {
  const _VenueFilter({ Set<VenueCategory> categories = VenueCategory.defaults, this.sort = SortOption.fairness, this.openNowOnly = false, this.minRating = 0}): _categories = categories;
  

 final  Set<VenueCategory> _categories;
@override@JsonKey() Set<VenueCategory> get categories {
  if (_categories is EqualUnmodifiableSetView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categories);
}

@override@JsonKey() final  SortOption sort;
@override@JsonKey() final  bool openNowOnly;
@override@JsonKey() final  double minRating;

/// Create a copy of VenueFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueFilterCopyWith<_VenueFilter> get copyWith => __$VenueFilterCopyWithImpl<_VenueFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueFilter&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.openNowOnly, openNowOnly) || other.openNowOnly == openNowOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),sort,openNowOnly,minRating);
}

@override
String toString() {
    return 'VenueFilter(categories: $categories, sort: $sort, openNowOnly: $openNowOnly, minRating: $minRating)';
}


}

/// @nodoc
abstract mixin class _$VenueFilterCopyWith<$Res> implements $VenueFilterCopyWith<$Res> {
  factory _$VenueFilterCopyWith(_VenueFilter value, $Res Function(_VenueFilter) _then) = __$VenueFilterCopyWithImpl;
@override @useResult
$Res call({
 Set<VenueCategory> categories, SortOption sort, bool openNowOnly, double minRating
});




}
/// @nodoc
class __$VenueFilterCopyWithImpl<$Res>
    implements _$VenueFilterCopyWith<$Res> {
  __$VenueFilterCopyWithImpl(this._self, this._then);

  final _VenueFilter _self;
  final $Res Function(_VenueFilter) _then;

/// Create a copy of VenueFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? sort = null,Object? openNowOnly = null,Object? minRating = null,}) {
  return _then(_VenueFilter(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Set<VenueCategory>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortOption,openNowOnly: null == openNowOnly ? _self.openNowOnly : openNowOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
