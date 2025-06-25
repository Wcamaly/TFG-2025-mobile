import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/charts/circular_progress.dart';
import '../../domain/entities/meal.dart';

class NutritionOverviewCard extends StatelessWidget {
  final NutritionStats stats;
  final VoidCallback onTap;

  const NutritionOverviewCard({
    super.key,
    required this.stats,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final calorieProgress =
        stats.totalCaloriesConsumed / stats.totalCaloriesGoal;
    final remaining = stats.totalCaloriesGoal - stats.totalCaloriesConsumed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Progress',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 16,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                // Calorie Progress Circle
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            value: calorieProgress.clamp(0.0, 1.0),
                            strokeWidth: 8,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              calorieProgress > 1.0
                                  ? Colors.red
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(calorieProgress * 100).toInt()}%',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Calorie Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calories',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${stats.totalCaloriesConsumed}',
                              style: AppTextStyles.headlineMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' / ${stats.totalCaloriesGoal}',
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        remaining > 0
                            ? '$remaining kcal remaining'
                            : '${-remaining} kcal over goal',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: remaining > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Macronutrients Row
            Row(
              children: [
                Expanded(
                  child: _buildMacroItem(
                    'Protein',
                    '${stats.totalProteinConsumed.toStringAsFixed(0)}g',
                    '${stats.totalProteinGoal.toStringAsFixed(0)}g',
                    stats.totalProteinConsumed / stats.totalProteinGoal,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMacroItem(
                    'Carbs',
                    '${stats.totalCarbsConsumed.toStringAsFixed(0)}g',
                    '${stats.totalCarbsGoal.toStringAsFixed(0)}g',
                    stats.totalCarbsConsumed / stats.totalCarbsGoal,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMacroItem(
                    'Fats',
                    '${stats.totalFatsConsumed.toStringAsFixed(0)}g',
                    '${stats.totalFatsGoal.toStringAsFixed(0)}g',
                    stats.totalFatsConsumed / stats.totalFatsGoal,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroItem(
    String name,
    String current,
    String goal,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          current,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'of $goal',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.white.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}
