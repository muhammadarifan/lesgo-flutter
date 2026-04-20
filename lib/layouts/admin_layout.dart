import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/blocs/theme_bloc.dart';
import 'package:lesgo_flutter/blocs/auth_bloc.dart';
import 'package:lesgo_flutter/blocs/course_bloc.dart';
import 'package:lesgo_flutter/blocs/room_bloc.dart';
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
      case '/rooms':
        return 'Rooms Management';
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
        context.read<RoomBloc>().add(LoadRoomCount());
        context.read<ScheduleBloc>().add(LoadScheduleCount());
        context.read<PaymentBloc>().add(LoadPaymentCount());
        context.read<InvoiceBloc>().add(LoadInvoiceCount());
        break;
      case '/courses':
        context.read<CourseBloc>().add(LoadCourses());
        break;
      case '/rooms':
        context.read<RoomBloc>().add(LoadRooms());
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
      sidebar: FSidebar(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Admin Panel',
            style: context.theme.typography.xl.copyWith(
              color: context.theme.colors.foreground,
              fontWeight: .bold,
            ),
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Version 1.0.0',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.foreground,
            ),
          ),
        ),
        children: [
          FSidebarItem(
            icon: const Icon(Icons.dashboard),
            label: const Text('Dashboard'),
            selected: currentRoute == '/dashboard',
            onPress: () => context.go('/dashboard'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.school),
            label: const Text('Tutors'),
            selected: currentRoute == '/tutors',
            onPress: () => context.go('/tutors'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.person),
            label: const Text('Students'),
            selected: currentRoute == '/students',
            onPress: () => context.go('/students'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.book),
            label: const Text('Courses'),
            selected: currentRoute == '/courses',
            onPress: () => context.go('/courses'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.room),
            label: const Text('Rooms'),
            selected: currentRoute == '/rooms',
            onPress: () => context.go('/rooms'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.calendar_month),
            label: const Text('Schedules'),
            selected: currentRoute == '/schedules',
            onPress: () => context.go('/schedules'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.receipt),
            label: const Text('Invoices'),
            selected: currentRoute == '/invoices',
            onPress: () => context.go('/invoices'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.payment),
            label: const Text('Payments'),
            selected: currentRoute == '/payments',
            onPress: () => context.go('/payments'),
          ),
          FSidebarItem(
            icon: const Icon(Icons.bar_chart),
            label: const Text('Reports'),
            selected: currentRoute == '/reports',
            onPress: () => context.go('/reports'),
          ),
        ],
      ),
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
                        child: Icon(state.isDark ? FIcons.sun : FIcons.moon),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FTooltip(
                    tipBuilder: (context, controller) => Text('Logout'),
                    child: FButton(
                      onPress: () => context.read<AuthBloc>().add(Logout()),
                      child: const Icon(Icons.logout),
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
    );
  }
}
