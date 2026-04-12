import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tutor_bloc.dart';
import '../blocs/student_bloc.dart';
import '../blocs/course_bloc.dart';
import '../blocs/schedule_bloc.dart';
import '../blocs/payment_bloc.dart';
import '../blocs/invoice_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<TutorBloc>().add(LoadTutorCount());
    context.read<StudentBloc>().add(LoadStudentCount());
    context.read<CourseBloc>().add(LoadCourseCount());
    context.read<ScheduleBloc>().add(LoadScheduleCount());
    context.read<PaymentBloc>().add(LoadPaymentCount());
    context.read<InvoiceBloc>().add(LoadInvoiceCount());
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    context: context,
                    title: 'Tutors',
                    icon: Icons.school,
                    bloc: BlocBuilder<TutorBloc, TutorState>(
                      builder: (context, state) {
                        final count = state is TutorCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Students',
                    icon: Icons.people,
                    bloc: BlocBuilder<StudentBloc, StudentState>(
                      builder: (context, state) {
                        final count = state is StudentCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Courses',
                    icon: Icons.book,
                    bloc: BlocBuilder<CourseBloc, CourseState>(
                      builder: (context, state) {
                        final count = state is CourseCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Schedules',
                    icon: Icons.schedule,
                    bloc: BlocBuilder<ScheduleBloc, ScheduleState>(
                      builder: (context, state) {
                        final count = state is ScheduleCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Payments',
                    icon: Icons.payment,
                    bloc: BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                        final count = state is PaymentCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Invoices',
                    icon: Icons.receipt,
                    bloc: BlocBuilder<InvoiceBloc, InvoiceState>(
                      builder: (context, state) {
                        final count = state is InvoiceCountLoaded
                            ? state.count
                            : 0;
                        return Text(
                          '$count',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget bloc,
  }) {
    return FCard(
      child: Padding(
        padding: const .all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: context.theme.colors.primary),
            const SizedBox(height: 8),
            Text(
              title,
              style: context.theme.typography.lg.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            bloc,
          ],
        ),
      ),
    );
  }
}
