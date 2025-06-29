import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection_container.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/usecases/get_dashboard_stats_usecase.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/datasources/dashboard_local_data_source.dart';

// Provider para el repository
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final database = sl<AppDatabase>();
  final dataSource = DashboardLocalDataSourceImpl(database);
  return DashboardRepositoryImpl(dataSource);
});

// Provider para el use case
final getDashboardStatsUseCaseProvider =
    Provider<GetDashboardStatsUseCase>((ref) {
  final repository = ref.read(dashboardRepositoryProvider);
  return GetDashboardStatsUseCase(repository);
});

class TrainerDashboardNotifier
    extends StateNotifier<AsyncValue<DashboardStats>> {
  final GetDashboardStatsUseCase _getDashboardStatsUseCase;
  final Ref _ref;

  TrainerDashboardNotifier(this._getDashboardStatsUseCase, this._ref)
      : super(const AsyncValue.loading());

  // Obtener el ID del entrenador autenticado
  int? get _currentTrainerId {
    final authState = _ref.read(authProvider);
    return authState.when(
      initial: () => null,
      loading: () => null,
      authenticated: (user) => int.tryParse(user.id),
      unauthenticated: (_) => null,
    );
  }

  Future<void> loadDashboardStats([int? trainerId]) async {
    try {
      state = const AsyncValue.loading();

      // Usar el trainerId pasado o el del usuario autenticado
      final effectiveTrainerId = trainerId ?? _currentTrainerId;

      if (effectiveTrainerId == null) {
        state = AsyncValue.error(
          'No se pudo obtener el ID del entrenador. Usuario no autenticado.',
          StackTrace.current,
        );
        return;
      }

      print('📊 Loading dashboard stats for trainer $effectiveTrainerId');

      final stats = await _getDashboardStatsUseCase.call(effectiveTrainerId);

      print('✅ Dashboard stats loaded successfully:');
      print('   - Total students: ${stats.totalStudents}');
      print('   - Active students: ${stats.activeStudents}');
      print('   - Total routines: ${stats.totalRoutines}');
      print('   - Monthly income: €${stats.monthlyIncome.toStringAsFixed(2)}');
      print('   - Recent students: ${stats.recentStudents.length}');
      print('   - Top routines: ${stats.topRoutines.length}');

      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      print('❌ Error loading dashboard stats: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh([int? trainerId]) async {
    await loadDashboardStats(trainerId);
  }

  // Método para cargar automáticamente al inicializar
  Future<void> initialize() async {
    await loadDashboardStats();
  }
}

final trainerDashboardProvider =
    StateNotifierProvider<TrainerDashboardNotifier, AsyncValue<DashboardStats>>(
        (ref) {
  final getDashboardStatsUseCase = ref.read(getDashboardStatsUseCaseProvider);
  return TrainerDashboardNotifier(getDashboardStatsUseCase, ref);
});
