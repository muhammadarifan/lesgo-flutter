// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String get id; String get email; bool get emailVisibility; bool get verified;@JsonKey(name: 'course_place') String get coursePlaceId; String get name; String? get avatar; String get created; String? get updated; CoursePlace? get coursePlace;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVisibility, emailVisibility) || other.emailVisibility == emailVisibility)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.coursePlace, coursePlace) || other.coursePlace == coursePlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,emailVisibility,verified,coursePlaceId,name,avatar,created,updated,coursePlace);

@override
String toString() {
  return 'User(id: $id, email: $email, emailVisibility: $emailVisibility, verified: $verified, coursePlaceId: $coursePlaceId, name: $name, avatar: $avatar, created: $created, updated: $updated, coursePlace: $coursePlace)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String email, bool emailVisibility, bool verified,@JsonKey(name: 'course_place') String coursePlaceId, String name, String? avatar, String created, String? updated, CoursePlace? coursePlace
});


$CoursePlaceCopyWith<$Res>? get coursePlace;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? emailVisibility = null,Object? verified = null,Object? coursePlaceId = null,Object? name = null,Object? avatar = freezed,Object? created = null,Object? updated = freezed,Object? coursePlace = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,emailVisibility: null == emailVisibility ? _self.emailVisibility : emailVisibility // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,coursePlace: freezed == coursePlace ? _self.coursePlace : coursePlace // ignore: cast_nullable_to_non_nullable
as CoursePlace?,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoursePlaceCopyWith<$Res>? get coursePlace {
    if (_self.coursePlace == null) {
    return null;
  }

  return $CoursePlaceCopyWith<$Res>(_self.coursePlace!, (value) {
    return _then(_self.copyWith(coursePlace: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  bool emailVisibility,  bool verified, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? avatar,  String created,  String? updated,  CoursePlace? coursePlace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.email,_that.emailVisibility,_that.verified,_that.coursePlaceId,_that.name,_that.avatar,_that.created,_that.updated,_that.coursePlace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  bool emailVisibility,  bool verified, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? avatar,  String created,  String? updated,  CoursePlace? coursePlace)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.email,_that.emailVisibility,_that.verified,_that.coursePlaceId,_that.name,_that.avatar,_that.created,_that.updated,_that.coursePlace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  bool emailVisibility,  bool verified, @JsonKey(name: 'course_place')  String coursePlaceId,  String name,  String? avatar,  String created,  String? updated,  CoursePlace? coursePlace)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.email,_that.emailVisibility,_that.verified,_that.coursePlaceId,_that.name,_that.avatar,_that.created,_that.updated,_that.coursePlace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
   _User({required this.id, required this.email, required this.emailVisibility, required this.verified, @JsonKey(name: 'course_place') required this.coursePlaceId, required this.name, this.avatar, required this.created, this.updated, this.coursePlace});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String id;
@override final  String email;
@override final  bool emailVisibility;
@override final  bool verified;
@override@JsonKey(name: 'course_place') final  String coursePlaceId;
@override final  String name;
@override final  String? avatar;
@override final  String created;
@override final  String? updated;
@override final  CoursePlace? coursePlace;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVisibility, emailVisibility) || other.emailVisibility == emailVisibility)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.coursePlace, coursePlace) || other.coursePlace == coursePlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,emailVisibility,verified,coursePlaceId,name,avatar,created,updated,coursePlace);

@override
String toString() {
  return 'User(id: $id, email: $email, emailVisibility: $emailVisibility, verified: $verified, coursePlaceId: $coursePlaceId, name: $name, avatar: $avatar, created: $created, updated: $updated, coursePlace: $coursePlace)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, bool emailVisibility, bool verified,@JsonKey(name: 'course_place') String coursePlaceId, String name, String? avatar, String created, String? updated, CoursePlace? coursePlace
});


@override $CoursePlaceCopyWith<$Res>? get coursePlace;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? emailVisibility = null,Object? verified = null,Object? coursePlaceId = null,Object? name = null,Object? avatar = freezed,Object? created = null,Object? updated = freezed,Object? coursePlace = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,emailVisibility: null == emailVisibility ? _self.emailVisibility : emailVisibility // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,coursePlace: freezed == coursePlace ? _self.coursePlace : coursePlace // ignore: cast_nullable_to_non_nullable
as CoursePlace?,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoursePlaceCopyWith<$Res>? get coursePlace {
    if (_self.coursePlace == null) {
    return null;
  }

  return $CoursePlaceCopyWith<$Res>(_self.coursePlace!, (value) {
    return _then(_self.copyWith(coursePlace: value));
  });
}
}

// dart format on
