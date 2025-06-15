import '../../domain/entities/meal.dart';

abstract class NutritionRemoteDataSource {
  Future<List<Meal>> getMeals({
    String? category,
    String? difficulty,
  });

  Future<Meal> getMealById(String id);

  Future<List<String>> getCategories();

  Future<DailyMealPlan> getDailyMealPlan(DateTime date);

  Future<NutritionGoals> getNutritionGoals();

  Future<void> updateNutritionGoals(NutritionGoals goals);

  Future<void> toggleFavoriteMeal(String id);

  Future<void> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  });

  Future<void> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  });
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  // Aquí iría la implementación con tu servicio de backend real
  // Por ejemplo, una API REST, Firebase, etc.

  @override
  Future<List<Meal>> getMeals({
    String? category,
    String? difficulty,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<Meal> getMealById(String id) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getCategories() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<DailyMealPlan> getDailyMealPlan(DateTime date) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<NutritionGoals> getNutritionGoals() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> updateNutritionGoals(NutritionGoals goals) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavoriteMeal(String id) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }
}
