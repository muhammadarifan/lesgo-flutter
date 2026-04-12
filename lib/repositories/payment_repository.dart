import 'dart:typed_data';

import 'package:http/http.dart' show MultipartFile;
import 'package:lesgo_flutter/models/payment.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class PaymentRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Payment>> getAll() async {
    final records = await pb
        .collection('payments')
        .getFullList(expand: 'invoice');
    return records.map((record) => Payment.fromJson(record.toJson())).toList();
  }

  Future<Payment> getById(String id) async {
    final record = await pb
        .collection('payments')
        .getOne(id, expand: 'invoice');
    return Payment.fromJson(record.data);
  }

  Future<Payment> create(
    Payment payment, {
    Uint8List? proofFileBytes,
    String? proofFileName,
  }) async {
    final data = payment.copyWith(paymentDate: payment.paymentDate).toJson()
      ..remove('id')
      ..remove('created')
      ..remove('updated');

    List<MultipartFile>? files;
    if (proofFileBytes != null && proofFileName != null) {
      data.remove('proof');
      files = [
        MultipartFile.fromBytes(
          'proof',
          proofFileBytes,
          filename: proofFileName,
        ),
      ];
    }

    final record = await pb
        .collection('payments')
        .create(body: data, files: files ?? []);
    return Payment.fromJson(record.data);
  }

  Future<Payment> update(
    String id,
    Payment payment, {
    Uint8List? proofFileBytes,
    String? proofFileName,
  }) async {
    final data = payment.copyWith(paymentDate: payment.paymentDate).toJson()
      ..remove('id')
      ..remove('created')
      ..remove('updated');

    List<MultipartFile>? files;
    if (proofFileBytes != null && proofFileName != null) {
      data.remove('proof');
      files = [
        MultipartFile.fromBytes(
          'proof',
          proofFileBytes,
          filename: proofFileName,
        ),
      ];
    }

    final record = await pb
        .collection('payments')
        .update(id, body: data, files: files ?? []);
    return Payment.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('payments').delete(id);
  }

  Future<int> getCount() async {
    final result = await pb.collection('payments').getList(perPage: 0);
    return result.totalItems;
  }
}
