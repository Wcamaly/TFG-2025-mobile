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
}
