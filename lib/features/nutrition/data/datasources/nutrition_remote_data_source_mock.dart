import '../../domain/entities/meal.dart';
import 'nutrition_remote_data_source.dart';

class NutritionRemoteDataSourceMock implements NutritionRemoteDataSource {
  // Mock data for foods
  final _foods = [
    const Food(
      id: 'strawberry',
      name: 'Strawberry',
      description: 'Fresh strawberries, rich in vitamin C and antioxidants',
      imageUrl: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6',
      caloriesPer100g: 32,
      proteinPer100g: 0.7,
      carbsPer100g: 7.7,
      fatsPer100g: 0.3,
      fiberPer100g: 2.0,
      sugarPer100g: 4.9,
      vitamins: ['Vitamin C', 'Folate', 'Manganese'],
      minerals: ['Potassium', 'Calcium', 'Iron'],
      category: 'fruits',
      quality: 'GOOD',
      isOrganic: true,
      allergens: [],
      origin: 'Spain',
      glycemicIndex: 40.0,
    ),
    const Food(
      id: 'kiwi',
      name: 'Kiwi',
      description: 'Nutrient-dense kiwi fruit with high vitamin C content',
      imageUrl: 'https://images.unsplash.com/photo-1585059895524-72359e06133a',
      caloriesPer100g: 61,
      proteinPer100g: 1.1,
      carbsPer100g: 14.7,
      fatsPer100g: 0.5,
      fiberPer100g: 3.0,
      sugarPer100g: 9.0,
      vitamins: ['Vitamin C', 'Vitamin K', 'Vitamin E'],
      minerals: ['Potassium', 'Copper', 'Manganese'],
      category: 'fruits',
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'New Zealand',
      glycemicIndex: 53.0,
    ),
    const Food(
      id: 'tomato',
      name: 'Tomato',
      description: 'Fresh tomatoes, rich in lycopene and vitamin C',
      imageUrl: 'https://images.unsplash.com/photo-1546470427-e2c1c8e65e8f',
      caloriesPer100g: 18,
      proteinPer100g: 0.9,
      carbsPer100g: 3.9,
      fatsPer100g: 0.2,
      fiberPer100g: 1.2,
      sugarPer100g: 2.6,
      vitamins: ['Vitamin C', 'Vitamin K', 'Folate'],
      minerals: ['Potassium', 'Manganese'],
      category: 'vegetables',
      quality: 'GOOD',
      isOrganic: true,
      allergens: [],
      origin: 'Italy',
      glycemicIndex: 15.0,
    ),
    const Food(
      id: 'chicken_breast',
      name: 'Chicken Breast',
      description: 'Lean protein source, skinless chicken breast',
      imageUrl: 'https://images.unsplash.com/photo-1604503468506-a8da13d82791',
      caloriesPer100g: 165,
      proteinPer100g: 31.0,
      carbsPer100g: 0.0,
      fatsPer100g: 3.6,
      fiberPer100g: 0.0,
      sugarPer100g: 0.0,
      vitamins: ['Niacin', 'Vitamin B6', 'Phosphorus'],
      minerals: ['Selenium', 'Phosphorus', 'Potassium'],
      category: 'protein',
      quality: 'EXCELLENT',
      isOrganic: false,
      allergens: [],
      origin: 'Local Farm',
      glycemicIndex: 0.0,
    ),
    const Food(
      id: 'avocado',
      name: 'Avocado',
      description: 'Nutrient-dense fruit high in healthy monounsaturated fats',
      imageUrl: 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578',
      caloriesPer100g: 160,
      proteinPer100g: 2.0,
      carbsPer100g: 8.5,
      fatsPer100g: 14.7,
      fiberPer100g: 6.7,
      sugarPer100g: 0.7,
      vitamins: ['Vitamin K', 'Folate', 'Vitamin C'],
      minerals: ['Potassium', 'Magnesium', 'Copper'],
      category: 'fruits',
      quality: 'EXCELLENT',
      isOrganic: true,
      allergens: [],
      origin: 'Mexico',
      glycemicIndex: 15.0,
    ),
  ];

  // Mock user profile
  UserProfile _mockUserProfile = UserProfile(
    id: 'user_1',
    name: 'Juan Pérez',
    age: 28,
    gender: 'male',
    weight: 75.0,
    height: 175.0,
    activityLevel: 'moderate',
    goal: 'maintain_weight',
    dietaryRestrictions: [],
    allergies: [],
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
  );

  // Mock food entries for today
  final List<FoodEntry> _todayFoodEntries = [
    FoodEntry(
      id: 'entry_1',
      foodId: 'strawberry',
      foodName: 'Strawberry',
      foodImageUrl:
          'https://images.unsplash.com/photo-1464965911861-746a04b4bca6',
      quantity: 150.0,
      calories: 48,
      protein: 1.05,
      carbs: 11.55,
      fats: 0.45,
      fiber: 3.0,
      sugar: 7.35,
      mealType: 'breakfast',
      consumedAt: DateTime.now().subtract(const Duration(hours: 2)),
      quality: 'GOOD',
    ),
    FoodEntry(
      id: 'entry_2',
      foodId: 'chicken_breast',
      foodName: 'Chicken Breast',
      foodImageUrl:
          'https://images.unsplash.com/photo-1604503468506-a8da13d82791',
      quantity: 120.0,
      calories: 198,
      protein: 37.2,
      carbs: 0.0,
      fats: 4.32,
      fiber: 0.0,
      sugar: 0.0,
      mealType: 'lunch',
      consumedAt: DateTime.now().subtract(const Duration(hours: 4)),
      quality: 'EXCELLENT',
    ),
  ];

  final _meals = [
    const Meal(
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
    // Add more meals as needed...
  ];

  final _mealSchedule = [
    const MealSchedule(
      mealId: '1',
      name: 'Oatmeal with Berries',
      description:
          'A healthy and filling breakfast with oatmeal, mixed berries, and honey.',
      imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf',
      time: '08:00',
      calories: 350,
      protein: 12.0,
      carbs: 45.0,
      fats: 8.0,
      isCompleted: true,
      category: 'Breakfast',
      isFavorite: false,
    ),
    const MealSchedule(
      mealId: '2',
      name: 'Grilled Chicken Salad',
      description:
          'Fresh and nutritious salad with grilled chicken breast, mixed greens, and balsamic dressing.',
      imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1',
      time: '13:00',
      calories: 420,
      protein: 35.0,
      carbs: 25.0,
      fats: 15.0,
      isCompleted: false,
      category: 'Lunch',
      isFavorite: true,
    ),
    const MealSchedule(
      mealId: '3',
      name: 'Salmon with Quinoa',
      description:
          'Baked salmon fillet served with quinoa and roasted vegetables.',
      imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288',
      time: '19:00',
      calories: 550,
      protein: 42.0,
      carbs: 35.0,
      fats: 22.0,
      isCompleted: false,
      category: 'Dinner',
      isFavorite: false,
    ),
  ];

  static const _goals = NutritionGoals(
    dailyCalories: 2000,
    dailyProtein: 150,
    dailyCarbs: 200,
    dailyFats: 65,
    mealsPerDay: 3,
    dietaryRestrictions: ['Gluten-free'],
  );

  @override
  Future<List<Meal>> getMeals({
    String? category,
    String? difficulty,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var filteredMeals = _meals;

    if (category != null && category != 'All') {
      filteredMeals =
          filteredMeals.where((meal) => meal.category == category).toList();
    }

    if (difficulty != null) {
      filteredMeals =
          filteredMeals.where((meal) => meal.difficulty == difficulty).toList();
    }

    return filteredMeals;
  }

  @override
  Future<Meal> getMealById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _meals.firstWhere((meal) => meal.id == id);
  }

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];
  }

  @override
  Future<DailyMealPlan> getDailyMealPlan(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return DailyMealPlan(
      date: date,
      meals: [
        const MealSchedule(
          mealId: '1',
          name: 'Oatmeal with Berries',
          time: '08:00',
          calories: 350,
          protein: 12.0,
          carbs: 45.0,
          fats: 8.0,
          isCompleted: false,
          category: 'Breakfast',
          imageUrl:
              'https://images.unsplash.com/photo-1517673132405-a56a62b18caf',
          description: 'A healthy and filling breakfast',
          isFavorite: false,
        ),
      ],
      totalCalories: 350,
      totalProtein: 12.0,
      totalCarbs: 45.0,
      totalFats: 8.0,
    );
  }

  @override
  Future<NutritionGoals> getNutritionGoals() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const NutritionGoals(
      dailyCalories: 2200,
      dailyProtein: 110.0,
      dailyCarbs: 275.0,
      dailyFats: 73.0,
      mealsPerDay: 4,
      dietaryRestrictions: [],
    );
  }

  @override
  Future<void> updateNutritionGoals(NutritionGoals goals) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> toggleFavoriteMeal(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> markMealAsCompleted({
    required String mealId,
    required DateTime date,
    required String time,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> updateMealSchedule({
    required String mealId,
    required DateTime date,
    required String oldTime,
    required String newTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // New food analytics methods implementation
  @override
  Future<List<Food>> searchFoods(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.isEmpty) return _foods;

    return _foods
        .where((food) =>
            food.name.toLowerCase().contains(query.toLowerCase()) ||
            food.description.toLowerCase().contains(query.toLowerCase()) ||
            food.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<Food> getFoodById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _foods.firstWhere((food) => food.id == id);
  }

  @override
  Future<FoodAnalytics> analyzeFoodQuantity({
    required String foodId,
    required double quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final food = _foods.firstWhere((f) => f.id == foodId);
    final multiplier = quantity / 100.0;

    return FoodAnalytics(
      food: food,
      quantity: quantity,
      totalCalories: (food.caloriesPer100g * multiplier).round(),
      totalProtein: food.proteinPer100g * multiplier,
      totalCarbs: food.carbsPer100g * multiplier,
      totalFats: food.fatsPer100g * multiplier,
      totalFiber: food.fiberPer100g * multiplier,
      totalSugar: food.sugarPer100g * multiplier,
      vitamins: food.vitamins,
      minerals: food.minerals,
      qualityRating: food.quality,
      healthImpact: _getHealthImpact(food),
      benefits: _getBenefits(food),
      warnings: _getWarnings(food),
    );
  }

  @override
  Future<List<Food>> getFoodsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _foods.where((food) => food.category == category).toList();
  }

  @override
  Future<List<String>> getFoodCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ['fruits', 'vegetables', 'protein', 'grains', 'dairy', 'nuts'];
  }

  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockUserProfile;
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _mockUserProfile = profile;
  }

  @override
  Future<BMIData> calculateBMI({
    required double weight,
    required double height,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final heightInMeters = height / 100.0;
    final bmi = weight / (heightInMeters * heightInMeters);

    String category;
    String description;
    String recommendations;

    if (bmi < 18.5) {
      category = 'underweight';
      description = 'Por debajo del peso normal';
      recommendations =
          'Considera aumentar tu ingesta calórica de manera saludable y consulta con un profesional de la salud.';
    } else if (bmi < 25.0) {
      category = 'normal';
      description = 'Peso normal';
      recommendations =
          'Mantén tu estilo de vida saludable actual con una dieta equilibrada y ejercicio regular.';
    } else if (bmi < 30.0) {
      category = 'overweight';
      description = 'Sobrepeso';
      recommendations =
          'Considera reducir tu ingesta calórica y aumentar la actividad física. Consulta con un profesional.';
    } else {
      category = 'obese';
      description = 'Obesidad';
      recommendations =
          'Es importante consultar con un profesional de la salud para un plan personalizado de pérdida de peso.';
    }

    final idealWeightMin = 18.5 * heightInMeters * heightInMeters;
    final idealWeightMax = 24.9 * heightInMeters * heightInMeters;

    return BMIData(
      bmi: double.parse(bmi.toStringAsFixed(1)),
      category: category,
      description: description,
      idealWeightMin: double.parse(idealWeightMin.toStringAsFixed(1)),
      idealWeightMax: double.parse(idealWeightMax.toStringAsFixed(1)),
      recommendations: recommendations,
    );
  }

  @override
  Future<CalorieCalculation> calculateCalories({
    required UserProfile profile,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Mifflin-St Jeor Equation
    double bmr;
    if (profile.gender == 'male') {
      bmr = 88.362 +
          (13.397 * profile.weight) +
          (4.799 * profile.height) -
          (5.677 * profile.age);
    } else {
      bmr = 447.593 +
          (9.247 * profile.weight) +
          (3.098 * profile.height) -
          (4.330 * profile.age);
    }

    // Activity level multipliers
    double activityMultiplier;
    switch (profile.activityLevel) {
      case 'sedentary':
        activityMultiplier = 1.2;
        break;
      case 'light':
        activityMultiplier = 1.375;
        break;
      case 'moderate':
        activityMultiplier = 1.55;
        break;
      case 'active':
        activityMultiplier = 1.725;
        break;
      case 'very_active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.55;
    }

    final tdee = bmr * activityMultiplier;
    final maintenanceCalories = tdee.round();
    final weightLossCalories = (tdee - 500).round();
    final weightGainCalories = (tdee + 500).round();

    // Macronutrient goals (protein: 25%, carbs: 45%, fats: 30%)
    final proteinGoal = (maintenanceCalories * 0.25) / 4; // 4 calories per gram
    final carbsGoal = (maintenanceCalories * 0.45) / 4;
    final fatsGoal = (maintenanceCalories * 0.30) / 9; // 9 calories per gram

    return CalorieCalculation(
      bmr: double.parse(bmr.toStringAsFixed(1)),
      tdee: double.parse(tdee.toStringAsFixed(1)),
      maintenanceCalories: maintenanceCalories,
      weightLossCalories: weightLossCalories,
      weightGainCalories: weightGainCalories,
      proteinGoal: double.parse(proteinGoal.toStringAsFixed(1)),
      carbsGoal: double.parse(carbsGoal.toStringAsFixed(1)),
      fatsGoal: double.parse(fatsGoal.toStringAsFixed(1)),
      methodology: 'mifflin-st-jeor',
    );
  }

  @override
  Future<NutritionStats> getDailyNutritionStats(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final totalCaloriesConsumed =
        _todayFoodEntries.fold<int>(0, (sum, entry) => sum + entry.calories);
    final totalProteinConsumed = _todayFoodEntries.fold<double>(
        0.0, (sum, entry) => sum + entry.protein);
    final totalCarbsConsumed =
        _todayFoodEntries.fold<double>(0.0, (sum, entry) => sum + entry.carbs);
    final totalFatsConsumed =
        _todayFoodEntries.fold<double>(0.0, (sum, entry) => sum + entry.fats);
    final totalFiberConsumed =
        _todayFoodEntries.fold<double>(0.0, (sum, entry) => sum + entry.fiber);
    final totalSugarConsumed =
        _todayFoodEntries.fold<double>(0.0, (sum, entry) => sum + entry.sugar);

    return NutritionStats(
      date: date,
      totalCaloriesConsumed: totalCaloriesConsumed,
      totalProteinConsumed: totalProteinConsumed,
      totalCarbsConsumed: totalCarbsConsumed,
      totalFatsConsumed: totalFatsConsumed,
      totalFiberConsumed: totalFiberConsumed,
      totalSugarConsumed: totalSugarConsumed,
      totalCaloriesGoal: 2200,
      totalProteinGoal: 110.0,
      totalCarbsGoal: 275.0,
      totalFatsGoal: 73.0,
      foodEntries: _todayFoodEntries,
      waterIntake: 1.5,
      waterGoal: 2.5,
    );
  }

  @override
  Future<WeeklyNutritionSummary> getWeeklyNutritionSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return WeeklyNutritionSummary(
      weekStart: startDate,
      weekEnd: endDate,
      avgCaloriesPerDay: 1950.0,
      avgProteinPerDay: 85.0,
      avgCarbsPerDay: 245.0,
      avgFatsPerDay: 65.0,
      avgFiberPerDay: 28.0,
      avgWaterPerDay: 2.1,
      daysOnTrack: 5,
      totalDays: 7,
      calorieGoalAchievement: 88.6,
      topFoodCategories: ['fruits', 'protein', 'vegetables'],
      improvements: [
        'Aumenta el consumo de agua',
        'Incluye más fibra en tu dieta',
        'Mantén el buen consumo de proteínas'
      ],
    );
  }

  @override
  Future<void> addFoodEntry(FoodEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _todayFoodEntries.add(entry);
  }

  @override
  Future<void> removeFoodEntry(String entryId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _todayFoodEntries.removeWhere((entry) => entry.id == entryId);
  }

  @override
  Future<void> updateFoodEntry(FoodEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _todayFoodEntries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      _todayFoodEntries[index] = entry;
    }
  }

  @override
  Future<void> updateWaterIntake({
    required DateTime date,
    required double waterIntake,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<List<FoodAnalytics>> compareFoods({
    required List<String> foodIds,
    required double quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final List<FoodAnalytics> analytics = [];
    for (final foodId in foodIds) {
      final analysis =
          await analyzeFoodQuantity(foodId: foodId, quantity: quantity);
      analytics.add(analysis);
    }
    return analytics;
  }

  @override
  Future<List<Food>> getRecommendedFoods({
    required UserProfile profile,
    required String mealType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Simple recommendation based on meal type
    switch (mealType) {
      case 'breakfast':
        return _foods
            .where((food) =>
                food.category == 'fruits' || food.category == 'grains')
            .toList();
      case 'lunch':
      case 'dinner':
        return _foods
            .where((food) =>
                food.category == 'protein' || food.category == 'vegetables')
            .toList();
      default:
        return _foods.take(3).toList();
    }
  }

  // Helper methods
  String _getHealthImpact(Food food) {
    switch (food.quality) {
      case 'EXCELLENT':
        return 'Excelente para tu salud. Alto valor nutricional.';
      case 'GOOD':
        return 'Buena opción nutritiva. Beneficioso para tu dieta.';
      default:
        return 'Opción moderada. Consume con moderación.';
    }
  }

  List<String> _getBenefits(Food food) {
    final benefits = <String>[];

    if (food.vitamins.contains('Vitamin C')) {
      benefits.add('Rico en Vitamina C - Fortalece el sistema inmune');
    }
    if (food.proteinPer100g > 20) {
      benefits.add('Alto contenido proteico - Desarrollo muscular');
    }
    if (food.fiberPer100g > 3) {
      benefits.add('Rico en fibra - Mejora la digestión');
    }
    if (food.caloriesPer100g < 50) {
      benefits.add('Bajo en calorías - Ideal para control de peso');
    }

    return benefits;
  }

  List<String> _getWarnings(Food food) {
    final warnings = <String>[];

    if (food.sugarPer100g > 10) {
      warnings.add('Alto contenido de azúcar - Consume con moderación');
    }
    if (food.caloriesPer100g > 300) {
      warnings.add('Alto en calorías - Controla las porciones');
    }
    if (food.allergens.isNotEmpty) {
      warnings.add('Contiene alérgenos: ${food.allergens.join(', ')}');
    }

    return warnings;
  }
}
