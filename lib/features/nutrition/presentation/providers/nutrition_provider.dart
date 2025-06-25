import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_daily_meal_plan_usecase.dart';
import '../../domain/usecases/get_nutrition_goals_usecase.dart';
import 'nutrition_state.dart';
import 'repository_providers.dart';

final nutritionProvider =
    StateNotifierProvider<NutritionNotifier, NutritionState>((ref) {
  return NutritionNotifier(
    getDailyMealPlanUseCase: ref.watch(getDailyMealPlanUseCaseProvider),
    getNutritionGoalsUseCase: ref.watch(getNutritionGoalsUseCaseProvider),
  );
});

final getDailyMealPlanUseCaseProvider =
    Provider<GetDailyMealPlanUseCase>((ref) {
  return GetDailyMealPlanUseCase(ref.watch(nutritionRepositoryProvider));
});

final getNutritionGoalsUseCaseProvider =
    Provider<GetNutritionGoalsUseCase>((ref) {
  return GetNutritionGoalsUseCase(ref.watch(nutritionRepositoryProvider));
});

class NutritionNotifier extends StateNotifier<NutritionState> {
  final GetDailyMealPlanUseCase getDailyMealPlanUseCase;
  final GetNutritionGoalsUseCase getNutritionGoalsUseCase;

  NutritionNotifier({
    required this.getDailyMealPlanUseCase,
    required this.getNutritionGoalsUseCase,
  }) : super(const NutritionState.initial());

  Future<void> loadNutritionData(DateTime date) async {
    state = const NutritionState.loading();

    final mealPlanResult = await getDailyMealPlanUseCase(date);
    final goalsResult = await getNutritionGoalsUseCase();

    state = mealPlanResult.fold(
      (failure) => NutritionState.error(failure.message),
      (mealPlan) => goalsResult.fold(
        (failure) => NutritionState.error(failure.message),
        (goals) => NutritionState.loaded(
          mealPlan: mealPlan,
          goals: goals,
          categories: const ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snacks'],
          selectedCategory: null,
        ),
      ),
    );
  }

  void filterByCategory(String? category) {
    state.when(
      initial: () {},
      loading: () {},
      error: (_) {},
      loaded: (mealPlan, goals, categories, selectedCategory) {
        state = NutritionState.loaded(
          mealPlan: mealPlan,
          goals: goals,
          categories: categories,
          selectedCategory: category == 'All' ? null : category,
        );
      },
    );
  }
}
