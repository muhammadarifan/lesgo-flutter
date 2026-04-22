import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/enums/currency_enum.dart';
import 'package:lesgo_flutter/enums/invoice_status_enum.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import 'package:lesgo_flutter/models/student/student.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
abstract class Invoice with _$Invoice {
  factory Invoice({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    @JsonKey(name: 'student') required String studentId,
    @JsonKey(name: 'courses') @Default([]) List<String> courseIds,
    required DateTime period,
    required InvoiceStatusEnum status,
    @JsonKey(name: 'due_date') required DateTime dueDate,
    required DateTime created,
    DateTime? updated,

    @JsonKey(includeFromJson: false) Student? student,
    @JsonKey(includeFromJson: false) @Default([]) List<Course> courses,
    @JsonKey(includeToJson: false) int? totalPrice,
    @JsonKey(includeToJson: false) CurrencyEnum? currency,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  factory Invoice.create({
    required String studentId,
    required List<String> courseIds,
    required DateTime period,
    required InvoiceStatusEnum status,
    required DateTime dueDate,
  }) {
    return Invoice(
      id: '',
      coursePlaceId: '',
      studentId: studentId,
      courseIds: courseIds,
      period: period,
      status: status,
      dueDate: dueDate,
      created: DateTime.now(),
    );
  }
}
