import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_nutrition_goals_usecase.dart';
import '../../domain/usecases/update_nutrition_goals_usecase.dart';
import 'repository_providers.dart';

final nutritionGoalsProvider =
    StateNotifierProvider<NutritionGoalsNotifier, AsyncValue<NutritionGoals>>(
        (ref) {
  return NutritionGoalsNotifier(
    getNutritionGoalsUseCase: ref.watch(getNutritionGoalsUseCaseProvider),
    updateNutritionGoalsUseCase: ref.watch(updateNutritionGoalsUseCaseProvider),
  );
});

final updateNutritionGoalsUseCaseProvider =
    Provider<UpdateNutritionGoalsUseCase>((ref) {
  return UpdateNutritionGoalsUseCase(ref.watch(nutritionRepositoryProvider));
});

class NutritionGoalsNotifier extends StateNotifier<AsyncValue<NutritionGoals>> {
  final GetNutritionGoalsUseCase getNutritionGoalsUseCase;
  final UpdateNutritionGoalsUseCase updateNutritionGoalsUseCase;

  NutritionGoalsNotifier({
    required this.getNutritionGoalsUseCase,
    required this.updateNutritionGoalsUseCase,
  }) : super(const AsyncValue.loading()) {
    loadGoals();
  }

  Future<void> loadGoals() async {
    state = const AsyncValue.loading();
    final result = await getNutritionGoalsUseCase();
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (goals) => AsyncValue.data(goals),
    );
  }

  Future<void> updateGoals(NutritionGoals goals) async {
    final result = await updateNutritionGoalsUseCase(goals);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => state = AsyncValue.data(goals),
    );
  }
}
