import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/meal.dart';

class DailyNutritionSummary extends StatelessWidget {
  final NutritionStats stats;
  final VoidCallback onAddFood;

  const DailyNutritionSummary({
    super.key,
    required this.stats,
    required this.onAddFood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Nutrition',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onAddFood,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Add Food',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Calorie Progress
          _buildCalorieProgress(),

          const SizedBox(height: 20),

          // Macros Row
          Row(
            children: [
              Expanded(
                child: _buildMacroCard(
                  'Carbs',
                  stats.totalCarbsConsumed,
                  stats.totalCarbsGoal,
                  Colors.orange,
                  'g',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMacroCard(
                  'Protein',
                  stats.totalProteinConsumed,
                  stats.totalProteinGoal,
                  Colors.red,
                  'g',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMacroCard(
                  'Fat',
                  stats.totalFatsConsumed,
                  stats.totalFatsGoal,
                  Colors.green,
                  'g',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Additional Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Water: ${stats.waterIntake.toStringAsFixed(1)}L',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                ),
              ),
              Text(
                'Fiber: ${stats.totalFiberConsumed.toStringAsFixed(1)}g',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieProgress() {
    final progress = stats.totalCaloriesGoal > 0
        ? (stats.totalCaloriesConsumed / stats.totalCaloriesGoal)
            .clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Calories',
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${stats.totalCaloriesConsumed.toStringAsFixed(0)} / ${stats.totalCaloriesGoal.toStringAsFixed(0)}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: _getCalorieProgressColor(progress),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${(progress * 100).toStringAsFixed(0)}% of daily goal',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildMacroCard(
    String name,
    double consumed,
    double goal,
    Color color,
    String unit,
  ) {
    final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${consumed.toStringAsFixed(0)}$unit',
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'of ${goal.toStringAsFixed(0)}$unit',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCalorieProgressColor(double progress) {
    if (progress < 0.5) {
      return Colors.red;
    } else if (progress < 0.8) {
      return Colors.orange;
    } else if (progress <= 1.0) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }
}
