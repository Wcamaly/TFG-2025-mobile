import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_workouts_usecase.dart';
import 'workouts_state.dart';
import 'repository_providers.dart';

final workoutsProvider =
    StateNotifierProvider<WorkoutsNotifier, WorkoutsState>((ref) {
  return WorkoutsNotifier(
    getWorkoutsUseCase: ref.watch(getWorkoutsUseCaseProvider),
  );
});

final getWorkoutsUseCaseProvider = Provider<GetWorkoutsUseCase>((ref) {
  return GetWorkoutsUseCase(ref.watch(workoutRepositoryProvider));
});

class WorkoutsNotifier extends StateNotifier<WorkoutsState> {
  final GetWorkoutsUseCase getWorkoutsUseCase;

  WorkoutsNotifier({
    required this.getWorkoutsUseCase,
  }) : super(const WorkoutsState.initial());

  Future<void> loadWorkouts({
    String? category,
    String? difficulty,
  }) async {
    state = const WorkoutsState.loading();

    final result = await getWorkoutsUseCase(
      GetWorkoutsParams(
        category: category,
        difficulty: difficulty,
      ),
    );

    state = result.fold(
      (failure) => WorkoutsState.error(failure.message),
      (workouts) => WorkoutsState.loaded(
        workouts: workouts,
        categories: const ['All', 'Strength', 'Cardio', 'Yoga', 'HIIT'],
        difficulties: const ['All', 'Beginner', 'Intermediate', 'Advanced'],
        selectedCategory: category,
        selectedDifficulty: difficulty,
      ),
    );
  }

  void filterByCategory(String? category) {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;
    loadWorkouts(
      category: category == 'All' ? null : category,
      difficulty: currentState.selectedDifficulty == 'All'
          ? null
          : currentState.selectedDifficulty,
    );
  }

  void filterByDifficulty(String? difficulty) {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;
    loadWorkouts(
      category: currentState.selectedCategory == 'All'
          ? null
          : currentState.selectedCategory,
      difficulty: difficulty == 'All' ? null : difficulty,
    );
  }
}
