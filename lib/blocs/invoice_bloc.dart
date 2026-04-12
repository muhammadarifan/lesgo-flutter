import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/invoice.dart';
import 'package:lesgo_flutter/repositories/invoice_repository.dart';

// Events
abstract class InvoiceEvent {}

class LoadInvoices extends InvoiceEvent {}

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
  InvoicesLoaded(this.invoices);
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
      final invoices = await repository.getAll();
      emit(InvoicesLoaded(invoices));
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
