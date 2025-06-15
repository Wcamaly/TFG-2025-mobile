import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_meal_by_id_usecase.dart';
import 'repository_providers.dart';

final mealDetailProvider =
    StateNotifierProvider.family<MealDetailNotifier, AsyncValue<Meal>, String>(
        (ref, id) {
  return MealDetailNotifier(
    getMealByIdUseCase: ref.watch(getMealByIdUseCaseProvider),
    id: id,
  );
});

final getMealByIdUseCaseProvider = Provider<GetMealByIdUseCase>((ref) {
  return GetMealByIdUseCase(ref.watch(nutritionRepositoryProvider));
});

class MealDetailNotifier extends StateNotifier<AsyncValue<Meal>> {
  final GetMealByIdUseCase getMealByIdUseCase;
  final String id;

  MealDetailNotifier({
    required this.getMealByIdUseCase,
    required this.id,
  }) : super(const AsyncValue.loading()) {
    loadMeal();
  }

  Future<void> loadMeal() async {
    state = const AsyncValue.loading();
    final result = await getMealByIdUseCase(id);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (meal) => AsyncValue.data(meal),
    );
  }

  Future<void> refresh() => loadMeal();
}
