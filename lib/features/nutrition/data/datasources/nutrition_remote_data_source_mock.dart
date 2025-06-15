import '../../domain/entities/meal.dart';
import 'nutrition_remote_data_source.dart';

class NutritionRemoteDataSourceMock implements NutritionRemoteDataSource {
  final _meals = [
    Meal(
      id: '1',
      name: 'Oatmeal with Berries',
      description:
          'A healthy and filling breakfast with oatmeal, mixed berries, and honey.',
      imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf',
      calories: 350,
      protein: 12.0,
      carbs: 45.0,
      fats: 8.0,
      ingredients: [
        '1 cup rolled oats',
        '1 cup mixed berries',
        '1 tablespoon honey',
        '1 cup almond milk',
        '1/4 teaspoon cinnamon',
      ],
      instructions: [
        'Bring almond milk to a boil in a small pot.',
        'Add oats and reduce heat to medium-low.',
        'Cook for 5 minutes, stirring occasionally.',
        'Remove from heat and let stand for 2 minutes.',
        'Top with berries, honey, and cinnamon.',
      ],
      category: 'Breakfast',
      preparationTime: 15,
      difficulty: 'Easy',
      isFavorite: false,
    ),
    Meal(
      id: '2',
      name: 'Grilled Chicken Salad',
      description:
          'Fresh and nutritious salad with grilled chicken breast, mixed greens, and balsamic dressing.',
      imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1',
      calories: 420,
      protein: 35.0,
      carbs: 25.0,
      fats: 15.0,
      ingredients: [
        '200g chicken breast',
        '2 cups mixed greens',
        '1 tomato',
        '1/2 cucumber',
        '2 tablespoons balsamic vinaigrette',
      ],
      instructions: [
        'Season chicken breast with salt and pepper.',
        'Grill chicken for 6-8 minutes per side.',
        'Let chicken rest for 5 minutes, then slice.',
        'Mix greens with chopped vegetables.',
        'Top with sliced chicken and drizzle with dressing.',
      ],
      category: 'Lunch',
      preparationTime: 25,
      difficulty: 'Medium',
      isFavorite: true,
    ),
    Meal(
      id: '3',
      name: 'Salmon with Quinoa',
      description:
          'Baked salmon fillet served with quinoa and roasted vegetables.',
      imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288',
      calories: 550,
      protein: 42.0,
      carbs: 35.0,
      fats: 22.0,
      ingredients: [
        '200g salmon fillet',
        '1 cup quinoa',
        '2 cups mixed vegetables',
        '2 tablespoons olive oil',
        'Lemon and herbs',
      ],
      instructions: [
        'Preheat oven to 400°F (200°C).',
        'Cook quinoa according to package instructions.',
        'Season salmon with herbs, lemon, salt, and pepper.',
        'Bake salmon for 12-15 minutes.',
        'Serve with quinoa and roasted vegetables.',
      ],
      category: 'Dinner',
      preparationTime: 35,
      difficulty: 'Medium',
      isFavorite: false,
    ),
  ];

  final _mealSchedule = [
    MealSchedule(
      mealId: '1',
      name: 'Oatmeal with Berries',
      time: '08:00',
      calories: 350,
      protein: 12.0,
      carbs: 45.0,
      fats: 8.0,
      isCompleted: true,
    ),
    MealSchedule(
      mealId: '2',
      name: 'Grilled Chicken Salad',
      time: '13:00',
      calories: 420,
      protein: 35.0,
      carbs: 25.0,
      fats: 15.0,
      isCompleted: false,
    ),
    MealSchedule(
      mealId: '3',
      name: 'Salmon with Quinoa',
      time: '19:00',
      calories: 550,
      protein: 42.0,
      carbs: 35.0,
      fats: 22.0,
      isCompleted: false,
    ),
  ];

  final _goals = NutritionGoals(
    dailyCalories: 2000,
    dailyProtein: 150,
    dailyCarbs: 200,
    dailyFats: 65,
    mealsPerDay: 3,
    dietaryRestrictions: ['Gluten-free'],
  );

  @override
  Future<List<Meal>> getMeals({String? category, String? difficulty}) async {
    await Future.delayed(const Duration(seconds: 1));
    return _meals.where((meal) {
      final matchesCategory =
          category == null || category == 'All' || meal.category == category;
      final matchesDifficulty =
          difficulty == null || meal.difficulty == difficulty;
      return matchesCategory && matchesDifficulty;
    }).toList();
  }

  @override
  Future<Meal> getMealById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final meal = _meals.firstWhere(
      (meal) => meal.id == id,
      orElse: () => throw Exception('Meal not found'),
    );
    return meal;
  }

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  }

  @override
  Future<DailyMealPlan> getDailyMealPlan(DateTime date) async {
    await Future.delayed(const Duration(seconds: 1));
    return DailyMealPlan(
      date: date,
      meals: _mealSchedule,
      totalCalories: _mealSchedule.fold(0, (sum, meal) => sum + meal.calories),
      totalProtein: _mealSchedule.fold(0.0, (sum, meal) => sum + meal.protein),
      totalCarbs: _mealSchedule.fold(0.0, (sum, meal) => sum + meal.carbs),
      totalFats: _mealSchedule.fold(0.0, (sum, meal) => sum + meal.fats),
    );
  }

  @override
  Future<NutritionGoals> getNutritionGoals() async {
    await Future.delayed(const Duration(seconds: 1));
    return _goals;
  }

  @override
  Future<void> updateNutritionGoals(NutritionGoals goals) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would update the backend
  }

  @override
  Future<void> toggleFavoriteMeal(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _meals.indexWhere((meal) => meal.id == id);
    if (index != -1) {
      _meals[index] =
          _meals[index].copyWith(isFavorite: !_meals[index].isFavorite);
    }
  }

  @override
  Future<void> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mealSchedule
        .indexWhere((meal) => meal.mealId == mealId && meal.time == time);
    if (index != -1) {
      _mealSchedule[index] = _mealSchedule[index].copyWith(isCompleted: true);
    }
  }

  @override
  Future<void> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mealSchedule
        .indexWhere((meal) => meal.mealId == mealId && meal.time == oldTime);
    if (index != -1) {
      _mealSchedule[index] = _mealSchedule[index].copyWith(time: newTime);
    }
  }
}
