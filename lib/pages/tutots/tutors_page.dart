import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/models/tutor/tutor.dart';
import 'package:lesgo_flutter/pages/tutots/tutor_detail_dialog.dart';
import 'package:lesgo_flutter/pages/tutots/tutor_form.dart';
import '../../blocs/tutor_bloc.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
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
    context.read<TutorBloc>().add(LoadTutors());
  }

  void _onPageChange() {
    final page = _paginationController!.value + 1;
    context.read<TutorBloc>().add(
      PaginateTutors(page: page, limit: _perPage, search: _currentSearch),
    );
  }

  void _onPerPageChange() {
    final newValue = _perPageController.value;
    if (newValue != null && newValue != _perPage) {
      setState(() {
        _perPage = newValue;
        _paginationController?.value = 0; // Reset to first page
      });
      context.read<TutorBloc>().add(
        PaginateTutors(page: 1, limit: _perPage, search: _currentSearch),
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
                    prefixBuilder: (context, style, variants) => Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: const Icon(FIcons.search),
                    ),
                    onSubmit: (value) {
                      setState(() {
                        _currentSearch = value.isEmpty ? null : value;
                        _paginationController?.value = 0;
                      });
                      context.read<TutorBloc>().add(
                        PaginateTutors(
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
                        TutorForm(controller: controller),
                  ),
                  suffix: const Icon(Icons.add),
                  child: const Text('Add Tutor'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tutors list
            Expanded(
              child: BlocBuilder<TutorBloc, TutorState>(
                builder: (context, state) {
                  if (state is TutorLoading) {
                    return const Center(child: FCircularProgress());
                  } else if (state is TutorsLoaded) {
                    return _buildTutorsList(state);
                  } else {
                    return const Center(child: Text('Failed to load tutors'));
                  }
                },
              ),
            ),

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
                        control: .managed(controller: _perPageController),
                        format: (value) => '$value per page',
                        children: [
                          .item(title: const Text('5 per page'), value: 5),
                          .item(title: const Text('10 per page'), value: 10),
                          .item(title: const Text('25 per page'), value: 25),
                          .item(title: const Text('50 per page'), value: 50),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Pagination
                    Expanded(
                      child: FPagination(
                        control: .managed(controller: _paginationController!),
                      ),
                    ),
                  ],
                ),
              ),

            // BlocListener for side effects
            BlocListener<TutorBloc, TutorState>(
              listener: (context, state) {
                if (state is TutorError) {
                  showFToast(
                    context: context,
                    variant: .destructive,
                    icon: Icon(FIcons.circleX),
                    title: Text('Error'),
                    description: Text(state.message),
                  );
                } else if (state is TutorsLoaded) {
                  if (_paginationController == null ||
                      _paginationController!.pages != state.totalPages) {
                    _paginationController?.dispose();
                    _paginationController = FPaginationController(
                      pages: state.totalPages,
                      page: state.currentPage - 1,
                    );
                    _paginationController!.addListener(_onPageChange);
                  } else {
                    _paginationController?.value = state.currentPage - 1;
                  }
                }
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorsList(TutorsLoaded state) {
    final tutors = state.tutors;

    if (tutors.isEmpty) {
      return const Center(child: Text('No tutors found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final tutor = tutors[index];
        return FItem(
          prefix: FAvatar.raw(child: Icon(FIcons.user)),
          title: Text(tutor.name),
          subtitle: Text('${tutor.email} - ${tutor.phone}'),
          suffix: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              FSwitch(
                value: tutor.isActive,
                onChange: (value) {
                  context.read<TutorBloc>().add(
                    UpdateTutor(tutor.id, tutor.copyWith(isActive: value)),
                  );
                },
              ),
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showTutorDetails(tutor),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () => showFPersistentSheet(
                  context: context,
                  style: const .delta(flingVelocity: 700),
                  side: .rtl,
                  builder: (context, controller) =>
                      TutorForm(controller: controller, tutor: tutor),
                ),
              ),
              FButton(
                child: Icon(Icons.delete),
                onPress: () => _deleteTutor(tutor),
              ),
            ],
          ),
        );
      },
      count: tutors.length,
    );
  }

  void _deleteTutor(Tutor tutor) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Tutor'),
        body: Text('Are you sure you want to delete "${tutor.name}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<TutorBloc>().add(DeleteTutor(tutor.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showTutorDetails(Tutor tutor) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => TutorDetailDialog(tutor: tutor),
    );
  }
}
