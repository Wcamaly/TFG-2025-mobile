import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/meal.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_remote_data_source.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource remoteDataSource;

  NutritionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Meal>>> getMeals({
    String? category,
    String? difficulty,
  }) async {
    try {
      final meals = await remoteDataSource.getMeals(
        category: category,
        difficulty: difficulty,
      );
      return Right(meals);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Meal>> getMealById(String id) async {
    try {
      final meal = await remoteDataSource.getMealById(id);
      return Right(meal);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyMealPlan>> getDailyMealPlan(DateTime date) async {
    try {
      final mealPlan = await remoteDataSource.getDailyMealPlan(date);
      return Right(mealPlan);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NutritionGoals>> getNutritionGoals() async {
    try {
      final goals = await remoteDataSource.getNutritionGoals();
      return Right(goals);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNutritionGoals(
      NutritionGoals goals) async {
    try {
      await remoteDataSource.updateNutritionGoals(goals);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavoriteMeal(String id) async {
    try {
      await remoteDataSource.toggleFavoriteMeal(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  }) async {
    try {
      await remoteDataSource.markMealAsCompleted(
        mealId: mealId,
        date: date,
        time: time,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  }) async {
    try {
      await remoteDataSource.updateMealSchedule(
        mealId: mealId,
        date: date,
        oldTime: oldTime,
        newTime: newTime,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Food>>> searchFoods(String query) async {
    try {
      final foods = await remoteDataSource.searchFoods(query);
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Food>> getFoodById(String id) async {
    try {
      final food = await remoteDataSource.getFoodById(id);
      return Right(food);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FoodAnalytics>> analyzeFoodQuantity({
    required String foodId,
    required double quantity,
  }) async {
    try {
      final analytics = await remoteDataSource.analyzeFoodQuantity(
        foodId: foodId,
        quantity: quantity,
      );
      return Right(analytics);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Food>>> getFoodsByCategory(
      String category) async {
    try {
      final foods = await remoteDataSource.getFoodsByCategory(category);
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFoodCategories() async {
    try {
      final categories = await remoteDataSource.getFoodCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final profile = await remoteDataSource.getUserProfile();
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(UserProfile profile) async {
    try {
      await remoteDataSource.updateUserProfile(profile);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BMIData>> calculateBMI({
    required double weight,
    required double height,
  }) async {
    try {
      final bmiData = await remoteDataSource.calculateBMI(
        weight: weight,
        height: height,
      );
      return Right(bmiData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalorieCalculation>> calculateCalories({
    required UserProfile profile,
  }) async {
    try {
      final calculation = await remoteDataSource.calculateCalories(
        profile: profile,
      );
      return Right(calculation);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NutritionStats>> getDailyNutritionStats(
      DateTime date) async {
    try {
      final stats = await remoteDataSource.getDailyNutritionStats(date);
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WeeklyNutritionSummary>> getWeeklyNutritionSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final summary = await remoteDataSource.getWeeklyNutritionSummary(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(summary);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFoodEntry(FoodEntry entry) async {
    try {
      await remoteDataSource.addFoodEntry(entry);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFoodEntry(String entryId) async {
    try {
      await remoteDataSource.removeFoodEntry(entryId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFoodEntry(FoodEntry entry) async {
    try {
      await remoteDataSource.updateFoodEntry(entry);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWaterIntake({
    required DateTime date,
    required double waterIntake,
  }) async {
    try {
      await remoteDataSource.updateWaterIntake(
        date: date,
        waterIntake: waterIntake,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodAnalytics>>> compareFoods({
    required List<String> foodIds,
    required double quantity,
  }) async {
    try {
      final analytics = await remoteDataSource.compareFoods(
        foodIds: foodIds,
        quantity: quantity,
      );
      return Right(analytics);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Food>>> getRecommendedFoods({
    required UserProfile profile,
    required String mealType,
  }) async {
    try {
      final foods = await remoteDataSource.getRecommendedFoods(
        profile: profile,
        mealType: mealType,
      );
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
