import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/invoice.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class InvoiceRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Invoice>> getAll() async {
    final pbInstance = await pb;
    final records = await pbInstance
        .collection('invoices')
        .getFullList(expand: 'student,courses');
    return records.map((record) => Invoice.fromJson(record.toJson())).toList();
  }

  Future<Invoice> getById(String id) async {
    final pbInstance = await pb;
    final record = await pbInstance
        .collection('invoices')
        .getOne(id, expand: 'student,courses');
    return Invoice.fromJson(record.data);
  }

  Future<Invoice> create(Invoice invoice) async {
    final data =
        invoice
            .copyWith(period: invoice.period, dueDate: invoice.dueDate)
            .toJson()
          ..remove('id')
          ..remove('created')
          ..remove('updated');

    final pbInstance = await pb;
    final record = await pbInstance.collection('invoices').create(body: data);
    return Invoice.fromJson(record.data);
  }

  Future<Invoice> update(String id, Invoice invoice) async {
    final data =
        invoice
            .copyWith(period: invoice.period, dueDate: invoice.dueDate)
            .toJson()
          ..remove('id')
          ..remove('created')
          ..remove('updated');

    final pbInstance = await pb;
    final record = await pbInstance
        .collection('invoices')
        .update(id, body: data);
    return Invoice.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    final pbInstance = await pb;
    await pbInstance.collection('invoices').delete(id);
  }

  Future<int> getCount() async {
    final pbInstance = await pb;
    final result = await pbInstance.collection('invoices').getList(perPage: 0);
    return result.totalItems;
  }
}
