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
    state.when(
      initial: () {},
      loading: () {},
      error: (_) {},
      loaded: (workouts, categories, difficulties, selectedCategory,
          selectedDifficulty) {
        loadWorkouts(
          category: category == 'All' ? null : category,
          difficulty: selectedDifficulty == 'All' ? null : selectedDifficulty,
        );
      },
    );
  }

  void filterByDifficulty(String? difficulty) {
    state.when(
      initial: () {},
      loading: () {},
      error: (_) {},
      loaded: (workouts, categories, difficulties, selectedCategory,
          selectedDifficulty) {
        loadWorkouts(
          category: selectedCategory == 'All' ? null : selectedCategory,
          difficulty: difficulty == 'All' ? null : difficulty,
        );
      },
    );
  }
}
