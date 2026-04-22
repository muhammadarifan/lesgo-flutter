import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/invoice.dart';
import 'package:lesgo_flutter/repositories/invoice_repository.dart';

// Events
abstract class InvoiceEvent {}

class LoadInvoices extends InvoiceEvent {}

class PaginateInvoices extends InvoiceEvent {
  final int page;
  final int limit;
  final String? search;

  PaginateInvoices({this.page = 1, this.limit = 5, this.search});
}

class LoadInvoiceCount extends InvoiceEvent {}

class LoadInvoice extends InvoiceEvent {
  final String id;
  LoadInvoice(this.id);
}

class CreateInvoice extends InvoiceEvent {
  final Invoice invoice;
  CreateInvoice(this.invoice);
}

class UpdateInvoice extends InvoiceEvent {
  final String id;
  final Invoice invoice;
  UpdateInvoice(this.id, this.invoice);
}

class DeleteInvoice extends InvoiceEvent {
  final String id;
  DeleteInvoice(this.id);
}

// States
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoicesLoaded extends InvoiceState {
  final List<Invoice> invoices;
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final bool hasMore;

  InvoicesLoaded(
    this.invoices, {
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.hasMore,
  });

  InvoicesLoaded.initial(this.invoices)
    : totalItems = invoices.length,
      totalPages = 1,
      currentPage = 1,
      perPage = invoices.length,
      hasMore = false;
}

class InvoiceLoaded extends InvoiceState {
  final Invoice invoice;
  InvoiceLoaded(this.invoice);
}

class InvoiceCountLoaded extends InvoiceState {
  final int count;
  InvoiceCountLoaded(this.count);
}

class InvoiceError extends InvoiceState {
  final String message;
  InvoiceError(this.message);
}

// Bloc
class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository repository;

  InvoiceBloc(this.repository) : super(InvoiceInitial()) {
    on<LoadInvoices>(_onLoadInvoices);
    on<PaginateInvoices>(_onPaginateInvoices);
    on<LoadInvoiceCount>(_onLoadInvoiceCount);
    on<LoadInvoice>(_onLoadInvoice);
    on<CreateInvoice>(_onCreateInvoice);
    on<UpdateInvoice>(_onUpdateInvoice);
    on<DeleteInvoice>(_onDeleteInvoice);
  }

  Future<void> _onLoadInvoices(
    LoadInvoices event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final result = await repository.paginate();
      emit(
        InvoicesLoaded(
          result['items'] as List<Invoice>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onPaginateInvoices(
    PaginateInvoices event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final result = await repository.paginate(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );
      emit(
        InvoicesLoaded(
          result['items'] as List<Invoice>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onLoadInvoiceCount(
    LoadInvoiceCount event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final count = await repository.getCount();
      emit(InvoiceCountLoaded(count));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onLoadInvoice(
    LoadInvoice event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final invoice = await repository.getById(event.id);
      emit(InvoiceLoaded(invoice));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onCreateInvoice(
    CreateInvoice event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final invoice = await repository.create(event.invoice);
      emit(InvoiceLoaded(invoice));
      add(LoadInvoices());
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onUpdateInvoice(
    UpdateInvoice event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      final invoice = await repository.update(event.id, event.invoice);
      emit(InvoiceLoaded(invoice));
      add(LoadInvoices());
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> _onDeleteInvoice(
    DeleteInvoice event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceLoading());
    try {
      await repository.delete(event.id);
      add(LoadInvoices());
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }
}
