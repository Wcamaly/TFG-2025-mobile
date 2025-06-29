import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/datasources/dashboard_routines_data_source.dart';
import '../../data/repositories/dashboard_routines_repository_impl.dart';
import '../../domain/repositories/dashboard_routines_repository.dart';
import '../../domain/usecases/get_todays_routines_usecase.dart';
import '../../../../core/di/injection_container.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

// Providers para la inyección de dependencias siguiendo Clean Architecture

// Data Source Provider
final dashboardRoutinesDataSourceProvider =
    Provider<DashboardRoutinesDataSource>(
  (ref) => DashboardRoutinesDataSourceImpl(sl<AppDatabase>()),
);

// Repository Provider
final dashboardRoutinesRepositoryProvider =
    Provider<DashboardRoutinesRepository>(
  (ref) => DashboardRoutinesRepositoryImpl(
    ref.watch(dashboardRoutinesDataSourceProvider),
  ),
);

// Use Case Provider
final getTodaysRoutinesUseCaseProvider = Provider<GetTodaysRoutinesUseCase>(
  (ref) => GetTodaysRoutinesUseCase(
    ref.watch(dashboardRoutinesRepositoryProvider),
  ),
);

// Estado para las rutinas del dashboard
class DashboardRoutinesState {
  final List<DbRoutine> routines;
  final bool isLoading;
  final String? error;

  const DashboardRoutinesState({
    this.routines = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardRoutinesState copyWith({
    List<DbRoutine>? routines,
    bool? isLoading,
    String? error,
  }) {
    return DashboardRoutinesState(
      routines: routines ?? this.routines,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Provider para gestionar las rutinas del dashboard
class DashboardRoutinesNotifier extends StateNotifier<DashboardRoutinesState> {
  final GetTodaysRoutinesUseCase _getTodaysRoutinesUseCase;

  DashboardRoutinesNotifier(this._getTodaysRoutinesUseCase)
      : super(const DashboardRoutinesState());

  Future<void> loadTodaysRoutines(int userId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final routines = await _getTodaysRoutinesUseCase.execute(userId);
      state = state.copyWith(
        routines: routines,
        isLoading: false,
      );
      print('✅ Loaded ${routines.length} today\'s routines for user $userId');
    } catch (e) {
      print('❌ Error loading today\'s routines: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearRoutines() {
    state = const DashboardRoutinesState();
  }
}

// Provider principal para las rutinas del dashboard
final dashboardRoutinesProvider =
    StateNotifierProvider<DashboardRoutinesNotifier, DashboardRoutinesState>(
        (ref) {
  final useCase = ref.watch(getTodaysRoutinesUseCaseProvider);
  return DashboardRoutinesNotifier(useCase);
});

// Provider que carga automáticamente las rutinas del usuario autenticado
final todaysRoutinesProvider = FutureProvider<List<DbRoutine>>((ref) async {
  print('🔄 todaysRoutinesProvider: Starting to load routines');

  final authState = ref.watch(authProvider);

  return authState.when(
    initial: () {
      print(
          '🔄 todaysRoutinesProvider: Auth state is initial, returning empty list');
      return [];
    },
    loading: () {
      print(
          '🔄 todaysRoutinesProvider: Auth state is loading, returning empty list');
      return [];
    },
    authenticated: (user) async {
      print('🔄 todaysRoutinesProvider: User authenticated, loading routines');
      print('   User ID: ${user.id}');
      print('   User Email: ${user.email}');

      final userId = int.tryParse(user.id);
      if (userId == null) {
        print(
            '🔄 todaysRoutinesProvider: Invalid user ID, returning empty list');
        return [];
      }

      print('🔄 todaysRoutinesProvider: Getting use case and calling it');
      final useCase = ref.read(getTodaysRoutinesUseCaseProvider);

      try {
        final routines = await useCase.execute(userId);
        print(
            '🔄 todaysRoutinesProvider: Successfully loaded ${routines.length} routines');
        for (int i = 0; i < routines.length; i++) {
          final routine = routines[i];
          print('   Routine $i: ${routine.name} (ID: ${routine.id})');
        }
        return routines;
      } catch (e) {
        print('🔄 todaysRoutinesProvider: Error loading routines: $e');
        rethrow;
      }
    },
    unauthenticated: (message) {
      print(
          '🔄 todaysRoutinesProvider: User unauthenticated: $message, returning empty list');
      return [];
    },
  );
});
