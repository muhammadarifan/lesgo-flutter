import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import '../blocs/invoice_bloc.dart';
import '../blocs/student_bloc.dart';
import '../blocs/course_bloc.dart';
import '../models/invoice.dart';
import '../models/student.dart';
import '../enums/invoice_status_enum.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
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
    context.read<InvoiceBloc>().add(LoadInvoices());
    context.read<StudentBloc>().add(LoadStudents());
    context.read<CourseBloc>().add(LoadCourses());
  }

  void _onPageChange() {
    final page = _paginationController!.value + 1;
    context.read<InvoiceBloc>().add(
      PaginateInvoices(page: page, limit: _perPage, search: _currentSearch),
    );
  }

  void _onPerPageChange() {
    final newValue = _perPageController.value;
    if (newValue != null && newValue != _perPage) {
      setState(() {
        _perPage = newValue;
        _paginationController?.value = 0; // Reset to first page
      });
      context.read<InvoiceBloc>().add(
        PaginateInvoices(page: 1, limit: _perPage, search: _currentSearch),
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
        BlocListener<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceError) {
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
        BlocListener<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is StudentError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Student Error'),
                description: Text(state.message),
              );
            }
          },
        ),
        BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Course Error'),
                description: Text(state.message),
              );
            }
          },
        ),
      ],
      child: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          // Invoice-specific listener if needed
        },
        builder: (context, state) {
          if (state is InvoiceLoading) {
            return const Center(child: FCircularProgress());
          } else if (state is InvoicesLoaded) {
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
                              context.read<InvoiceBloc>().add(
                                PaginateInvoices(
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
                          onPress: () => _generateInvoicesForCurrentMonth(),
                          suffix: const Icon(Icons.auto_fix_high),
                          child: const Text('Generate Invoices'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Invoices list
                    Expanded(child: _buildInvoicesList(state)),

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
                    BlocListener<InvoiceBloc, InvoiceState>(
                      listener: (context, state) {
                        if (state is InvoiceError) {
                          showFToast(
                            context: context,
                            variant: .destructive,
                            icon: Icon(FIcons.circleX),
                            title: Text('Error'),
                            description: Text(state.message),
                          );
                        } else if (state is InvoicesLoaded) {
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
              child: Center(child: Text('Failed to load invoices')),
            );
          }
        },
      ),
    );
  }

  Widget _buildInvoicesList(InvoicesLoaded state) {
    final invoices = state.invoices;
    if (invoices.isEmpty) {
      return const Center(child: Text('No invoices found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return FItem(
          prefix: FAvatar.raw(
            child: Text(
              invoice.studentObject?.name.isNotEmpty == true
                  ? invoice.studentObject!.name[0].toUpperCase()
                  : 'I',
            ),
          ),
          title: Text(invoice.studentObject?.name ?? 'Invoice ${invoice.id}'),
          subtitle: Text(
            'Status: ${invoice.status?.displayName ?? 'Unknown'} • Due: ${invoice.dueDate != null ? _formatDate(invoice.dueDate!) : 'No due date'} • Total: ${invoice.totalAmount} ${invoice.currency?.displayName ?? ''}',
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showInvoiceDetails(invoice),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () {
                  final controller = showFPersistentSheet(
                    context: context,
                    style: const .delta(flingVelocity: 700),
                    side: .rtl,
                    builder: (context, controller) => _buildInvoiceForm(
                      controller: controller,
                      invoice: invoice,
                    ),
                  );
                  _controllers.add(controller);
                },
              ),
              FButton(
                child: Icon(FIcons.trash),
                onPress: () => _deleteInvoice(invoice),
              ),
            ],
          ),
        );
      },
      count: invoices.length,
      divider: .full,
    );
  }

  Widget _buildInvoiceForm({
    Invoice? invoice,
    required FPersistentSheetController controller,
  }) {
    final isEditing = invoice != null;
    final formKey = GlobalKey<FormState>();
    String? studentId = isEditing ? invoice.studentId : null;
    List<String> courseIds = isEditing ? (invoice.courseIds ?? []) : [];
    DateTime? period = isEditing ? invoice.period : null;
    InvoiceStatusEnum? status = isEditing
        ? invoice.status
        : InvoiceStatusEnum.unpaid;
    DateTime? dueDate = isEditing ? invoice.dueDate : null;
    bool? isActive = isEditing ? invoice.isActive : true;

    return FSheets(
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
                isEditing ? 'Edit Invoice' : 'Add New Invoice',
                style: context.theme.typography.xl,
              ),
              // Student Selection
              BlocBuilder<StudentBloc, StudentState>(
                builder: (context, studentState) {
                  if (studentState is StudentsLoaded) {
                    final activeStudents = studentState.students
                        .where((s) => s.isActive)
                        .toList();
                    Student? selectedStudent;
                    if (studentId != null && studentId!.isNotEmpty) {
                      try {
                        selectedStudent = activeStudents.firstWhere(
                          (s) => s.id == studentId,
                        );
                      } catch (e) {
                        selectedStudent = null;
                      }
                    }

                    return FSelect<Student?>.rich(
                      control: .managed(initial: selectedStudent),
                      hint: 'Select Student',
                      format: (s) => s?.name ?? '',
                      children: [
                        const FSelectItem(
                          title: Text('No Student'),
                          value: null,
                        ),
                        ...activeStudents.map(
                          (student) => FSelectItem.item(
                            title: Text(student.name),
                            value: student,
                          ),
                        ),
                      ],
                      validator: (value) =>
                          null, // Optional field, no validation
                      onSaved: (newValue) => studentId = newValue?.id,
                    );
                  }
                  // For loading, error, or initial states, show a disabled select
                  return FSelect<Student?>.rich(
                    control: .managed(),
                    hint: studentState is StudentLoading
                        ? 'Loading students...'
                        : studentState is StudentError
                        ? 'Error loading students'
                        : 'Select Student',
                    format: (s) => s?.name ?? '',
                    children: [],
                  );
                },
              ),
              // Courses Multi-Selection
              BlocBuilder<CourseBloc, CourseState>(
                builder: (context, courseState) {
                  if (courseState is CourseLoading) {
                    return FMultiSelect<Course>.rich(
                      control: .managed(),
                      hint: const Text('Loading courses...'),
                      format: (Course course) => Text(course.name),
                      children: [],
                    );
                  } else if (courseState is CoursesLoaded) {
                    final activeCourses = courseState.courses
                        .where((c) => c.isActive)
                        .toList();
                    final selectedCourses = activeCourses
                        .where((c) => courseIds.contains(c.id))
                        .toList();

                    return FMultiSelect<Course>.rich(
                      control: .managed(initial: selectedCourses.toSet()),
                      hint: const Text('Select Courses'),
                      format: (Course course) => Text(course.name),
                      children: activeCourses
                          .map(
                            (course) => FSelectItem.item(
                              title: Text(course.name),
                              value: course,
                            ),
                          )
                          .toList(),
                      validator: (value) =>
                          null, // Optional field, no validation
                      onSaved: (newValue) =>
                          courseIds = newValue.map((c) => c.id).toList(),
                    );
                  } else if (courseState is CourseError) {
                    return FMultiSelect<Course>.rich(
                      control: .managed(),
                      hint: const Text('Error loading courses'),
                      format: (Course course) => Text(course.name),
                      children: [],
                    );
                  }
                  // Initial state - trigger load if not already loading
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (courseState is CourseInitial) {
                      context.read<CourseBloc>().add(LoadCourses());
                    }
                  });
                  return FMultiSelect<Course>.rich(
                    control: .managed(),
                    hint: const Text('Select Courses'),
                    format: (Course course) => Text(course.name),
                    children: [],
                  );
                },
              ),
              FDateField.calendar(
                control: .managed(initial: period),
                hint: 'Select Period',
                onSaved: (newValue) => period = newValue,
              ),
              FSelect<InvoiceStatusEnum>.rich(
                control: .managed(initial: status),
                hint: 'Select Status',
                format: (s) => s.displayName,
                children: InvoiceStatusEnum.values
                    .map(
                      (e) => FSelectItem(title: Text(e.displayName), value: e),
                    )
                    .toList(),
                validator: (value) =>
                    value == null ? 'Status is required' : null,
                onSaved: (newValue) => status = newValue!,
              ),
              FDateField.calendar(
                control: .managed(initial: dueDate),
                hint: 'Select Due Date',
                onSaved: (newValue) => dueDate = newValue,
              ),
              FSelect<bool>.rich(
                control: .managed(initial: isActive),
                hint: 'Select status',
                format: (s) => s ? 'Active' : 'Inactive',
                children: [
                  .item(title: const Text('Active'), value: true),
                  .item(title: const Text('Inactive'), value: false),
                ],
                validator: (value) =>
                    value == null ? 'Status is required' : null,
                onSaved: (newValue) => isActive = newValue!,
              ),
              FSelect<bool>.rich(
                control: .managed(initial: isActive),
                hint: 'Select status',
                format: (s) => s ? 'Active' : 'Inactive',
                children: [
                  .item(title: const Text('Active'), value: true),
                  .item(title: const Text('Inactive'), value: false),
                ],
                onSaved: (newValue) => isActive = newValue!,
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

                        final updatedInvoice = isEditing
                            ? invoice.copyWith(
                                studentId: studentId,
                                courseIds: courseIds,
                                period: period,
                                status: status,
                                dueDate: dueDate,
                                isActive: isActive,
                              )
                            : Invoice(
                                id: '',
                                studentId: studentId,
                                courseIds: courseIds,
                                period: period,
                                status: status,
                                dueDate: dueDate,
                                isActive: isActive,
                              );

                        if (isEditing) {
                          context.read<InvoiceBloc>().add(
                            UpdateInvoice(updatedInvoice.id, updatedInvoice),
                          );
                        } else {
                          context.read<InvoiceBloc>().add(
                            CreateInvoice(updatedInvoice),
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
    );
  }

  void _generateInvoicesForCurrentMonth() async {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, 1);
    final nextMonth = DateTime(now.year, now.month + 1, 1);

    try {
      // Check for existing invoices for current month
      final existingInvoices = await context
          .read<InvoiceBloc>()
          .repository
          .getAll();
      final currentMonthInvoices = existingInvoices
          .where(
            (invoice) =>
                invoice.period != null &&
                invoice.period!.year == now.year &&
                invoice.period!.month == now.month,
          )
          .toList();

      if (!mounted) return;

      if (currentMonthInvoices.isNotEmpty) {
        // Show warning dialog
        showFDialog(
          context: context,
          builder: (context, style, animation) => FDialog(
            title: const Text('Invoices Already Exist'),
            body: Text(
              'There are already ${currentMonthInvoices.length} invoice(s) for ${DateFormat('MMMM yyyy').format(now)}. '
              'Do you want to overwrite them?',
            ),
            actions: [
              FButton(
                onPress: () => context.pop(),
                variant: .outline,
                child: const Text('Cancel'),
              ),
              FButton(
                onPress: () async {
                  context.pop();
                  await _performInvoiceGeneration(
                    currentMonth,
                    nextMonth,
                    overwrite: true,
                  );
                },
                variant: .destructive,
                child: const Text('Overwrite'),
              ),
            ],
          ),
        );
      } else {
        await _performInvoiceGeneration(
          currentMonth,
          nextMonth,
          overwrite: false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      showFToast(
        context: context,
        variant: .destructive,
        icon: Icon(FIcons.circleX),
        title: Text('Error'),
        description: Text('Failed to check existing invoices: $e'),
      );
    }
  }

  Future<void> _performInvoiceGeneration(
    DateTime currentMonth,
    DateTime nextMonth, {
    required bool overwrite,
  }) async {
    try {
      // Get all active students
      final students = await context.read<StudentBloc>().repository.getAll();
      final activeStudents = students.where((s) => s.isActive).toList();

      // Get all active courses
      // ignore: use_build_context_synchronously
      final courses = await context.read<CourseBloc>().repository.getAll();
      final activeCourses = courses.where((c) => c.isActive).toList();

      if (!mounted) return;

      if (activeStudents.isEmpty) {
        showFToast(
          context: context,
          variant: .destructive,
          icon: Icon(FIcons.circleX),
          title: Text('No Active Students'),
          description: const Text(
            'There are no active students to generate invoices for.',
          ),
        );
        return;
      }

      if (activeCourses.isEmpty) {
        showFToast(
          context: context,
          variant: .destructive,
          icon: Icon(FIcons.circleX),
          title: Text('No Active Courses'),
          description: const Text(
            'There are no active courses to include in invoices.',
          ),
        );
        return;
      }

      if (activeCourses.isEmpty) {
        showFToast(
          context: context,
          variant: .destructive,
          icon: Icon(FIcons.circleX),
          title: Text('No Active Courses'),
          description: const Text(
            'There are no active courses to include in invoices.',
          ),
        );
        return;
      }

      // Delete existing invoices if overwrite is true
      if (overwrite) {
        final existingInvoices = await context
            .read<InvoiceBloc>()
            .repository
            .getAll();
        final currentMonthInvoices = existingInvoices
            .where(
              (invoice) =>
                  invoice.period != null &&
                  invoice.period!.year == currentMonth.year &&
                  invoice.period!.month == currentMonth.month,
            )
            .toList();

        for (final invoice in currentMonthInvoices) {
          // ignore: use_build_context_synchronously
          await context.read<InvoiceBloc>().repository.delete(invoice.id);
        }
      }

      // Generate invoices for each active student
      int generatedCount = 0;
      for (final student in activeStudents) {
        // For now, include all active courses for each student
        // In a real app, you might want to filter based on student's enrolled courses
        final courseIds = activeCourses.map((c) => c.id).toList();

        final invoice = Invoice(
          id: '',
          studentId: student.id,
          courseIds: courseIds,
          period: currentMonth,
          status: InvoiceStatusEnum.unpaid,
          dueDate: nextMonth.subtract(
            const Duration(days: 1),
          ), // Due at end of month
          isActive: true,
        );

        // ignore: use_build_context_synchronously
        await context.read<InvoiceBloc>().repository.create(invoice);
        generatedCount++;
      }

      if (!mounted) return;

      // Refresh the invoice list
      context.read<InvoiceBloc>().add(LoadInvoices());

      showFToast(
        context: context,
        title: Text('Invoices Generated'),
        description: Text(
          'Successfully generated $generatedCount invoice(s) for ${DateFormat('MMMM yyyy').format(currentMonth)}.',
        ),
      );
    } catch (e) {
      if (!mounted) return;
      showFToast(
        context: context,
        variant: .destructive,
        icon: Icon(FIcons.circleX),
        title: Text('Generation Failed'),
        description: Text('Failed to generate invoices: $e'),
      );
    }
  }

  void _deleteInvoice(Invoice invoice) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Invoice'),
        body: Text(
          'Are you sure you want to delete invoice for "${invoice.studentObject?.name ?? invoice.id}"?',
        ),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<InvoiceBloc>().add(DeleteInvoice(invoice.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showInvoiceDetails(Invoice invoice) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Invoice Details'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('ID'), details: Text(invoice.id)),
            .item(
              title: const Text('Student'),
              details: Text(invoice.studentObject?.name ?? 'No student'),
            ),
            .item(
              title: const Text('Courses'),
              details: Text(
                invoice.courseObjects.isNotEmpty
                    ? invoice.courseObjects.map((c) => c.name).join(', ')
                    : 'No courses',
              ),
            ),
            .item(
              title: const Text('Total Amount'),
              details: Text(
                '${invoice.totalAmount} ${invoice.currency?.displayName ?? ''}',
              ),
            ),
            .item(
              title: const Text('Period'),
              details: Text(
                invoice.period != null
                    ? _formatDate(invoice.period!)
                    : 'No period',
              ),
            ),
            .item(
              title: const Text('Status'),
              details: Text(invoice.status?.displayName ?? 'Unknown'),
            ),
            .item(
              title: const Text('Due Date'),
              details: Text(
                invoice.dueDate != null
                    ? _formatDate(invoice.dueDate!)
                    : 'No due date',
              ),
            ),
            .item(
              title: const Text('Active'),
              details: Text(invoice.isActive == true ? 'Yes' : 'No'),
            ),
            .item(
              title: const Text('Created'),
              details: Text(
                invoice.created != null
                    ? _formatDateTime(invoice.created!)
                    : 'Unknown',
              ),
            ),
            .item(
              title: const Text('Updated'),
              details: Text(
                invoice.updated != null
                    ? _formatDateTime(invoice.updated!)
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

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
  }
}
