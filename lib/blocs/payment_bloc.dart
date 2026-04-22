import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/payment.dart';
import 'package:lesgo_flutter/repositories/payment_repository.dart';

// Events
abstract class PaymentEvent {}

class LoadPayments extends PaymentEvent {}

class PaginatePayments extends PaymentEvent {
  final int page;
  final int limit;
  final String? search;

  PaginatePayments({this.page = 1, this.limit = 5, this.search});
}

class LoadPaymentCount extends PaymentEvent {}

class LoadPayment extends PaymentEvent {
  final String id;
  LoadPayment(this.id);
}

class CreatePayment extends PaymentEvent {
  final Payment payment;
  final Uint8List? proofFileBytes;
  final String? proofFileName;
  CreatePayment(this.payment, {this.proofFileBytes, this.proofFileName});
}

class UpdatePayment extends PaymentEvent {
  final String id;
  final Payment payment;
  final Uint8List? proofFileBytes;
  final String? proofFileName;
  UpdatePayment(
    this.id,
    this.payment, {
    this.proofFileBytes,
    this.proofFileName,
  });
}

class DeletePayment extends PaymentEvent {
  final String id;
  DeletePayment(this.id);
}

// States
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentsLoaded extends PaymentState {
  final List<Payment> payments;
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final bool hasMore;

  PaymentsLoaded(
    this.payments, {
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.hasMore,
  });

  PaymentsLoaded.initial(this.payments)
    : totalItems = payments.length,
      totalPages = 1,
      currentPage = 1,
      perPage = payments.length,
      hasMore = false;
}

class PaymentLoaded extends PaymentState {
  final Payment payment;
  PaymentLoaded(this.payment);
}

class PaymentCountLoaded extends PaymentState {
  final int count;
  PaymentCountLoaded(this.count);
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}

// Bloc
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<LoadPayments>(_onLoadPayments);
    on<PaginatePayments>(_onPaginatePayments);
    on<LoadPaymentCount>(_onLoadPaymentCount);
    on<LoadPayment>(_onLoadPayment);
    on<CreatePayment>(_onCreatePayment);
    on<UpdatePayment>(_onUpdatePayment);
    on<DeletePayment>(_onDeletePayment);
  }

  Future<void> _onLoadPayments(
    LoadPayments event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await repository.paginate();
      emit(
        PaymentsLoaded(
          result['items'] as List<Payment>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onPaginatePayments(
    PaginatePayments event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await repository.paginate(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );
      emit(
        PaymentsLoaded(
          result['items'] as List<Payment>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onLoadPaymentCount(
    LoadPaymentCount event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final count = await repository.getCount();
      emit(PaymentCountLoaded(count));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onLoadPayment(
    LoadPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await repository.getById(event.id);
      emit(PaymentLoaded(payment));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onCreatePayment(
    CreatePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await repository.create(
        event.payment,
        proofFileBytes: event.proofFileBytes,
        proofFileName: event.proofFileName,
      );
      emit(PaymentLoaded(payment));
      add(LoadPayments());
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onUpdatePayment(
    UpdatePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await repository.update(
        event.id,
        event.payment,
        proofFileBytes: event.proofFileBytes,
        proofFileName: event.proofFileName,
      );
      emit(PaymentLoaded(payment));
      add(LoadPayments());
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onDeletePayment(
    DeletePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      await repository.delete(event.id);
      add(LoadPayments());
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
