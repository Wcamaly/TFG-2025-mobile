import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_daily_meal_plan_usecase.dart';
import 'repository_providers.dart';

final mealScheduleProvider =
    StateNotifierProvider<MealScheduleNotifier, AsyncValue<DailyMealPlan>>(
        (ref) {
  return MealScheduleNotifier(
    getDailyMealPlanUseCase: ref.watch(getDailyMealPlanUseCaseProvider),
  );
});

class MealScheduleNotifier extends StateNotifier<AsyncValue<DailyMealPlan>> {
  final GetDailyMealPlanUseCase getDailyMealPlanUseCase;

  MealScheduleNotifier({
    required this.getDailyMealPlanUseCase,
  }) : super(const AsyncValue.loading());

  Future<void> loadSchedule(DateTime date) async {
    state = const AsyncValue.loading();
    final result = await getDailyMealPlanUseCase(date);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (mealPlan) => AsyncValue.data(mealPlan),
    );
  }

  Future<void> removeMeal({
    required String mealId,
    required DateTime date,
    required String time,
  }) async {
    // TODO: Implement remove meal
  }

  Future<void> updateMealTime({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  }) async {
    // TODO: Implement update meal time
  }

  Future<void> reorderMeals({
    required int oldIndex,
    required int newIndex,
    required DateTime date,
  }) async {
    // TODO: Implement reorder meals
  }
}
