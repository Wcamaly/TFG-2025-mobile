import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/nutrition_stats_provider.dart';
import '../widgets/nutrition_progress_card.dart';
import '../widgets/food_entries_list.dart';
import '../widgets/water_intake_card.dart';

class NutritionStatsPage extends ConsumerStatefulWidget {
  const NutritionStatsPage({super.key});

  @override
  ConsumerState<NutritionStatsPage> createState() => _NutritionStatsPageState();
}

class _NutritionStatsPageState extends ConsumerState<NutritionStatsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(nutritionStatsProvider.notifier).loadDailyStats(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final nutritionState = ref.watch(nutritionStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nutrition Statistics',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: nutritionState.when(
        initial: () => const Center(
          child: Text(
            'Loading nutrition data...',
            style: TextStyle(color: Colors.white),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        loaded: (stats) => _buildStatsContent(stats),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading statistics',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(nutritionStatsProvider.notifier)
                      .loadDailyStats(DateTime.now());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsContent(stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date selector
          _buildDateSelector(),

          const SizedBox(height: 24),

          // Water intake
          WaterIntakeCard(
            currentIntake: stats.waterIntake * 1000, // Convert to ml
            targetIntake: stats.waterGoal * 1000,
            onAddWater: () {
              // Add water functionality - simplified for now
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Water added! (Feature in development)'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Daily nutrition goals
          Text(
            'Daily Nutrition Goals',
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Progress cards
          _buildNutritionProgress(stats),

          const SizedBox(height: 24),

          // Today's food entries
          Text(
            'Today\'s Food Entries',
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          FoodEntriesList(
            foodEntries: [], // Empty for now - will be populated with real data
            onRemoveEntry: (foodId) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Food removed! (Feature in development)'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Weekly summary
          _buildWeeklySummary(stats),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // Previous day functionality
            },
            icon: const Icon(Icons.chevron_left, color: Colors.white),
          ),
          Text(
            'Today - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              // Next day functionality
            },
            icon: const Icon(Icons.chevron_right, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionProgress(stats) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: NutritionProgressCard(
                title: 'Calories',
                current: stats.totalCaloriesConsumed.toDouble(),
                target: stats.totalCaloriesGoal.toDouble(),
                unit: 'kcal',
                color: AppColors.primary,
                icon: Icons.local_fire_department,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: NutritionProgressCard(
                title: 'Protein',
                current: stats.totalProteinConsumed,
                target: stats.totalProteinGoal,
                unit: 'g',
                color: Colors.green,
                icon: Icons.fitness_center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: NutritionProgressCard(
                title: 'Carbs',
                current: stats.totalCarbsConsumed,
                target: stats.totalCarbsGoal,
                unit: 'g',
                color: Colors.orange,
                icon: Icons.grain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: NutritionProgressCard(
                title: 'Fats',
                current: stats.totalFatsConsumed,
                target: stats.totalFatsGoal,
                unit: 'g',
                color: Colors.blue,
                icon: Icons.water_drop,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeeklySummary(stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Weekly Summary',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Summary stats
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Avg Calories',
                  '${stats.totalCaloriesConsumed} kcal',
                  Icons.local_fire_department,
                  Colors.red,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Days on Track',
                  '5/7',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            'Keep up the great work! You\'re doing well with your nutrition goals.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
