import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal.dart';

part 'food_analytics_provider.freezed.dart';

@freezed
class FoodAnalyticsState with _$FoodAnalyticsState {
  const factory FoodAnalyticsState.initial() = _Initial;
  const factory FoodAnalyticsState.loading() = _Loading;
  const factory FoodAnalyticsState.loaded(List<FoodAnalytics> analytics) =
      _Loaded;
  const factory FoodAnalyticsState.error(String message) = _Error;
}

@freezed
class FoodSearchState with _$FoodSearchState {
  const factory FoodSearchState.initial() = _SearchInitial;
  const factory FoodSearchState.loading() = _SearchLoading;
  const factory FoodSearchState.loaded(List<Food> foods) = _SearchLoaded;
  const factory FoodSearchState.error(String message) = _SearchError;
}

class FoodAnalyticsNotifier extends StateNotifier<FoodAnalyticsState> {
  FoodAnalyticsNotifier() : super(const FoodAnalyticsState.initial());

  Future<void> analyzeFoodQuantity({
    required String foodId,
    required double quantity,
  }) async {
    state = const FoodAnalyticsState.loading();

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Find the food from mock data
      final food = _getMockFoods().firstWhere(
        (f) => f.id == foodId,
        orElse: () => _getMockFoods().first,
      );

      // Calculate nutrition based on quantity
      final analytics = FoodAnalytics(
        food: food,
        quantity: quantity,
        totalCalories: ((food.caloriesPer100g * quantity) / 100).round(),
        totalProtein: (food.proteinPer100g * quantity) / 100,
        totalCarbs: (food.carbsPer100g * quantity) / 100,
        totalFats: (food.fatsPer100g * quantity) / 100,
        totalFiber: (food.fiberPer100g * quantity) / 100,
        totalSugar: (food.sugarPer100g * quantity) / 100,
        vitamins: _getVitaminsForFood(food.category),
        minerals: _getMineralsForFood(food.category),
        qualityRating: _calculateQualityRating(food),
        healthImpact: _getHealthImpact(food),
        benefits: _getBenefits(food.category),
        warnings: _getWarnings(food),
      );

      state = FoodAnalyticsState.loaded([analytics]);
    } catch (e) {
      state = FoodAnalyticsState.error('Error analyzing food: ${e.toString()}');
    }
  }

  void reset() {
    state = const FoodAnalyticsState.initial();
  }

  String _calculateQualityRating(Food food) {
    // Simple quality rating based on protein/calorie ratio and fiber
    final proteinRatio = food.proteinPer100g / food.caloriesPer100g;
    final fiberContent = food.fiberPer100g;

    if (proteinRatio > 0.2 && fiberContent > 3) return 'EXCELLENT';
    if (proteinRatio > 0.15 || fiberContent > 2) return 'GOOD';
    if (proteinRatio > 0.1 || fiberContent > 1) return 'AVERAGE';
    return 'POOR';
  }

  String _getHealthImpact(Food food) {
    switch (food.category.toLowerCase()) {
      case 'protein':
        return 'High protein content supports muscle growth and repair';
      case 'fruit':
        return 'Rich in vitamins, antioxidants, and natural fiber';
      case 'vegetable':
        return 'Excellent source of vitamins, minerals, and dietary fiber';
      case 'grain':
        return 'Provides complex carbohydrates for sustained energy';
      case 'dairy':
        return 'Good source of calcium and protein for bone health';
      default:
        return 'Provides essential nutrients for overall health';
    }
  }

  List<String> _getVitaminsForFood(String category) {
    switch (category.toLowerCase()) {
      case 'fruit':
        return ['Vitamin C', 'Vitamin A', 'Folate', 'Vitamin K'];
      case 'vegetable':
        return ['Vitamin A', 'Vitamin K', 'Vitamin C', 'Folate'];
      case 'protein':
        return ['Vitamin B12', 'Vitamin B6', 'Niacin', 'Riboflavin'];
      case 'dairy':
        return ['Vitamin D', 'Vitamin B12', 'Vitamin A', 'Riboflavin'];
      case 'grain':
        return ['Thiamine', 'Niacin', 'Folate', 'Vitamin E'];
      default:
        return ['Vitamin C', 'Vitamin A'];
    }
  }

  List<String> _getMineralsForFood(String category) {
    switch (category.toLowerCase()) {
      case 'fruit':
        return ['Potassium', 'Magnesium', 'Manganese'];
      case 'vegetable':
        return ['Iron', 'Potassium', 'Magnesium', 'Calcium'];
      case 'protein':
        return ['Iron', 'Zinc', 'Selenium', 'Phosphorus'];
      case 'dairy':
        return ['Calcium', 'Phosphorus', 'Zinc', 'Potassium'];
      case 'grain':
        return ['Iron', 'Magnesium', 'Zinc', 'Selenium'];
      default:
        return ['Potassium', 'Magnesium'];
    }
  }

  List<String> _getBenefits(String category) {
    switch (category.toLowerCase()) {
      case 'protein':
        return [
          'Muscle building',
          'Tissue repair',
          'Satiety',
          'Metabolism boost'
        ];
      case 'fruit':
        return [
          'Antioxidant protection',
          'Immune support',
          'Digestive health',
          'Natural energy'
        ];
      case 'vegetable':
        return [
          'Disease prevention',
          'Weight management',
          'Digestive health',
          'Heart health'
        ];
      case 'grain':
        return [
          'Sustained energy',
          'Digestive health',
          'B-vitamin source',
          'Heart health'
        ];
      case 'dairy':
        return [
          'Bone health',
          'Muscle function',
          'Protein source',
          'Calcium absorption'
        ];
      default:
        return ['Nutritional support', 'Energy provision'];
    }
  }

  List<String> _getWarnings(Food food) {
    List<String> warnings = [];

    if (food.caloriesPer100g > 400) {
      warnings.add('High calorie content - consume in moderation');
    }
    if (food.fatsPer100g > 20) {
      warnings.add('High fat content');
    }
    if (food.sugarPer100g > 15) {
      warnings.add('High sugar content');
    }
    if (food.category.toLowerCase() == 'snack') {
      warnings.add('Processed food - limit consumption');
    }

    return warnings;
  }
}

class FoodSearchNotifier extends StateNotifier<FoodSearchState> {
  FoodSearchNotifier() : super(const FoodSearchState.initial());

  Future<void> searchFoods(String query) async {
    if (query.isEmpty) {
      state = const FoodSearchState.initial();
      return;
    }

    state = const FoodSearchState.loading();

    try {
      await Future.delayed(
          const Duration(milliseconds: 800)); // Simulate API call

      final allFoods = _getMockFoods();
      final filteredFoods = allFoods.where((food) {
        return food.name.toLowerCase().contains(query.toLowerCase()) ||
            food.category.toLowerCase().contains(query.toLowerCase());
      }).toList();

      state = FoodSearchState.loaded(filteredFoods);
    } catch (e) {
      state = FoodSearchState.error('Error searching foods: ${e.toString()}');
    }
  }

  void clearSearch() {
    state = const FoodSearchState.initial();
  }
}

// Mock food data
List<Food> _getMockFoods() {
  return [
    // Proteins
    Food(
      id: 'chicken_breast',
      name: 'Chicken Breast',
      description: 'Lean protein source, perfect for muscle building',
      category: 'Protein',
      caloriesPer100g: 165,
      proteinPer100g: 31.0,
      carbsPer100g: 0.0,
      fatsPer100g: 3.6,
      fiberPer100g: 0.0,
      sugarPer100g: 0.0,
      vitamins: ['Vitamin B6', 'Vitamin B12', 'Niacin'],
      minerals: ['Phosphorus', 'Selenium', 'Potassium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Farm-raised',
      glycemicIndex: 0.0,
      imageUrl: '',
    ),
    Food(
      id: 'salmon',
      name: 'Salmon',
      description: 'Rich in omega-3 fatty acids and high-quality protein',
      category: 'Protein',
      caloriesPer100g: 208,
      proteinPer100g: 25.4,
      carbsPer100g: 0.0,
      fatsPer100g: 12.4,
      fiberPer100g: 0.0,
      sugarPer100g: 0.0,
      vitamins: ['Vitamin D', 'Vitamin B12', 'Vitamin B6'],
      minerals: ['Selenium', 'Phosphorus', 'Potassium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: ['Fish'],
      origin: 'Wild-caught',
      glycemicIndex: 0.0,
      imageUrl: '',
    ),
    Food(
      id: 'eggs',
      name: 'Eggs',
      description: 'Complete protein source with essential amino acids',
      category: 'Protein',
      caloriesPer100g: 155,
      proteinPer100g: 13.0,
      carbsPer100g: 1.1,
      fatsPer100g: 11.0,
      fiberPer100g: 0.0,
      sugarPer100g: 1.1,
      vitamins: ['Vitamin A', 'Vitamin D', 'Vitamin B12'],
      minerals: ['Iron', 'Phosphorus', 'Selenium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: ['Eggs'],
      origin: 'Free-range',
      glycemicIndex: 0.0,
      imageUrl: '',
    ),

    // Fruits
    Food(
      id: 'apple',
      name: 'Apple',
      description: 'Crisp fruit rich in fiber and antioxidants',
      category: 'Fruit',
      caloriesPer100g: 52,
      proteinPer100g: 0.3,
      carbsPer100g: 14.0,
      fatsPer100g: 0.2,
      fiberPer100g: 2.4,
      sugarPer100g: 10.4,
      vitamins: ['Vitamin C', 'Vitamin A', 'Vitamin K'],
      minerals: ['Potassium', 'Calcium', 'Magnesium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Local farm',
      glycemicIndex: 38.0,
      imageUrl: '',
    ),
    Food(
      id: 'banana',
      name: 'Banana',
      description: 'Natural energy source rich in potassium',
      category: 'Fruit',
      caloriesPer100g: 89,
      proteinPer100g: 1.1,
      carbsPer100g: 23.0,
      fatsPer100g: 0.3,
      fiberPer100g: 2.6,
      sugarPer100g: 12.2,
      vitamins: ['Vitamin C', 'Vitamin B6', 'Folate'],
      minerals: ['Potassium', 'Magnesium', 'Manganese'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Tropical regions',
      glycemicIndex: 51.0,
      imageUrl: '',
    ),
    Food(
      id: 'orange',
      name: 'Orange',
      description: 'Citrus fruit packed with vitamin C',
      category: 'Fruit',
      caloriesPer100g: 47,
      proteinPer100g: 0.9,
      carbsPer100g: 12.0,
      fatsPer100g: 0.1,
      fiberPer100g: 2.4,
      sugarPer100g: 9.4,
      vitamins: ['Vitamin C', 'Folate', 'Thiamine'],
      minerals: ['Potassium', 'Calcium', 'Magnesium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Mediterranean',
      glycemicIndex: 45.0,
      imageUrl: '',
    ),

    // Vegetables
    Food(
      id: 'broccoli',
      name: 'Broccoli',
      description: 'Nutrient-dense vegetable high in vitamins C and K',
      category: 'Vegetable',
      caloriesPer100g: 34,
      proteinPer100g: 2.8,
      carbsPer100g: 7.0,
      fatsPer100g: 0.4,
      fiberPer100g: 2.6,
      sugarPer100g: 1.5,
      vitamins: ['Vitamin C', 'Vitamin K', 'Folate'],
      minerals: ['Iron', 'Potassium', 'Calcium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Local farm',
      glycemicIndex: 10.0,
      imageUrl: '',
    ),
    Food(
      id: 'spinach',
      name: 'Spinach',
      description: 'Dark leafy green rich in iron and folate',
      category: 'Vegetable',
      caloriesPer100g: 23,
      proteinPer100g: 2.9,
      carbsPer100g: 3.6,
      fatsPer100g: 0.4,
      fiberPer100g: 2.2,
      sugarPer100g: 0.4,
      vitamins: ['Vitamin A', 'Vitamin C', 'Vitamin K', 'Folate'],
      minerals: ['Iron', 'Potassium', 'Magnesium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Local farm',
      glycemicIndex: 15.0,
      imageUrl: '',
    ),
    Food(
      id: 'carrot',
      name: 'Carrot',
      description: 'Orange root vegetable high in beta-carotene',
      category: 'Vegetable',
      caloriesPer100g: 41,
      proteinPer100g: 0.9,
      carbsPer100g: 10.0,
      fatsPer100g: 0.2,
      fiberPer100g: 2.8,
      sugarPer100g: 4.7,
      vitamins: ['Vitamin A', 'Vitamin K', 'Vitamin C'],
      minerals: ['Potassium', 'Manganese', 'Molybdenum'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Local farm',
      glycemicIndex: 47.0,
      imageUrl: '',
    ),

    // Grains
    Food(
      id: 'brown_rice',
      name: 'Brown Rice',
      description: 'Whole grain with complex carbohydrates and fiber',
      category: 'Grain',
      caloriesPer100g: 111,
      proteinPer100g: 2.6,
      carbsPer100g: 23.0,
      fatsPer100g: 0.9,
      fiberPer100g: 1.8,
      sugarPer100g: 0.4,
      vitamins: ['Thiamine', 'Niacin', 'Vitamin B6'],
      minerals: ['Manganese', 'Selenium', 'Magnesium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'Asia',
      glycemicIndex: 68.0,
      imageUrl: '',
    ),
    Food(
      id: 'oats',
      name: 'Oats',
      description: 'High-fiber whole grain excellent for breakfast',
      category: 'Grain',
      caloriesPer100g: 389,
      proteinPer100g: 16.9,
      carbsPer100g: 66.3,
      fatsPer100g: 6.9,
      fiberPer100g: 10.6,
      sugarPer100g: 0.9,
      vitamins: ['Thiamine', 'Riboflavin', 'Niacin'],
      minerals: ['Manganese', 'Phosphorus', 'Magnesium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: ['Gluten'],
      origin: 'North America',
      glycemicIndex: 55.0,
      imageUrl: '',
    ),
    Food(
      id: 'quinoa',
      name: 'Quinoa',
      description: 'Complete protein grain with all essential amino acids',
      category: 'Grain',
      caloriesPer100g: 368,
      proteinPer100g: 14.1,
      carbsPer100g: 64.2,
      fatsPer100g: 6.1,
      fiberPer100g: 7.0,
      sugarPer100g: 4.6,
      vitamins: ['Folate', 'Thiamine', 'Vitamin B6'],
      minerals: ['Manganese', 'Phosphorus', 'Copper'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: [],
      origin: 'South America',
      glycemicIndex: 53.0,
      imageUrl: '',
    ),

    // Dairy
    Food(
      id: 'greek_yogurt',
      name: 'Greek Yogurt',
      description: 'Probiotic-rich dairy with high protein content',
      category: 'Dairy',
      caloriesPer100g: 59,
      proteinPer100g: 10.0,
      carbsPer100g: 3.6,
      fatsPer100g: 0.4,
      fiberPer100g: 0.0,
      sugarPer100g: 3.6,
      vitamins: ['Vitamin B12', 'Riboflavin', 'Vitamin A'],
      minerals: ['Calcium', 'Phosphorus', 'Potassium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: ['Dairy'],
      origin: 'Local dairy',
      glycemicIndex: 11.0,
      imageUrl: '',
    ),
    Food(
      id: 'milk',
      name: 'Milk (2%)',
      description: 'Nutrient-rich dairy beverage with calcium',
      category: 'Dairy',
      caloriesPer100g: 50,
      proteinPer100g: 3.4,
      carbsPer100g: 4.8,
      fatsPer100g: 2.0,
      fiberPer100g: 0.0,
      sugarPer100g: 4.8,
      vitamins: ['Vitamin D', 'Vitamin B12', 'Vitamin A'],
      minerals: ['Calcium', 'Phosphorus', 'Potassium'],
      quality: 'NEUTRAL',
      isOrganic: false,
      allergens: ['Dairy'],
      origin: 'Local dairy',
      glycemicIndex: 15.0,
      imageUrl: '',
    ),

    // Nuts & Seeds
    Food(
      id: 'almonds',
      name: 'Almonds',
      description: 'Nutrient-dense nuts rich in healthy fats and protein',
      category: 'Nuts',
      caloriesPer100g: 579,
      proteinPer100g: 21.2,
      carbsPer100g: 21.6,
      fatsPer100g: 49.9,
      fiberPer100g: 12.5,
      sugarPer100g: 4.4,
      vitamins: ['Vitamin E', 'Riboflavin', 'Niacin'],
      minerals: ['Magnesium', 'Phosphorus', 'Calcium'],
      quality: 'GOOD',
      isOrganic: false,
      allergens: ['Tree nuts'],
      origin: 'California',
      glycemicIndex: 0.0,
      imageUrl: '',
    ),
  ];
}

final foodAnalyticsProvider =
    StateNotifierProvider<FoodAnalyticsNotifier, FoodAnalyticsState>((ref) {
  return FoodAnalyticsNotifier();
});

final foodSearchProvider =
    StateNotifierProvider<FoodSearchNotifier, FoodSearchState>((ref) {
  return FoodSearchNotifier();
});
