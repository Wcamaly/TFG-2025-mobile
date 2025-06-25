import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';

abstract class NutritionRepository {
  Future<Either<Failure, List<Meal>>> getMeals({
    String? category,
    String? difficulty,
  });

  Future<Either<Failure, Meal>> getMealById(String id);

  Future<Either<Failure, List<String>>> getCategories();

  Future<Either<Failure, DailyMealPlan>> getDailyMealPlan(DateTime date);

  Future<Either<Failure, NutritionGoals>> getNutritionGoals();

  Future<Either<Failure, void>> updateNutritionGoals(NutritionGoals goals);

  Future<Either<Failure, void>> toggleFavoriteMeal(String id);

  Future<Either<Failure, void>> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  });

  Future<Either<Failure, void>> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  });

  Future<Either<Failure, List<Food>>> searchFoods(String query);

  Future<Either<Failure, Food>> getFoodById(String id);

  Future<Either<Failure, FoodAnalytics>> analyzeFoodQuantity({
    required String foodId,
    required double quantity,
  });

  Future<Either<Failure, List<Food>>> getFoodsByCategory(String category);

  Future<Either<Failure, List<String>>> getFoodCategories();

  Future<Either<Failure, UserProfile>> getUserProfile();

  Future<Either<Failure, void>> updateUserProfile(UserProfile profile);

  Future<Either<Failure, BMIData>> calculateBMI({
    required double weight,
    required double height,
  });

  Future<Either<Failure, CalorieCalculation>> calculateCalories({
    required UserProfile profile,
  });

  Future<Either<Failure, NutritionStats>> getDailyNutritionStats(DateTime date);

  Future<Either<Failure, WeeklyNutritionSummary>> getWeeklyNutritionSummary({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Either<Failure, void>> addFoodEntry(FoodEntry entry);

  Future<Either<Failure, void>> removeFoodEntry(String entryId);

  Future<Either<Failure, void>> updateFoodEntry(FoodEntry entry);

  Future<Either<Failure, void>> updateWaterIntake({
    required DateTime date,
    required double waterIntake,
  });

  Future<Either<Failure, List<FoodAnalytics>>> compareFoods({
    required List<String> foodIds,
    required double quantity,
  });

  Future<Either<Failure, List<Food>>> getRecommendedFoods({
    required UserProfile profile,
    required String mealType,
  });
}
