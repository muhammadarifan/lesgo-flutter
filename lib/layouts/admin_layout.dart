import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/blocs/theme_bloc.dart';

class AdminLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AdminLayout({super.key, required this.navigationShell});

  String _getTitleFromRoute(String path) {
    switch (path) {
      case '/tutors':
        return 'Tutors Management';
      case '/students':
        return 'Students Management';
      case '/courses':
        return 'Courses Management';
      case '/schedules':
        return 'Schedules Management';
      case '/reports':
        return 'Reports';
      default:
        return 'Admin Panel';
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
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Admin Panel',
                      style: context.theme.typography.xl.copyWith(
                        color: context.theme.colors.foreground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Navigation items
                  Expanded(
                    child: FItemGroup(
                      children: [
                        FItem(
                          prefix: Icon(
                            Icons.home,
                            color: currentRoute == '/'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Home'),
                          selected: currentRoute == '/',
                          onPress: () =>
                              currentRoute != '/' ? context.go('/') : null,
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
                            Icons.bar_chart,
                            color: currentRoute == '/reports'
                                ? context.theme.colors.primary
                                : null,
                          ),
                          title: const Text('Reports'),
                          selected: currentRoute == '/reports',
                          onPress: () => currentRoute != '/reports'
                              ? navigationShell.goBranch(4)
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
                    padding: const EdgeInsets.all(16),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                                state.isDark
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
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
