// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Schedule {

 String get id;@JsonKey(name: 'course_place') String get coursePlaceId;@JsonKey(name: 'room') String get roomId;@JsonKey(name: 'course') String get courseId;@JsonKey(name: 'tutor') String get tutorId;@JsonKey(name: 'students') List<String> get studentIds; DateTime get date;@JsonKey(name: 'start_time') DateTime get startTime;@JsonKey(name: 'end_time') DateTime get endTime;@JsonKey(name: 'is_active') bool get isActive; DateTime get created; DateTime? get updated;@JsonKey(includeFromJson: false) Course? get course;@JsonKey(includeFromJson: false) Tutor? get tutor;@JsonKey(includeFromJson: false) List<Student> get students;
/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCopyWith<Schedule> get copyWith => _$ScheduleCopyWithImpl<Schedule>(this as Schedule, _$identity);

  /// Serializes this Schedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Schedule&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.tutorId, tutorId) || other.tutorId == tutorId)&&const DeepCollectionEquality().equals(other.studentIds, studentIds)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.course, course) || other.course == course)&&(identical(other.tutor, tutor) || other.tutor == tutor)&&const DeepCollectionEquality().equals(other.students, students));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,roomId,courseId,tutorId,const DeepCollectionEquality().hash(studentIds),date,startTime,endTime,isActive,created,updated,course,tutor,const DeepCollectionEquality().hash(students));

@override
String toString() {
  return 'Schedule(id: $id, coursePlaceId: $coursePlaceId, roomId: $roomId, courseId: $courseId, tutorId: $tutorId, studentIds: $studentIds, date: $date, startTime: $startTime, endTime: $endTime, isActive: $isActive, created: $created, updated: $updated, course: $course, tutor: $tutor, students: $students)';
}


}

/// @nodoc
abstract mixin class $ScheduleCopyWith<$Res>  {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) _then) = _$ScheduleCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'room') String roomId,@JsonKey(name: 'course') String courseId,@JsonKey(name: 'tutor') String tutorId,@JsonKey(name: 'students') List<String> studentIds, DateTime date,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime endTime,@JsonKey(name: 'is_active') bool isActive, DateTime created, DateTime? updated,@JsonKey(includeFromJson: false) Course? course,@JsonKey(includeFromJson: false) Tutor? tutor,@JsonKey(includeFromJson: false) List<Student> students
});


$CourseCopyWith<$Res>? get course;$TutorCopyWith<$Res>? get tutor;

}
/// @nodoc
class _$ScheduleCopyWithImpl<$Res>
    implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._self, this._then);

  final Schedule _self;
  final $Res Function(Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? coursePlaceId = null,Object? roomId = null,Object? courseId = null,Object? tutorId = null,Object? studentIds = null,Object? date = null,Object? startTime = null,Object? endTime = null,Object? isActive = null,Object? created = null,Object? updated = freezed,Object? course = freezed,Object? tutor = freezed,Object? students = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,tutorId: null == tutorId ? _self.tutorId : tutorId // ignore: cast_nullable_to_non_nullable
as String,studentIds: null == studentIds ? _self.studentIds : studentIds // ignore: cast_nullable_to_non_nullable
as List<String>,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course?,tutor: freezed == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as Tutor?,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,
  ));
}
/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $CourseCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorCopyWith<$Res>? get tutor {
    if (_self.tutor == null) {
    return null;
  }

  return $TutorCopyWith<$Res>(_self.tutor!, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}


/// Adds pattern-matching-related methods to [Schedule].
extension SchedulePatterns on Schedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Schedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Schedule value)  $default,){
final _that = this;
switch (_that) {
case _Schedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Schedule value)?  $default,){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'room')  String roomId, @JsonKey(name: 'course')  String courseId, @JsonKey(name: 'tutor')  String tutorId, @JsonKey(name: 'students')  List<String> studentIds,  DateTime date, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Course? course, @JsonKey(includeFromJson: false)  Tutor? tutor, @JsonKey(includeFromJson: false)  List<Student> students)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.roomId,_that.courseId,_that.tutorId,_that.studentIds,_that.date,_that.startTime,_that.endTime,_that.isActive,_that.created,_that.updated,_that.course,_that.tutor,_that.students);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'room')  String roomId, @JsonKey(name: 'course')  String courseId, @JsonKey(name: 'tutor')  String tutorId, @JsonKey(name: 'students')  List<String> studentIds,  DateTime date, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Course? course, @JsonKey(includeFromJson: false)  Tutor? tutor, @JsonKey(includeFromJson: false)  List<Student> students)  $default,) {final _that = this;
switch (_that) {
case _Schedule():
return $default(_that.id,_that.coursePlaceId,_that.roomId,_that.courseId,_that.tutorId,_that.studentIds,_that.date,_that.startTime,_that.endTime,_that.isActive,_that.created,_that.updated,_that.course,_that.tutor,_that.students);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'room')  String roomId, @JsonKey(name: 'course')  String courseId, @JsonKey(name: 'tutor')  String tutorId, @JsonKey(name: 'students')  List<String> studentIds,  DateTime date, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime, @JsonKey(name: 'is_active')  bool isActive,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Course? course, @JsonKey(includeFromJson: false)  Tutor? tutor, @JsonKey(includeFromJson: false)  List<Student> students)?  $default,) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.roomId,_that.courseId,_that.tutorId,_that.studentIds,_that.date,_that.startTime,_that.endTime,_that.isActive,_that.created,_that.updated,_that.course,_that.tutor,_that.students);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Schedule implements Schedule {
   _Schedule({required this.id, @JsonKey(name: 'course_place') required this.coursePlaceId, @JsonKey(name: 'room') required this.roomId, @JsonKey(name: 'course') required this.courseId, @JsonKey(name: 'tutor') required this.tutorId, @JsonKey(name: 'students') required final  List<String> studentIds, required this.date, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime, @JsonKey(name: 'is_active') required this.isActive, required this.created, this.updated, @JsonKey(includeFromJson: false) this.course, @JsonKey(includeFromJson: false) this.tutor, @JsonKey(includeFromJson: false) final  List<Student> students = const []}): _studentIds = studentIds,_students = students;
  factory _Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

@override final  String id;
@override@JsonKey(name: 'course_place') final  String coursePlaceId;
@override@JsonKey(name: 'room') final  String roomId;
@override@JsonKey(name: 'course') final  String courseId;
@override@JsonKey(name: 'tutor') final  String tutorId;
 final  List<String> _studentIds;
@override@JsonKey(name: 'students') List<String> get studentIds {
  if (_studentIds is EqualUnmodifiableListView) return _studentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studentIds);
}

@override final  DateTime date;
@override@JsonKey(name: 'start_time') final  DateTime startTime;
@override@JsonKey(name: 'end_time') final  DateTime endTime;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override final  DateTime created;
@override final  DateTime? updated;
@override@JsonKey(includeFromJson: false) final  Course? course;
@override@JsonKey(includeFromJson: false) final  Tutor? tutor;
 final  List<Student> _students;
@override@JsonKey(includeFromJson: false) List<Student> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}


/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCopyWith<_Schedule> get copyWith => __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Schedule&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.tutorId, tutorId) || other.tutorId == tutorId)&&const DeepCollectionEquality().equals(other._studentIds, _studentIds)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.course, course) || other.course == course)&&(identical(other.tutor, tutor) || other.tutor == tutor)&&const DeepCollectionEquality().equals(other._students, _students));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,roomId,courseId,tutorId,const DeepCollectionEquality().hash(_studentIds),date,startTime,endTime,isActive,created,updated,course,tutor,const DeepCollectionEquality().hash(_students));

@override
String toString() {
  return 'Schedule(id: $id, coursePlaceId: $coursePlaceId, roomId: $roomId, courseId: $courseId, tutorId: $tutorId, studentIds: $studentIds, date: $date, startTime: $startTime, endTime: $endTime, isActive: $isActive, created: $created, updated: $updated, course: $course, tutor: $tutor, students: $students)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) _then) = __$ScheduleCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'room') String roomId,@JsonKey(name: 'course') String courseId,@JsonKey(name: 'tutor') String tutorId,@JsonKey(name: 'students') List<String> studentIds, DateTime date,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime endTime,@JsonKey(name: 'is_active') bool isActive, DateTime created, DateTime? updated,@JsonKey(includeFromJson: false) Course? course,@JsonKey(includeFromJson: false) Tutor? tutor,@JsonKey(includeFromJson: false) List<Student> students
});


@override $CourseCopyWith<$Res>? get course;@override $TutorCopyWith<$Res>? get tutor;

}
/// @nodoc
class __$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(this._self, this._then);

  final _Schedule _self;
  final $Res Function(_Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? coursePlaceId = null,Object? roomId = null,Object? courseId = null,Object? tutorId = null,Object? studentIds = null,Object? date = null,Object? startTime = null,Object? endTime = null,Object? isActive = null,Object? created = null,Object? updated = freezed,Object? course = freezed,Object? tutor = freezed,Object? students = null,}) {
  return _then(_Schedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,tutorId: null == tutorId ? _self.tutorId : tutorId // ignore: cast_nullable_to_non_nullable
as String,studentIds: null == studentIds ? _self._studentIds : studentIds // ignore: cast_nullable_to_non_nullable
as List<String>,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course?,tutor: freezed == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as Tutor?,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,
  ));
}

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $CourseCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorCopyWith<$Res>? get tutor {
    if (_self.tutor == null) {
    return null;
  }

  return $TutorCopyWith<$Res>(_self.tutor!, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}

// dart format on
