import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal.dart';

part 'nutrition_state.freezed.dart';

@freezed
class NutritionState with _$NutritionState {
  const factory NutritionState.initial() = _Initial;
  const factory NutritionState.loading() = _Loading;
  const factory NutritionState.loaded({
    required DailyMealPlan mealPlan,
    required NutritionGoals goals,
    required List<String> categories,
    String? selectedCategory,
  }) = _Loaded;
  const factory NutritionState.error(String message) = _Error;
}
