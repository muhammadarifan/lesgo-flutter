import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/blocs/theme_bloc.dart';

import 'blocs/course_bloc.dart';
import 'blocs/schedule_bloc.dart';
import 'blocs/student_bloc.dart';
import 'blocs/tutor_bloc.dart';
import 'pages/home_page.dart';
import 'pages/schedules_page.dart';
import 'pages/tutors_page.dart';
import 'pages/students_page.dart';
import 'pages/courses_page.dart';
import 'repositories/course_repository.dart';
import 'repositories/schedule_repository.dart';
import 'repositories/student_repository.dart';
import 'repositories/tutor_repository.dart';
import 'layouts/admin_layout.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  Application({super.key});

  final theme =
      const <TargetPlatform>{
        .android,
        .iOS,
        .fuchsia,
      }.contains(defaultTargetPlatform)
      ? FThemes.neutral.dark.touch
      : FThemes.neutral.dark.desktop;

  // Create the router configuration
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AdminLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tutors',
                builder: (context, state) => const TutorsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/students',
                builder: (context, state) => const StudentsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/courses',
                builder: (context, state) => const CoursesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedules',
                builder: (context, state) => const SchedulesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                builder: (context, state) =>
                    const Center(child: Text('Reports page coming soon...')),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(LoadTheme()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TutorBloc(TutorRepository())),
          BlocProvider(create: (context) => StudentBloc(StudentRepository())),
          BlocProvider(create: (context) => CourseBloc(CourseRepository())),
          BlocProvider(create: (context) => ScheduleBloc(ScheduleRepository())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) => MaterialApp.router(
            routerConfig: router,
            supportedLocales: FLocalizations.supportedLocales,
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            theme: state.themeData?.toApproximateMaterialTheme(),
            builder: (_, child) => FTheme(
              data: state.themeData ?? theme,
              child: FToaster(child: FTooltipGroup(child: child!)),
            ),
          ),
        ),
      ),
    );
  }
}
