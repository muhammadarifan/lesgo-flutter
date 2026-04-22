// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tutor {

 String get id;@JsonKey(name: 'course_place') String get coursePlaceId; String get name; String? get email; String? get phone; String? get address; GenderEnum get gender;@JsonKey(name: 'is_active') bool get isActive; DateTime get created; DateTime? get updated;
/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorCopyWith<Tutor> get copyWith => _$TutorCopyWithImpl<Tutor>(this as Tutor, _$identity);

  /// Serializes this Tutor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tutor&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,name,email,phone,address,gender,isActive,created,updated);

@override
String toString() {
  return 'Tutor(id: $id, coursePlaceId: $coursePlaceId, name: $name, email: $email, phone: $phone, address: $address, gender: $gender, isActive: $isActive, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $TutorCopyWith<$Res>  {
  factory $TutorCopyWith(Tutor value, $Res Function(Tutor) _then) = _$TutorCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId, String name, String? email, String? phone, String? address, GenderEnum gender,@JsonKey(name: 'is_active') bool isActive, DateTime created, DateTime? updated
});




}
/// @nodoc
class _$TutorCopyWithImpl<$Res>
    implements $TutorCopyWith<$Res> {
  _$TutorCopyWithImpl(this._self, this._then);

  final Tutor _self;
  final $Res Function(Tutor) _then;

/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? coursePlaceId = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? address = freezed,Object? gender = null,Object? isActive = null,Object? created = null,Object? updated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderEnum,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Tutor].
extension TutorPatterns on Tutor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tutor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tutor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tutor value)  $default,){
final _that = this;
switch (_that) {
case _Tutor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tutor value)?  $default,){
final _that = this;
switch (_that) {
case _Tutor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? email,  String? phone,  String? address,  GenderEnum gender, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tutor() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.name,_that.email,_that.phone,_that.address,_that.gender,_that.isActive,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? email,  String? phone,  String? address,  GenderEnum gender, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated)  $default,) {final _that = this;
switch (_that) {
case _Tutor():
return $default(_that.id,_that.coursePlaceId,_that.name,_that.email,_that.phone,_that.address,_that.gender,_that.isActive,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? email,  String? phone,  String? address,  GenderEnum gender, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated)?  $default,) {final _that = this;
switch (_that) {
case _Tutor() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.name,_that.email,_that.phone,_that.address,_that.gender,_that.isActive,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tutor extends Tutor {
   _Tutor({required this.id, @JsonKey(name: 'course_place') required this.coursePlaceId, required this.name, this.email, this.phone, this.address, required this.gender, @JsonKey(name: 'is_active') required this.isActive, required this.created, this.updated}): super._();
  factory _Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

@override final  String id;
@override@JsonKey(name: 'course_place') final  String coursePlaceId;
@override final  String name;
@override final  String? email;
@override final  String? phone;
@override final  String? address;
@override final  GenderEnum gender;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override final  DateTime created;
@override final  DateTime? updated;

/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorCopyWith<_Tutor> get copyWith => __$TutorCopyWithImpl<_Tutor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TutorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tutor&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,name,email,phone,address,gender,isActive,created,updated);

@override
String toString() {
  return 'Tutor(id: $id, coursePlaceId: $coursePlaceId, name: $name, email: $email, phone: $phone, address: $address, gender: $gender, isActive: $isActive, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$TutorCopyWith<$Res> implements $TutorCopyWith<$Res> {
  factory _$TutorCopyWith(_Tutor value, $Res Function(_Tutor) _then) = __$TutorCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId, String name, String? email, String? phone, String? address, GenderEnum gender,@JsonKey(name: 'is_active') bool isActive, DateTime created, DateTime? updated
});




}
/// @nodoc
class __$TutorCopyWithImpl<$Res>
    implements _$TutorCopyWith<$Res> {
  __$TutorCopyWithImpl(this._self, this._then);

  final _Tutor _self;
  final $Res Function(_Tutor) _then;

/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? coursePlaceId = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? address = freezed,Object? gender = null,Object? isActive = null,Object? created = null,Object? updated = freezed,}) {
  return _then(_Tutor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderEnum,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
