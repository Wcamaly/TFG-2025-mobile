import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal.dart';

part 'nutrition_stats_provider.freezed.dart';

@freezed
class NutritionStatsState with _$NutritionStatsState {
  const factory NutritionStatsState.initial() = _Initial;
  const factory NutritionStatsState.loading() = _Loading;
  const factory NutritionStatsState.loaded(NutritionStats stats) = _Loaded;
  const factory NutritionStatsState.error(String message) = _Error;
}

@freezed
class WeeklyNutritionState with _$WeeklyNutritionState {
  const factory WeeklyNutritionState.initial() = _WeeklyInitial;
  const factory WeeklyNutritionState.loading() = _WeeklyLoading;
  const factory WeeklyNutritionState.loaded(WeeklyNutritionSummary summary) =
      _WeeklyLoaded;
  const factory WeeklyNutritionState.error(String message) = _WeeklyError;
}

class NutritionStatsNotifier extends StateNotifier<NutritionStatsState> {
  NutritionStatsNotifier() : super(const NutritionStatsState.initial());

  Future<void> loadDailyStats(DateTime date) async {
    state = const NutritionStatsState.loading();

    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate API call

      // Mock data for demonstration
      final stats = NutritionStats(
        date: date,
        totalCaloriesConsumed: 1850,
        totalProteinConsumed: 125.5,
        totalCarbsConsumed: 180.2,
        totalFatsConsumed: 75.8,
        totalFiberConsumed: 28.5,
        totalSugarConsumed: 45.2,
        totalCaloriesGoal: 2200,
        totalProteinGoal: 150.0,
        totalCarbsGoal: 220.0,
        totalFatsGoal: 85.0,
        foodEntries: _generateMockFoodEntries(),
        waterIntake: 2.1,
        waterGoal: 2.5,
      );

      state = NutritionStatsState.loaded(stats);
    } catch (e) {
      state = NutritionStatsState.error(e.toString());
    }
  }

  Future<void> addFoodEntry(FoodEntry entry) async {
    state.whenOrNull(
      loaded: (currentStats) async {
        final updatedEntries = [...currentStats.foodEntries, entry];
        final updatedStats = currentStats.copyWith(
          foodEntries: updatedEntries,
          totalCaloriesConsumed:
              currentStats.totalCaloriesConsumed + entry.calories,
          totalProteinConsumed:
              currentStats.totalProteinConsumed + entry.protein,
          totalCarbsConsumed: currentStats.totalCarbsConsumed + entry.carbs,
          totalFatsConsumed: currentStats.totalFatsConsumed + entry.fats,
          totalFiberConsumed: currentStats.totalFiberConsumed + entry.fiber,
          totalSugarConsumed: currentStats.totalSugarConsumed + entry.sugar,
        );
        state = NutritionStatsState.loaded(updatedStats);
      },
    );
  }

  List<FoodEntry> _generateMockFoodEntries() {
    return [
      FoodEntry(
        id: '1',
        foodId: 'chicken_breast',
        foodName: 'Chicken Breast',
        foodImageUrl: 'https://example.com/chicken.jpg',
        quantity: 200.0,
        calories: 330,
        protein: 62.0,
        carbs: 0.0,
        fats: 7.4,
        fiber: 0.0,
        sugar: 0.0,
        mealType: 'lunch',
        consumedAt: DateTime.now().subtract(const Duration(hours: 2)),
        quality: 'GOOD',
      ),
      FoodEntry(
        id: '2',
        foodId: 'brown_rice',
        foodName: 'Brown Rice',
        foodImageUrl: 'https://example.com/rice.jpg',
        quantity: 150.0,
        calories: 165,
        protein: 3.5,
        carbs: 33.0,
        fats: 1.2,
        fiber: 2.0,
        sugar: 0.3,
        mealType: 'lunch',
        consumedAt: DateTime.now().subtract(const Duration(hours: 2)),
        quality: 'GOOD',
      ),
      FoodEntry(
        id: '3',
        foodId: 'banana',
        foodName: 'Banana',
        foodImageUrl: 'https://example.com/banana.jpg',
        quantity: 120.0,
        calories: 107,
        protein: 1.3,
        carbs: 27.0,
        fats: 0.4,
        fiber: 3.1,
        sugar: 14.4,
        mealType: 'snack',
        consumedAt: DateTime.now().subtract(const Duration(hours: 4)),
        quality: 'GOOD',
      ),
    ];
  }
}

class WeeklyNutritionNotifier extends StateNotifier<WeeklyNutritionState> {
  WeeklyNutritionNotifier() : super(const WeeklyNutritionState.initial());

  Future<void> loadWeeklySummary(DateTime weekStart) async {
    state = const WeeklyNutritionState.loading();

    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate API call

      final summary = WeeklyNutritionSummary(
        weekStart: weekStart,
        weekEnd: weekStart.add(const Duration(days: 6)),
        avgCaloriesPerDay: 1950.0,
        avgProteinPerDay: 135.0,
        avgCarbsPerDay: 195.0,
        avgFatsPerDay: 78.0,
        avgFiberPerDay: 25.0,
        avgWaterPerDay: 2.2,
        daysOnTrack: 5,
        totalDays: 7,
        calorieGoalAchievement: 88.6,
        topFoodCategories: ['Protein', 'Vegetables', 'Grains', 'Fruits'],
        improvements: [
          'Increase water intake by 300ml daily',
          'Add more fiber-rich foods',
          'Reduce processed snacks',
        ],
      );

      state = WeeklyNutritionState.loaded(summary);
    } catch (e) {
      state = WeeklyNutritionState.error(e.toString());
    }
  }
}

// Providers
final nutritionStatsProvider =
    StateNotifierProvider<NutritionStatsNotifier, NutritionStatsState>((ref) {
  return NutritionStatsNotifier();
});

final weeklyNutritionProvider =
    StateNotifierProvider<WeeklyNutritionNotifier, WeeklyNutritionState>((ref) {
  return WeeklyNutritionNotifier();
});
