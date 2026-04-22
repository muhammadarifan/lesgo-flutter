// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Invoice {

 String get id;@JsonKey(name: 'course_place') String get coursePlaceId;@JsonKey(name: 'student') String get studentId;@JsonKey(name: 'courses') List<String> get courseIds; DateTime get period; InvoiceStatusEnum get status;@JsonKey(name: 'due_date') DateTime get dueDate; DateTime get created; DateTime? get updated;@JsonKey(includeFromJson: false) Student? get student;@JsonKey(includeFromJson: false) List<Course> get courses;@JsonKey(includeToJson: false) int? get totalPrice;@JsonKey(includeToJson: false) CurrencyEnum? get currency;
/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceCopyWith<Invoice> get copyWith => _$InvoiceCopyWithImpl<Invoice>(this as Invoice, _$identity);

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invoice&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&const DeepCollectionEquality().equals(other.courseIds, courseIds)&&(identical(other.period, period) || other.period == period)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.student, student) || other.student == student)&&const DeepCollectionEquality().equals(other.courses, courses)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,studentId,const DeepCollectionEquality().hash(courseIds),period,status,dueDate,created,updated,student,const DeepCollectionEquality().hash(courses),totalPrice,currency);

@override
String toString() {
  return 'Invoice(id: $id, coursePlaceId: $coursePlaceId, studentId: $studentId, courseIds: $courseIds, period: $period, status: $status, dueDate: $dueDate, created: $created, updated: $updated, student: $student, courses: $courses, totalPrice: $totalPrice, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $InvoiceCopyWith<$Res>  {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) _then) = _$InvoiceCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'student') String studentId,@JsonKey(name: 'courses') List<String> courseIds, DateTime period, InvoiceStatusEnum status,@JsonKey(name: 'due_date') DateTime dueDate, DateTime created, DateTime? updated,@JsonKey(includeFromJson: false) Student? student,@JsonKey(includeFromJson: false) List<Course> courses,@JsonKey(includeToJson: false) int? totalPrice,@JsonKey(includeToJson: false) CurrencyEnum? currency
});


$StudentCopyWith<$Res>? get student;

}
/// @nodoc
class _$InvoiceCopyWithImpl<$Res>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._self, this._then);

  final Invoice _self;
  final $Res Function(Invoice) _then;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? coursePlaceId = null,Object? studentId = null,Object? courseIds = null,Object? period = null,Object? status = null,Object? dueDate = null,Object? created = null,Object? updated = freezed,Object? student = freezed,Object? courses = null,Object? totalPrice = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,courseIds: null == courseIds ? _self.courseIds : courseIds // ignore: cast_nullable_to_non_nullable
as List<String>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvoiceStatusEnum,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,student: freezed == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as Student?,courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<Course>,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as CurrencyEnum?,
  ));
}
/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentCopyWith<$Res>? get student {
    if (_self.student == null) {
    return null;
  }

  return $StudentCopyWith<$Res>(_self.student!, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}


/// Adds pattern-matching-related methods to [Invoice].
extension InvoicePatterns on Invoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invoice value)  $default,){
final _that = this;
switch (_that) {
case _Invoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invoice value)?  $default,){
final _that = this;
switch (_that) {
case _Invoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'student')  String studentId, @JsonKey(name: 'courses')  List<String> courseIds,  DateTime period,  InvoiceStatusEnum status, @JsonKey(name: 'due_date')  DateTime dueDate,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Student? student, @JsonKey(includeFromJson: false)  List<Course> courses, @JsonKey(includeToJson: false)  int? totalPrice, @JsonKey(includeToJson: false)  CurrencyEnum? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.studentId,_that.courseIds,_that.period,_that.status,_that.dueDate,_that.created,_that.updated,_that.student,_that.courses,_that.totalPrice,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'student')  String studentId, @JsonKey(name: 'courses')  List<String> courseIds,  DateTime period,  InvoiceStatusEnum status, @JsonKey(name: 'due_date')  DateTime dueDate,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Student? student, @JsonKey(includeFromJson: false)  List<Course> courses, @JsonKey(includeToJson: false)  int? totalPrice, @JsonKey(includeToJson: false)  CurrencyEnum? currency)  $default,) {final _that = this;
switch (_that) {
case _Invoice():
return $default(_that.id,_that.coursePlaceId,_that.studentId,_that.courseIds,_that.period,_that.status,_that.dueDate,_that.created,_that.updated,_that.student,_that.courses,_that.totalPrice,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'student')  String studentId, @JsonKey(name: 'courses')  List<String> courseIds,  DateTime period,  InvoiceStatusEnum status, @JsonKey(name: 'due_date')  DateTime dueDate,  DateTime created,  DateTime? updated, @JsonKey(includeFromJson: false)  Student? student, @JsonKey(includeFromJson: false)  List<Course> courses, @JsonKey(includeToJson: false)  int? totalPrice, @JsonKey(includeToJson: false)  CurrencyEnum? currency)?  $default,) {final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.studentId,_that.courseIds,_that.period,_that.status,_that.dueDate,_that.created,_that.updated,_that.student,_that.courses,_that.totalPrice,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invoice implements Invoice {
   _Invoice({required this.id, @JsonKey(name: 'course_place') required this.coursePlaceId, @JsonKey(name: 'student') required this.studentId, @JsonKey(name: 'courses') final  List<String> courseIds = const [], required this.period, required this.status, @JsonKey(name: 'due_date') required this.dueDate, required this.created, this.updated, @JsonKey(includeFromJson: false) this.student, @JsonKey(includeFromJson: false) final  List<Course> courses = const [], @JsonKey(includeToJson: false) this.totalPrice, @JsonKey(includeToJson: false) this.currency}): _courseIds = courseIds,_courses = courses;
  factory _Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

@override final  String id;
@override@JsonKey(name: 'course_place') final  String coursePlaceId;
@override@JsonKey(name: 'student') final  String studentId;
 final  List<String> _courseIds;
@override@JsonKey(name: 'courses') List<String> get courseIds {
  if (_courseIds is EqualUnmodifiableListView) return _courseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseIds);
}

@override final  DateTime period;
@override final  InvoiceStatusEnum status;
@override@JsonKey(name: 'due_date') final  DateTime dueDate;
@override final  DateTime created;
@override final  DateTime? updated;
@override@JsonKey(includeFromJson: false) final  Student? student;
 final  List<Course> _courses;
@override@JsonKey(includeFromJson: false) List<Course> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

@override@JsonKey(includeToJson: false) final  int? totalPrice;
@override@JsonKey(includeToJson: false) final  CurrencyEnum? currency;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceCopyWith<_Invoice> get copyWith => __$InvoiceCopyWithImpl<_Invoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invoice&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&const DeepCollectionEquality().equals(other._courseIds, _courseIds)&&(identical(other.period, period) || other.period == period)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.student, student) || other.student == student)&&const DeepCollectionEquality().equals(other._courses, _courses)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,studentId,const DeepCollectionEquality().hash(_courseIds),period,status,dueDate,created,updated,student,const DeepCollectionEquality().hash(_courses),totalPrice,currency);

@override
String toString() {
  return 'Invoice(id: $id, coursePlaceId: $coursePlaceId, studentId: $studentId, courseIds: $courseIds, period: $period, status: $status, dueDate: $dueDate, created: $created, updated: $updated, student: $student, courses: $courses, totalPrice: $totalPrice, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$InvoiceCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$InvoiceCopyWith(_Invoice value, $Res Function(_Invoice) _then) = __$InvoiceCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'student') String studentId,@JsonKey(name: 'courses') List<String> courseIds, DateTime period, InvoiceStatusEnum status,@JsonKey(name: 'due_date') DateTime dueDate, DateTime created, DateTime? updated,@JsonKey(includeFromJson: false) Student? student,@JsonKey(includeFromJson: false) List<Course> courses,@JsonKey(includeToJson: false) int? totalPrice,@JsonKey(includeToJson: false) CurrencyEnum? currency
});


@override $StudentCopyWith<$Res>? get student;

}
/// @nodoc
class __$InvoiceCopyWithImpl<$Res>
    implements _$InvoiceCopyWith<$Res> {
  __$InvoiceCopyWithImpl(this._self, this._then);

  final _Invoice _self;
  final $Res Function(_Invoice) _then;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? coursePlaceId = null,Object? studentId = null,Object? courseIds = null,Object? period = null,Object? status = null,Object? dueDate = null,Object? created = null,Object? updated = freezed,Object? student = freezed,Object? courses = null,Object? totalPrice = freezed,Object? currency = freezed,}) {
  return _then(_Invoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,courseIds: null == courseIds ? _self._courseIds : courseIds // ignore: cast_nullable_to_non_nullable
as List<String>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvoiceStatusEnum,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,student: freezed == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as Student?,courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<Course>,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as CurrencyEnum?,
  ));
}

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentCopyWith<$Res>? get student {
    if (_self.student == null) {
    return null;
  }

  return $StudentCopyWith<$Res>(_self.student!, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}

// dart format on
