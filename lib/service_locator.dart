import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/repositories/auth_repository.dart';
import 'package:lesgo_flutter/repositories/course_repository.dart';
import 'package:lesgo_flutter/repositories/invoice_repository.dart';
import 'package:lesgo_flutter/repositories/payment_repository.dart';
import 'package:lesgo_flutter/repositories/room_repository.dart';
import 'package:lesgo_flutter/repositories/schedule_repository.dart';
import 'package:lesgo_flutter/repositories/student_repository.dart';
import 'package:lesgo_flutter/repositories/tutor_repository.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register PocketBaseService as singleton
  final pbService = PocketBaseService();
  await pbService.init();
  getIt.registerSingleton<PocketBaseService>(pbService);

  // Register repositories as singletons
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerSingleton<TutorRepository>(TutorRepository());
  getIt.registerSingleton<StudentRepository>(StudentRepository());
  getIt.registerSingleton<CourseRepository>(CourseRepository());
  getIt.registerSingleton<RoomRepository>(RoomRepository());
  getIt.registerSingleton<ScheduleRepository>(ScheduleRepository());
  getIt.registerSingleton<InvoiceRepository>(InvoiceRepository());
  getIt.registerSingleton<PaymentRepository>(PaymentRepository());
}
