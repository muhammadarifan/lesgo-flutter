import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/blocs/theme_bloc.dart';
import 'package:lesgo_flutter/notifiers/pocketbase_auth_notifier.dart';
import 'package:lesgo_flutter/service_locator.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

import 'blocs/auth_bloc.dart';
import 'blocs/course_bloc.dart';
import 'blocs/invoice_bloc.dart';
import 'blocs/payment_bloc.dart';
import 'blocs/schedule_bloc.dart';
import 'blocs/student_bloc.dart';
import 'blocs/tutor_bloc.dart';
import 'pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/schedules_page.dart';
import 'pages/tutors_page.dart';
import 'pages/students_page.dart';
import 'pages/courses_page.dart';
import 'pages/invoices_page.dart';
import 'pages/payments_page.dart';
import 'repositories/auth_repository.dart';
import 'repositories/course_repository.dart';
import 'repositories/invoice_repository.dart';
import 'repositories/payment_repository.dart';
import 'repositories/schedule_repository.dart';
import 'repositories/student_repository.dart';
import 'repositories/tutor_repository.dart';
import 'layouts/admin_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final theme =
      const <TargetPlatform>{
        .android,
        .iOS,
        .fuchsia,
      }.contains(defaultTargetPlatform)
      ? FThemes.neutral.dark.touch
      : FThemes.neutral.dark.desktop;

  final authNotifier = PocketBaseAuthNotifier(getIt<PocketBaseService>().pb);
  late final GoRouter router;

  @override
  void initState() {
    router = GoRouter(
      refreshListenable: authNotifier,
      initialLocation: '/',
      redirect: (context, state) {
        final bool isValid = authNotifier.isAuthenticated;

        final bool isOnAuthPage =
            state.uri.path == '/login' || state.uri.path == '/register';

        // Jika PocketBase tidak valid (token expired/ga ada)
        if (!isValid) {
          // Dan user tidak sedang di hal login/regis, lempar ke login
          return isOnAuthPage ? null : '/login';
        }

        // Jika PocketBase valid tapi user malah di hal login/regis, lempar ke dashboard
        if (isValid && isOnAuthPage) {
          return '/';
        }

        return null; // Tidak ada pengalihan, lanjut ke halaman tujuan
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (context) => AuthBloc(getIt<AuthRepository>()),
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
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
                  path: '/invoices',
                  builder: (context, state) => const InvoicesPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/payments',
                  builder: (context, state) => const PaymentsPage(),
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
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const DashboardPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(LoadTheme()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(getIt<AuthRepository>())..add(CheckAuthStatus()),
          ),
          BlocProvider(
            create: (context) => TutorBloc(getIt<TutorRepository>()),
          ),
          BlocProvider(
            create: (context) => StudentBloc(getIt<StudentRepository>()),
          ),
          BlocProvider(
            create: (context) => CourseBloc(getIt<CourseRepository>()),
          ),
          BlocProvider(
            create: (context) => ScheduleBloc(getIt<ScheduleRepository>()),
          ),
          BlocProvider(
            create: (context) => InvoiceBloc(getIt<InvoiceRepository>()),
          ),
          BlocProvider(
            create: (context) => PaymentBloc(getIt<PaymentRepository>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => MaterialApp.router(
            routerConfig: router,
            supportedLocales: FLocalizations.supportedLocales,
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            builder: (_, child) => FTheme(
              data: themeState.themeData ?? theme,
              child: FToaster(child: FTooltipGroup(child: child!)),
            ),
          ),
        ),
      ),
    );
  }
}
