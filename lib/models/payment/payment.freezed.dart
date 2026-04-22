// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

 String get id;@JsonKey(name: 'course_place') String get coursePlaceId;@JsonKey(name: 'invoice') String get invoiceId;@JsonKey(name: 'amount_paid') int get amountPaid; CurrencyEnum get currency;@JsonKey(name: 'payment_date') DateTime get paymentDate; PaymentMethodEnum get method; String? get proof; DateTime get created; DateTime? get updated;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.method, method) || other.method == method)&&(identical(other.proof, proof) || other.proof == proof)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,invoiceId,amountPaid,currency,paymentDate,method,proof,created,updated);

@override
String toString() {
  return 'Payment(id: $id, coursePlaceId: $coursePlaceId, invoiceId: $invoiceId, amountPaid: $amountPaid, currency: $currency, paymentDate: $paymentDate, method: $method, proof: $proof, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'invoice') String invoiceId,@JsonKey(name: 'amount_paid') int amountPaid, CurrencyEnum currency,@JsonKey(name: 'payment_date') DateTime paymentDate, PaymentMethodEnum method, String? proof, DateTime created, DateTime? updated
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? coursePlaceId = null,Object? invoiceId = null,Object? amountPaid = null,Object? currency = null,Object? paymentDate = null,Object? method = null,Object? proof = freezed,Object? created = null,Object? updated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as CurrencyEnum,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethodEnum,proof: freezed == proof ? _self.proof : proof // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'invoice')  String invoiceId, @JsonKey(name: 'amount_paid')  int amountPaid,  CurrencyEnum currency, @JsonKey(name: 'payment_date')  DateTime paymentDate,  PaymentMethodEnum method,  String? proof,  DateTime created,  DateTime? updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.invoiceId,_that.amountPaid,_that.currency,_that.paymentDate,_that.method,_that.proof,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'invoice')  String invoiceId, @JsonKey(name: 'amount_paid')  int amountPaid,  CurrencyEnum currency, @JsonKey(name: 'payment_date')  DateTime paymentDate,  PaymentMethodEnum method,  String? proof,  DateTime created,  DateTime? updated)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.coursePlaceId,_that.invoiceId,_that.amountPaid,_that.currency,_that.paymentDate,_that.method,_that.proof,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'course_place')  String coursePlaceId, @JsonKey(name: 'invoice')  String invoiceId, @JsonKey(name: 'amount_paid')  int amountPaid,  CurrencyEnum currency, @JsonKey(name: 'payment_date')  DateTime paymentDate,  PaymentMethodEnum method,  String? proof,  DateTime created,  DateTime? updated)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.coursePlaceId,_that.invoiceId,_that.amountPaid,_that.currency,_that.paymentDate,_that.method,_that.proof,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment extends Payment {
   _Payment({required this.id, @JsonKey(name: 'course_place') required this.coursePlaceId, @JsonKey(name: 'invoice') required this.invoiceId, @JsonKey(name: 'amount_paid') required this.amountPaid, required this.currency, @JsonKey(name: 'payment_date') required this.paymentDate, required this.method, this.proof, required this.created, this.updated}): super._();
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String id;
@override@JsonKey(name: 'course_place') final  String coursePlaceId;
@override@JsonKey(name: 'invoice') final  String invoiceId;
@override@JsonKey(name: 'amount_paid') final  int amountPaid;
@override final  CurrencyEnum currency;
@override@JsonKey(name: 'payment_date') final  DateTime paymentDate;
@override final  PaymentMethodEnum method;
@override final  String? proof;
@override final  DateTime created;
@override final  DateTime? updated;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.coursePlaceId, coursePlaceId) || other.coursePlaceId == coursePlaceId)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.method, method) || other.method == method)&&(identical(other.proof, proof) || other.proof == proof)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,coursePlaceId,invoiceId,amountPaid,currency,paymentDate,method,proof,created,updated);

@override
String toString() {
  return 'Payment(id: $id, coursePlaceId: $coursePlaceId, invoiceId: $invoiceId, amountPaid: $amountPaid, currency: $currency, paymentDate: $paymentDate, method: $method, proof: $proof, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'course_place') String coursePlaceId,@JsonKey(name: 'invoice') String invoiceId,@JsonKey(name: 'amount_paid') int amountPaid, CurrencyEnum currency,@JsonKey(name: 'payment_date') DateTime paymentDate, PaymentMethodEnum method, String? proof, DateTime created, DateTime? updated
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? coursePlaceId = null,Object? invoiceId = null,Object? amountPaid = null,Object? currency = null,Object? paymentDate = null,Object? method = null,Object? proof = freezed,Object? created = null,Object? updated = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,coursePlaceId: null == coursePlaceId ? _self.coursePlaceId : coursePlaceId // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as CurrencyEnum,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethodEnum,proof: freezed == proof ? _self.proof : proof // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
