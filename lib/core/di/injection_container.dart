import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:tfg_2025_mobile/core/network/http_service.dart';
import 'package:tfg_2025_mobile/core/network/dio_http_service.dart';
import 'package:tfg_2025_mobile/firebase_options.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source_mock.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';

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

  // Core - Network
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<HttpService>(() => DioHttpService(
        baseUrl: 'https://api.gymnestic.com', // TODO: Move to config
      ));

  // Features - Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceMock(),
  );

  // Features - Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Features - Use Cases

  // Features - Controllers/ViewModels
}
