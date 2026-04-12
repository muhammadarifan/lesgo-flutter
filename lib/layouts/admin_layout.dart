import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/blocs/theme_bloc.dart';
import 'package:lesgo_flutter/blocs/course_bloc.dart';
import 'package:lesgo_flutter/blocs/schedule_bloc.dart';
import 'package:lesgo_flutter/blocs/tutor_bloc.dart';
import 'package:lesgo_flutter/blocs/student_bloc.dart';
import 'package:lesgo_flutter/blocs/payment_bloc.dart';
import 'package:lesgo_flutter/blocs/invoice_bloc.dart';

class AdminLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AdminLayout({super.key, required this.navigationShell});

  String _getTitleFromRoute(String path) {
    switch (path) {
      case '/dashboard':
        return 'Dashboard';
      case '/tutors':
        return 'Tutors Management';
      case '/students':
        return 'Students Management';
      case '/courses':
        return 'Courses Management';
      case '/schedules':
        return 'Schedules Management';
      case '/invoices':
        return 'Invoices Management';
      case '/payments':
        return 'Payments Management';
      case '/reports':
        return 'Reports';
      default:
        return 'Admin Panel';
    }
  }

  void _refreshCurrentPage(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    switch (currentRoute) {
      case '/dashboard':
        context.read<TutorBloc>().add(LoadTutorCount());
        context.read<StudentBloc>().add(LoadStudentCount());
        context.read<CourseBloc>().add(LoadCourseCount());
        context.read<ScheduleBloc>().add(LoadScheduleCount());
        context.read<PaymentBloc>().add(LoadPaymentCount());
        context.read<InvoiceBloc>().add(LoadInvoiceCount());
        break;
      case '/courses':
        context.read<CourseBloc>().add(LoadCourses());
        break;
      case '/schedules':
        context.read<ScheduleBloc>().add(LoadSchedules());
        context.read<CourseBloc>().add(LoadCourses());
        context.read<TutorBloc>().add(LoadTutors());
        context.read<StudentBloc>().add(LoadStudents());
        break;
      case '/tutors':
        context.read<TutorBloc>().add(LoadTutors());
        break;
      case '/students':
        context.read<StudentBloc>().add(LoadStudents());
        break;
      case '/invoices':
        context.read<InvoiceBloc>().add(LoadInvoices());
        break;
      case '/payments':
        context.read<PaymentBloc>().add(LoadPayments());
        break;
      case '/reports':
        // No refresh needed
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final title = _getTitleFromRoute(currentRoute);
    return FScaffold(
      child: Row(
        children: [
          // Sidebar
          SizedBox(
            width: 250,
            child: Container(
              decoration: BoxDecoration(color: context.theme.colors.card),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const .all(16),
                    child: Text(
                      'Admin Panel',
                      style: context.theme.typography.xl.copyWith(
                        color: context.theme.colors.foreground,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  // Navigation items
                  Expanded(
                    child: FItemGroup(
                      children: [
                        FItem(
                          prefix: Icon(
                            Icons.dashboard,
                            color: currentRoute == '/dashboard'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Dashboard'),
                          selected: currentRoute == '/dashboard',
                          onPress: () => currentRoute != '/dashboard'
                              ? navigationShell.goBranch(7)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.school,
                            color: currentRoute == '/tutors'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Tutors'),
                          selected: currentRoute == '/tutors',
                          onPress: () => currentRoute != '/tutors'
                              ? navigationShell.goBranch(0)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.people,
                            color: currentRoute == '/students'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Students'),
                          selected: currentRoute == '/students',
                          onPress: () => currentRoute != '/students'
                              ? navigationShell.goBranch(1)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.book,
                            color: currentRoute == '/courses'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Courses'),
                          selected: currentRoute == '/courses',
                          onPress: () => currentRoute != '/courses'
                              ? navigationShell.goBranch(2)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.schedule,
                            color: currentRoute == '/schedules'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Schedules'),
                          selected: currentRoute == '/schedules',
                          onPress: () => currentRoute != '/schedules'
                              ? navigationShell.goBranch(3)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.receipt_long,
                            color: currentRoute == '/invoices'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Invoices'),
                          selected: currentRoute == '/invoices',
                          onPress: () => currentRoute != '/invoices'
                              ? navigationShell.goBranch(4)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.payment,
                            color: currentRoute == '/payments'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Payments'),
                          selected: currentRoute == '/payments',
                          onPress: () => currentRoute != '/payments'
                              ? navigationShell.goBranch(5)
                              : null,
                        ),
                        FItem(
                          prefix: Icon(
                            Icons.bar_chart,
                            color: currentRoute == '/reports'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Reports'),
                          selected: currentRoute == '/reports',
                          onPress: () => currentRoute != '/reports'
                              ? navigationShell.goBranch(6)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              color: context.theme.colors.background,
              child: Column(
                children: [
                  // Top bar
                  Container(
                    padding: const .all(16),
                    decoration: BoxDecoration(
                      color: context.theme.colors.background,
                      border: Border(
                        bottom: BorderSide(
                          color: context.theme.colors.border,
                          width: context.theme.style.borderWidth,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: context.theme.typography.xl.copyWith(
                              color: context.theme.colors.foreground,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                        FTooltip(
                          tipBuilder: (context, controller) => Text('Refresh'),
                          child: FButton(
                            onPress: () => _refreshCurrentPage(context),
                            child: Icon(FIcons.refreshCw),
                          ),
                        ),
                        const SizedBox(width: 8),
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) => FTooltip(
                            tipBuilder: (context, controller) => Text(
                              state.isDark
                                  ? 'Switch to light mode'
                                  : 'Switch to dark mode',
                            ),
                            child: FButton(
                              onPress: () =>
                                  context.read<ThemeBloc>().add(ToggleTheme()),
                              child: Icon(
                                state.isDark ? FIcons.sun : FIcons.moon,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(child: navigationShell),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
