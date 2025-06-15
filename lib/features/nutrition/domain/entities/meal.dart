import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
    required List<String> ingredients,
    required List<String> instructions,
    required String category,
    required int preparationTime,
    required String difficulty,
    required bool isFavorite,
  }) = _Meal;
}

@freezed
class DailyMealPlan with _$DailyMealPlan {
  const factory DailyMealPlan({
    required DateTime date,
    required List<MealSchedule> meals,
    required int totalCalories,
    required double totalProtein,
    required double totalCarbs,
    required double totalFats,
  }) = _DailyMealPlan;
}

@freezed
class MealSchedule with _$MealSchedule {
  const factory MealSchedule({
    required String mealId,
    required String name,
    required String time,
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
    required bool isCompleted,
  }) = _MealSchedule;
}

@freezed
class NutritionGoals with _$NutritionGoals {
  const factory NutritionGoals({
    required int dailyCalories,
    required double dailyProtein,
    required double dailyCarbs,
    required double dailyFats,
    required int mealsPerDay,
    required List<String> dietaryRestrictions,
  }) = _NutritionGoals;
}
