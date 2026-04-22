import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/invoice.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class InvoiceRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Invoice>> getAll() async {
    try {
      final pbInstance = await pb;
      final records = await pbInstance
          .collection('invoices')
          .getFullList(expand: 'student,courses');
      return records
          .map((record) => Invoice.fromJson(record.toJson()))
          .toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Invoice> getById(String id) async {
    try {
      final pbInstance = await pb;
      final record = await pbInstance
          .collection('invoices')
          .getOne(id, expand: 'student,courses');
      return Invoice.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Invoice> create(Invoice invoice) async {
    try {
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
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Invoice> update(String id, Invoice invoice) async {
    try {
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
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      final pbInstance = await pb;
      await pbInstance.collection('invoices').delete(id);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getCount() async {
    try {
      final pbInstance = await pb;
      final result = await pbInstance
          .collection('invoices')
          .getList(perPage: 0);
      return result.totalItems;
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> paginate({
    int page = 1,
    int limit = 5,
    String? search,
  }) async {
    try {
      String? filter;
      if (search != null && search.isNotEmpty) {
        filter = "id ~ '$search' || status ~ '$search'";
      }

      final pbInstance = await pb;
      final result = await pbInstance
          .collection('invoices')
          .getList(
            page: page,
            perPage: limit,
            filter: filter,
            expand: 'student,courses',
          );

      return {
        'items': result.items
            .map((record) => Invoice.fromJson(record.toJson()))
            .toList(),
        'totalItems': result.totalItems,
        'totalPages': result.totalPages,
        'page': result.page,
        'perPage': result.perPage,
      };
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
