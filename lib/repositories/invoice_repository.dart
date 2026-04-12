import 'package:lesgo_flutter/models/invoice.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class InvoiceRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Invoice>> getAll() async {
    final records = await pb
        .collection('invoices')
        .getFullList(expand: 'student,courses');
    return records.map((record) => Invoice.fromJson(record.toJson())).toList();
  }

  Future<Invoice> getById(String id) async {
    final record = await pb
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

    final record = await pb.collection('invoices').create(body: data);
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

    final record = await pb.collection('invoices').update(id, body: data);
    return Invoice.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('invoices').delete(id);
  }

  Future<int> getCount() async {
    final result = await pb.collection('invoices').getList(perPage: 0);
    return result.totalItems;
  }
}
