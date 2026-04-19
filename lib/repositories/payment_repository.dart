import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' show MultipartFile;
import 'package:lesgo_flutter/models/payment.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class PaymentRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Payment>> getAll() async {
    final pbInstance = await pb;
    final records = await pbInstance
        .collection('payments')
        .getFullList(expand: 'invoice');
    return records.map((record) => Payment.fromJson(record.toJson())).toList();
  }

  Future<Payment> getById(String id) async {
    final pbInstance = await pb;
    final record = await pbInstance
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

    final pbInstance = await pb;
    final record = await pbInstance
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

    final pbInstance = await pb;
    final record = await pbInstance
        .collection('payments')
        .update(id, body: data, files: files ?? []);
    return Payment.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    final pbInstance = await pb;
    await pbInstance.collection('payments').delete(id);
  }

  Future<int> getCount() async {
    final pbInstance = await pb;
    final result = await pbInstance.collection('payments').getList(perPage: 0);
    return result.totalItems;
  }
}
