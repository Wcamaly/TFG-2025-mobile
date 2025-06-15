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
}
