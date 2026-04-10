import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'blocs/course_bloc.dart';
import 'blocs/student_bloc.dart';
import 'blocs/tutor_bloc.dart';
import 'pages/home_page.dart';
import 'pages/tutors_page.dart';
import 'pages/students_page.dart';
import 'pages/courses_page.dart';
import 'repositories/course_repository.dart';
import 'repositories/student_repository.dart';
import 'repositories/tutor_repository.dart';
import 'layouts/admin_layout.dart';
import 'theme_provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TutorBloc(TutorRepository())),
          BlocProvider(create: (context) => StudentBloc(StudentRepository())),
          BlocProvider(create: (context) => CourseBloc(CourseRepository())),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) => MaterialApp.router(
            routerConfig: router,
            supportedLocales: FLocalizations.supportedLocales,
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            theme: themeProvider.themeData.toApproximateMaterialTheme(),
            builder: (_, child) => FTheme(
              data: themeProvider.themeData,
              child: FToaster(child: FTooltipGroup(child: child!)),
            ),
          ),
        ),
      ),
    );
  }
}
