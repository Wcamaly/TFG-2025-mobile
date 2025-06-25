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
class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatsPer100g,
    required double fiberPer100g,
    required double sugarPer100g,
    required List<String> vitamins,
    required List<String> minerals,
    required String category,
    required String quality, // GOOD, BAD, NEUTRAL
    required bool isOrganic,
    required List<String> allergens,
    required String origin,
    required double glycemicIndex,
  }) = _Food;
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    required int age,
    required String gender, // male, female, other
    required double weight, // in kg
    required double height, // in cm
    required String
        activityLevel, // sedentary, light, moderate, active, very_active
    required String
        goal, // lose_weight, maintain_weight, gain_weight, gain_muscle
    required List<String> dietaryRestrictions,
    required List<String> allergies,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;
}

@freezed
class NutritionStats with _$NutritionStats {
  const factory NutritionStats({
    required DateTime date,
    required int totalCaloriesConsumed,
    required double totalProteinConsumed,
    required double totalCarbsConsumed,
    required double totalFatsConsumed,
    required double totalFiberConsumed,
    required double totalSugarConsumed,
    required int totalCaloriesGoal,
    required double totalProteinGoal,
    required double totalCarbsGoal,
    required double totalFatsGoal,
    required List<FoodEntry> foodEntries,
    required double waterIntake, // in liters
    required double waterGoal, // in liters
  }) = _NutritionStats;
}

@freezed
class FoodEntry with _$FoodEntry {
  const factory FoodEntry({
    required String id,
    required String foodId,
    required String foodName,
    required String foodImageUrl,
    required double quantity, // in grams
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
    required double fiber,
    required double sugar,
    required String mealType, // breakfast, lunch, dinner, snack
    required DateTime consumedAt,
    required String quality, // GOOD, BAD, NEUTRAL
  }) = _FoodEntry;
}

@freezed
class BMIData with _$BMIData {
  const factory BMIData({
    required double bmi,
    required String category, // underweight, normal, overweight, obese
    required String description,
    required double idealWeightMin,
    required double idealWeightMax,
    required String recommendations,
  }) = _BMIData;
}

@freezed
class CalorieCalculation with _$CalorieCalculation {
  const factory CalorieCalculation({
    required double bmr, // Basal Metabolic Rate
    required double tdee, // Total Daily Energy Expenditure
    required int maintenanceCalories,
    required int weightLossCalories,
    required int weightGainCalories,
    required double proteinGoal,
    required double carbsGoal,
    required double fatsGoal,
    required String methodology, // harris-benedict, mifflin-st-jeor
  }) = _CalorieCalculation;
}

@freezed
class FoodAnalytics with _$FoodAnalytics {
  const factory FoodAnalytics({
    required Food food,
    required double quantity, // in grams
    required int totalCalories,
    required double totalProtein,
    required double totalCarbs,
    required double totalFats,
    required double totalFiber,
    required double totalSugar,
    required List<String> vitamins,
    required List<String> minerals,
    required String qualityRating, // EXCELLENT, GOOD, AVERAGE, POOR
    required String healthImpact,
    required List<String> benefits,
    required List<String> warnings,
  }) = _FoodAnalytics;
}

@freezed
class WeeklyNutritionSummary with _$WeeklyNutritionSummary {
  const factory WeeklyNutritionSummary({
    required DateTime weekStart,
    required DateTime weekEnd,
    required double avgCaloriesPerDay,
    required double avgProteinPerDay,
    required double avgCarbsPerDay,
    required double avgFatsPerDay,
    required double avgFiberPerDay,
    required double avgWaterPerDay,
    required int daysOnTrack,
    required int totalDays,
    required double calorieGoalAchievement, // percentage
    required List<String> topFoodCategories,
    required List<String> improvements,
  }) = _WeeklyNutritionSummary;
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
    required String category,
    required String imageUrl,
    required String description,
    required bool isFavorite,
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
