import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../blocs/payment_bloc.dart';
import '../blocs/invoice_bloc.dart';
import '../models/payment.dart';
import '../models/invoice.dart';
import '../enums/currency_enum.dart';
import '../enums/payment_method_enum.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final List<FPersistentSheetController> _controllers = [];
  FPaginationController? _paginationController;
  String? _currentSearch;
  int _perPage = 10;
  late final FSelectController<int> _perPageController;

  @override
  void initState() {
    super.initState();
    _paginationController = FPaginationController(pages: 1, page: 0);
    _paginationController!.addListener(_onPageChange);
    _perPageController = FSelectController<int>(value: _perPage);
    _perPageController.addListener(_onPerPageChange);
    context.read<PaymentBloc>().add(LoadPayments());
    context.read<InvoiceBloc>().add(LoadInvoices());
  }

  void _onPageChange() {
    final page = _paginationController!.value + 1;
    context.read<PaymentBloc>().add(
      PaginatePayments(page: page, limit: _perPage, search: _currentSearch),
    );
  }

  void _onPerPageChange() {
    final newValue = _perPageController.value;
    if (newValue != null && newValue != _perPage) {
      setState(() {
        _perPage = newValue;
        _paginationController?.value = 0; // Reset to first page
      });
      context.read<PaymentBloc>().add(
        PaginatePayments(page: 1, limit: _perPage, search: _currentSearch),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    _paginationController?.dispose();
    _perPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Error'),
                description: Text(state.message),
              );
            }
          },
        ),
        BlocListener<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Invoice Error'),
                description: Text(state.message),
              );
            }
          },
        ),
      ],
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          // Payment-specific listener if needed
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: FCircularProgress());
          } else if (state is PaymentsLoaded) {
            return FScaffold(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with search and add button
                    Row(
                      children: [
                        Expanded(
                          child: FTextField(
                            prefixBuilder: (context, style, variants) =>
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 8.0,
                                  ),
                                  child: const Icon(FIcons.search),
                                ),
                            onSubmit: (value) {
                              setState(() {
                                _currentSearch = value.isEmpty ? null : value;
                                _paginationController?.value = 0;
                              });
                              context.read<PaymentBloc>().add(
                                PaginatePayments(
                                  page: 1,
                                  limit: _perPage,
                                  search: value.isEmpty ? null : value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        FButton(
                          onPress: () => showFPersistentSheet(
                            context: context,
                            style: const .delta(flingVelocity: 700),
                            side: .rtl,
                            builder: (context, controller) =>
                                _buildPaymentForm(controller: controller),
                          ),
                          suffix: const Icon(Icons.add),
                          child: const Text('Add Payment'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Payments list
                    Expanded(child: _buildPaymentsList(state)),

                    // Pagination (outside BlocBuilder)
                    if (_paginationController != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Per page selector
                            SizedBox(
                              width: 140,
                              child: FSelect<int>.rich(
                                control: .managed(
                                  controller: _perPageController,
                                ),
                                format: (value) => '$value per page',
                                children: [
                                  .item(
                                    title: const Text('5 per page'),
                                    value: 5,
                                  ),
                                  .item(
                                    title: const Text('10 per page'),
                                    value: 10,
                                  ),
                                  .item(
                                    title: const Text('25 per page'),
                                    value: 25,
                                  ),
                                  .item(
                                    title: const Text('50 per page'),
                                    value: 50,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Pagination
                            Expanded(
                              child: FPagination(
                                control: .managed(
                                  controller: _paginationController!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // BlocListener for side effects
                    BlocListener<PaymentBloc, PaymentState>(
                      listener: (context, state) {
                        if (state is PaymentError) {
                          showFToast(
                            context: context,
                            variant: .destructive,
                            icon: Icon(FIcons.circleX),
                            title: Text('Error'),
                            description: Text(state.message),
                          );
                        } else if (state is PaymentsLoaded) {
                          if (_paginationController == null ||
                              _paginationController!.pages !=
                                  state.totalPages) {
                            _paginationController?.dispose();
                            _paginationController = FPaginationController(
                              pages: state.totalPages,
                              page: state.currentPage - 1,
                            );
                            _paginationController!.addListener(_onPageChange);
                          } else {
                            _paginationController?.value =
                                state.currentPage - 1;
                          }
                        }
                      },
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const FScaffold(
              child: Center(child: Text('Failed to load payments')),
            );
          }
        },
      ),
    );
  }

  Widget _buildPaymentsList(PaymentsLoaded state) {
    final payments = state.payments;
    if (payments.isEmpty) {
      return const Center(child: Text('No payments found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final payment = payments[index];
        return FItem(
          prefix: FAvatar.raw(
            child: Text(
              payment.id.isNotEmpty ? payment.id[0].toUpperCase() : 'P',
            ),
          ),
          title: Text('Payment ${payment.id}'),
          subtitle: Text(
            '${payment.currency?.displayName ?? 'Unknown'} ${_formatPrice(payment.amountPaid ?? 0)} • ${payment.method?.displayName ?? 'Unknown'}',
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showPaymentDetails(payment),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () {
                  final controller = showFPersistentSheet(
                    context: context,
                    style: const .delta(flingVelocity: 700),
                    side: .rtl,
                    builder: (context, controller) => _buildPaymentForm(
                      controller: controller,
                      payment: payment,
                    ),
                  );
                  _controllers.add(controller);
                },
              ),
              FButton(
                child: Icon(FIcons.trash),
                onPress: () => _deletePayment(payment),
              ),
            ],
          ),
        );
      },
      count: payments.length,
      divider: .full,
    );
  }

  Widget _buildPaymentForm({
    Payment? payment,
    required FPersistentSheetController controller,
  }) {
    final isEditing = payment != null;
    final formKey = GlobalKey<FormState>();
    String? invoiceId = isEditing ? payment.invoiceId : null;
    double? amountPaid = isEditing ? payment.amountPaid : null;
    CurrencyEnum? currency = isEditing ? payment.currency : CurrencyEnum.idr;
    DateTime? paymentDate = isEditing ? payment.paymentDate : null;
    PaymentMethodEnum? method = isEditing ? payment.method : null;
    String? proof = isEditing ? payment.proof : null;
    ValueNotifier<PlatformFile?> selectedFile = ValueNotifier(null);

    return FSheets(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.colors.background,
            borderRadius: context.theme.style.borderRadius.md,
            border: .all(color: context.theme.colors.border),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  isEditing ? 'Edit Payment' : 'Add New Payment',
                  style: context.theme.typography.xl,
                ),
                // Invoice Selection
                BlocBuilder<InvoiceBloc, InvoiceState>(
                  builder: (context, invoiceState) {
                    if (invoiceState is InvoiceLoading) {
                      return FSelect<Invoice?>.rich(
                        control: .managed(),
                        hint: 'Loading invoices...',
                        format: (i) => i != null ? 'Invoice ${i.id}' : '',
                        children: [],
                      );
                    } else if (invoiceState is InvoicesLoaded) {
                      final activeInvoices = invoiceState.invoices
                          .where((i) => i.isActive == true)
                          .toList();
                      Invoice? selectedInvoice;
                      if (invoiceId != null && invoiceId!.isNotEmpty) {
                        try {
                          selectedInvoice = activeInvoices.firstWhere(
                            (i) => i.id == invoiceId,
                          );
                        } catch (e) {
                          selectedInvoice = null;
                        }
                      }

                      return FSelect<Invoice?>.rich(
                        control: .managed(initial: selectedInvoice),
                        hint: 'Select Invoice',
                        format: (i) => i != null ? 'Invoice ${i.id}' : '',
                        children: [
                          const FSelectItem<Invoice?>(
                            title: Text('No Invoice'),
                            value: null,
                          ),
                          ...activeInvoices.map(
                            (invoice) => FSelectItem<Invoice?>.item(
                              title: Text('Invoice ${invoice.id}'),
                              value: invoice,
                            ),
                          ),
                        ],
                        validator: (value) =>
                            null, // Optional field, no validation
                        onSaved: (newValue) => invoiceId = newValue?.id,
                      );
                    } else if (invoiceState is InvoiceError) {
                      return FSelect<Invoice?>.rich(
                        control: .managed(),
                        hint: 'Error loading invoices',
                        format: (i) => i != null ? 'Invoice ${i.id}' : '',
                        children: [],
                      );
                    }
                    // Initial state - trigger load if not already loading
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (invoiceState is InvoiceInitial) {
                        context.read<InvoiceBloc>().add(LoadInvoices());
                      }
                    });
                    return FSelect<Invoice?>.rich(
                      control: .managed(),
                      hint: 'Select Invoice',
                      format: (i) => i != null ? 'Invoice ${i.id}' : '',
                      children: [],
                    );
                  },
                ),
                FTextFormField(
                  control: .managed(
                    initial: TextEditingValue(
                      text: amountPaid?.toString() ?? '',
                    ),
                  ),
                  label: const Text('Amount Paid'),
                  hint: '100000',
                  keyboardType: TextInputType.number,
                  autovalidateMode: .onUserInteraction,
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Amount is required' : null,
                  onSaved: (newValue) =>
                      amountPaid = double.tryParse(newValue!),
                ),
                FSelect<CurrencyEnum>.rich(
                  control: .managed(initial: currency),
                  label: const Text('Currency'),
                  hint: 'Select a currency',
                  format: (c) => c.displayName,
                  children: CurrencyEnum.values
                      .map(
                        (e) =>
                            FSelectItem(title: Text(e.displayName), value: e),
                      )
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Currency is required' : null,
                  onSaved: (newValue) => currency = newValue!,
                ),
                FDateField.calendar(
                  control: .managed(initial: paymentDate),
                  hint: 'Select Payment Date',
                  onSaved: (newValue) => paymentDate = newValue,
                ),
                FSelect<PaymentMethodEnum>.rich(
                  control: .managed(initial: method),
                  hint: 'Select Payment Method',
                  format: (m) => m.displayName,
                  children: PaymentMethodEnum.values
                      .map(
                        (e) =>
                            FSelectItem(title: Text(e.displayName), value: e),
                      )
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Method is required' : null,
                  onSaved: (newValue) => method = newValue!,
                ),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isEditing && proof != null && proof.isNotEmpty)
                      Text('Current Proof: $proof'),
                    FButton(
                      onPress: () async {
                        final result = await FilePicker.pickFiles(
                          type: FileType.image,
                          withData: true,
                        );
                        if (result != null &&
                            result.files.single.path != null) {
                          selectedFile.value = result.files.single;
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: selectedFile,
                        builder: (context, value, child) {
                          return Text(
                            value != null
                                ? 'File Selected: ${value.name}'
                                : 'Select Proof File',
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: selectedFile,
                      builder: (context, value, child) {
                        if (value == null) {
                          return const SizedBox.shrink();
                        }

                        return Center(
                          child: Image.memory(value.bytes!, width: 200),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FButton(
                        onPress: () {
                          controller.hide();
                        },
                        variant: .outline,
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FButton(
                        onPress: () {
                          if (!formKey.currentState!.validate()) return;

                          formKey.currentState!.save();

                          final updatedPayment = isEditing
                              ? payment.copyWith(
                                  invoiceId: invoiceId,
                                  amountPaid: amountPaid,
                                  currency: currency,
                                  paymentDate: paymentDate,
                                  method: method,
                                  proof: null,
                                )
                              : Payment(
                                  id: '',
                                  invoiceId: invoiceId,
                                  amountPaid: amountPaid,
                                  currency: currency,
                                  paymentDate: paymentDate,
                                  method: method,
                                  proof: null,
                                );

                          if (isEditing) {
                            context.read<PaymentBloc>().add(
                              UpdatePayment(
                                updatedPayment.id,
                                updatedPayment,
                                proofFileBytes: selectedFile.value?.bytes,
                                proofFileName: selectedFile.value?.name,
                              ),
                            );
                          } else {
                            context.read<PaymentBloc>().add(
                              CreatePayment(
                                updatedPayment,
                                proofFileBytes: selectedFile.value?.bytes,
                                proofFileName: selectedFile.value?.name,
                              ),
                            );
                          }

                          controller.hide();
                        },
                        child: Text(isEditing ? 'Update' : 'Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deletePayment(Payment payment) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Payment'),
        body: Text('Are you sure you want to delete payment "${payment.id}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<PaymentBloc>().add(DeletePayment(payment.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showPaymentDetails(Payment payment) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Payment Details'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('ID'), details: Text(payment.id)),
            .item(
              title: const Text('Invoice ID'),
              details: Text(payment.invoiceId ?? 'No invoice'),
            ),
            .item(
              title: const Text('Amount Paid'),
              details: Text(
                payment.amountPaid != null
                    ? '${payment.currency?.displayName ?? 'Unknown'} ${_formatPrice(payment.amountPaid!)}'
                    : 'No amount',
              ),
            ),
            .item(
              title: const Text('Currency'),
              details: Text(payment.currency?.displayName ?? 'Unknown'),
            ),
            .item(
              title: const Text('Payment Date'),
              details: Text(
                payment.paymentDate != null
                    ? _formatDate(payment.paymentDate!)
                    : 'No payment date',
              ),
            ),
            .item(
              title: const Text('Method'),
              details: Text(payment.method?.displayName ?? 'Unknown'),
            ),
            .item(
              title: const Text('Proof'),
              details: Text(payment.proof ?? 'No proof'),
            ),
            .item(
              title: const Text('Created'),
              details: Text(
                payment.created != null
                    ? _formatDateTime(payment.created!)
                    : 'Unknown',
              ),
            ),
            .item(
              title: const Text('Updated'),
              details: Text(
                payment.updated != null
                    ? _formatDateTime(payment.updated!)
                    : 'Unknown',
              ),
            ),
          ],
        ),
        actions: [
          FButton(onPress: () => context.pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    var formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(price);
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
  }
}
