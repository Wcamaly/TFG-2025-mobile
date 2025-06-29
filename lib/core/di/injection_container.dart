import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:tfg_2025_mobile/core/network/http_service.dart';
import 'package:tfg_2025_mobile/core/network/dio_http_service.dart';
import 'package:tfg_2025_mobile/firebase_options.dart';
import '../database/app_database.dart';
import '../../features/authentication/data/datasources/auth_local_data_source.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/trainer_dashboard/data/datasources/dashboard_local_data_source.dart';
import '../../features/trainer_dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/trainer_dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/trainer_dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import '../../features/trainer_routines/data/datasources/routines_local_data_source.dart';
import '../../features/trainer_routines/data/repositories/routines_repository_impl.dart';
import '../../features/trainer_routines/domain/repositories/routines_repository.dart';
import '../../features/trainer_routines/domain/usecases/get_routines_usecase.dart';
import '../../features/trainer_routines/domain/usecases/assign_routine_usecase.dart';
import '../../features/trainer_routines/domain/usecases/get_student_assigned_routines_usecase.dart';
import '../../features/dashboard/data/datasources/dashboard_routines_data_source.dart';
import '../../features/workouts/data/services/workout_session_service.dart';
import '../../features/trainer_products/data/datasources/trainer_products_local_data_source.dart';
import '../../features/trainer_products/data/repositories/trainer_products_repository_impl.dart';
import '../../features/trainer_products/domain/repositories/trainer_products_repository.dart';
import '../../features/trainer_products/domain/usecases/get_trainer_products_usecase.dart';
import '../../features/trainer_products/domain/usecases/create_trainer_product_usecase.dart';
import '../../features/trainer_products/domain/usecases/update_trainer_product_usecase.dart';
import '../../features/trainer_products/domain/usecases/delete_trainer_product_usecase.dart';
import '../../features/trainer_products/domain/usecases/toggle_product_status_usecase.dart';
import '../../features/trainer_students/data/datasources/students_local_data_source.dart';
import '../../features/trainer_students/data/repositories/students_repository_impl.dart';
import '../../features/trainer_students/domain/repositories/students_repository.dart';
import '../../features/trainer_students/domain/usecases/associate_student_with_trainer_usecase.dart';
import '../../features/subscriptions/domain/usecases/process_subscription_payment_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Core - Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Core - Crashlytics
  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Core - Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Core - Network
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<HttpService>(() => DioHttpService(
        baseUrl: 'https://api.gymnestic.com', // TODO: Move to config
      ));

  // Features - Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RoutinesLocalDataSource>(
    () => RoutinesLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<TrainerProductsLocalDataSource>(
    () => TrainerProductsLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<StudentsLocalDataSource>(
    () => StudentsLocalDataSourceImpl(sl()),
  );

  // Features - Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RoutinesRepository>(
    () => RoutinesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TrainerProductsRepository>(
    () => TrainerProductsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<StudentsRepository>(
    () => StudentsRepositoryImpl(sl()),
  );

  // Features - Use Cases
  sl.registerLazySingleton<GetDashboardStatsUseCase>(
    () => GetDashboardStatsUseCase(sl()),
  );
  sl.registerLazySingleton<GetRoutinesUseCase>(
    () => GetRoutinesUseCase(sl()),
  );
  // TODO: Uncomment when these use cases are created
  // sl.registerLazySingleton<CreateRoutineUseCase>(
  //   () => CreateRoutineUseCase(sl()),
  // );
  // sl.registerLazySingleton<UpdateRoutineUseCase>(
  //   () => UpdateRoutineUseCase(sl()),
  // );
  // sl.registerLazySingleton<DeleteRoutineUseCase>(
  //   () => DeleteRoutineUseCase(sl()),
  // );
  // sl.registerLazySingleton<SearchRoutinesUseCase>(
  //   () => SearchRoutinesUseCase(sl()),
  // );
  // sl.registerLazySingleton<DuplicateRoutineUseCase>(
  //   () => DuplicateRoutineUseCase(sl()),
  // );
  sl.registerLazySingleton<AssignRoutineUseCase>(
    () => AssignRoutineUseCase(sl()),
  );
  sl.registerLazySingleton<GetStudentAssignedRoutinesUseCase>(
    () => GetStudentAssignedRoutinesUseCase(sl()),
  );

  // Trainer Products Use Cases
  sl.registerLazySingleton<GetTrainerProductsUseCase>(
    () => GetTrainerProductsUseCase(sl()),
  );
  sl.registerLazySingleton<CreateTrainerProductUseCase>(
    () => CreateTrainerProductUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateTrainerProductUseCase>(
    () => UpdateTrainerProductUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteTrainerProductUseCase>(
    () => DeleteTrainerProductUseCase(sl()),
  );
  sl.registerLazySingleton<ToggleProductStatusUseCase>(
    () => ToggleProductStatusUseCase(sl()),
  );

  // Student Association Use Cases
  sl.registerLazySingleton<AssociateStudentWithTrainerUseCase>(
    () => AssociateStudentWithTrainerUseCase(sl()),
  );
  sl.registerLazySingleton<ProcessSubscriptionPaymentUseCase>(
    () => ProcessSubscriptionPaymentUseCase(sl()),
  );

  // Features - Controllers/ViewModels

  // Dashboard Routines
  sl.registerLazySingleton<DashboardRoutinesDataSource>(
    () => DashboardRoutinesDataSourceImpl(sl<AppDatabase>()),
  );

  // Workout Session Service
  sl.registerLazySingleton<WorkoutSessionService>(
    () => WorkoutSessionService(sl<AppDatabase>()),
  );
}
