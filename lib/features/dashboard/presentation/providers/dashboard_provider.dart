import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_2025_mobile/features/dashboard/presentation/providers/repository_providers.dart';
import 'package:tfg_2025_mobile/features/dashboard/domain/usecases/get_current_stats_usecase.dart';
import 'dashboard_state.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(
    getCurrentStatsUseCase: ref.watch(getCurrentStatsUseCaseProvider),
  );
});

final getCurrentStatsUseCaseProvider = Provider<GetCurrentStatsUseCase>((ref) {
  return GetCurrentStatsUseCase(ref.watch(statsRepositoryProvider));
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  final GetCurrentStatsUseCase getCurrentStatsUseCase;

  DashboardNotifier({
    required this.getCurrentStatsUseCase,
  }) : super(const DashboardState.initial());

  Future<void> loadStats() async {
    state = const DashboardState.loading();

    final result = await getCurrentStatsUseCase();

    state = result.fold(
      (failure) => DashboardState.error(failure.message),
      (stats) => DashboardState.loaded(stats),
    );
  }
}
