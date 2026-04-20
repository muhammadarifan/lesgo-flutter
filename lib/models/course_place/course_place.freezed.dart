// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoursePlace {

 String get id; String get name; String? get address;@JsonKey(name: 'is_active') bool get isActive; String get created; String? get updated;
/// Create a copy of CoursePlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursePlaceCopyWith<CoursePlace> get copyWith => _$CoursePlaceCopyWithImpl<CoursePlace>(this as CoursePlace, _$identity);

  /// Serializes this CoursePlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursePlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,isActive,created,updated);

@override
String toString() {
  return 'CoursePlace(id: $id, name: $name, address: $address, isActive: $isActive, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $CoursePlaceCopyWith<$Res>  {
  factory $CoursePlaceCopyWith(CoursePlace value, $Res Function(CoursePlace) _then) = _$CoursePlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? address,@JsonKey(name: 'is_active') bool isActive, String created, String? updated
});




}
/// @nodoc
class _$CoursePlaceCopyWithImpl<$Res>
    implements $CoursePlaceCopyWith<$Res> {
  _$CoursePlaceCopyWithImpl(this._self, this._then);

  final CoursePlace _self;
  final $Res Function(CoursePlace) _then;

/// Create a copy of CoursePlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? isActive = null,Object? created = null,Object? updated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoursePlace].
extension CoursePlacePatterns on CoursePlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoursePlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoursePlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoursePlace value)  $default,){
final _that = this;
switch (_that) {
case _CoursePlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoursePlace value)?  $default,){
final _that = this;
switch (_that) {
case _CoursePlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? address, @JsonKey(name: 'is_active')  bool isActive,  String created,  String? updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoursePlace() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.isActive,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? address, @JsonKey(name: 'is_active')  bool isActive,  String created,  String? updated)  $default,) {final _that = this;
switch (_that) {
case _CoursePlace():
return $default(_that.id,_that.name,_that.address,_that.isActive,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? address, @JsonKey(name: 'is_active')  bool isActive,  String created,  String? updated)?  $default,) {final _that = this;
switch (_that) {
case _CoursePlace() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.isActive,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoursePlace implements CoursePlace {
   _CoursePlace({required this.id, required this.name, this.address, @JsonKey(name: 'is_active') required this.isActive, required this.created, this.updated});
  factory _CoursePlace.fromJson(Map<String, dynamic> json) => _$CoursePlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? address;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override final  String created;
@override final  String? updated;

/// Create a copy of CoursePlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoursePlaceCopyWith<_CoursePlace> get copyWith => __$CoursePlaceCopyWithImpl<_CoursePlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoursePlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoursePlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,isActive,created,updated);

@override
String toString() {
  return 'CoursePlace(id: $id, name: $name, address: $address, isActive: $isActive, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$CoursePlaceCopyWith<$Res> implements $CoursePlaceCopyWith<$Res> {
  factory _$CoursePlaceCopyWith(_CoursePlace value, $Res Function(_CoursePlace) _then) = __$CoursePlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? address,@JsonKey(name: 'is_active') bool isActive, String created, String? updated
});




}
/// @nodoc
class __$CoursePlaceCopyWithImpl<$Res>
    implements _$CoursePlaceCopyWith<$Res> {
  __$CoursePlaceCopyWithImpl(this._self, this._then);

  final _CoursePlace _self;
  final $Res Function(_CoursePlace) _then;

/// Create a copy of CoursePlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? isActive = null,Object? created = null,Object? updated = freezed,}) {
  return _then(_CoursePlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
