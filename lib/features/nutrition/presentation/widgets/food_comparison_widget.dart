import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/meal.dart';

class FoodComparisonWidget extends StatelessWidget {
  final List<FoodAnalytics> analytics;

  const FoodComparisonWidget({
    super.key,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Food Comparison',
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Food Images Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: analytics.map((analysis) {
              return Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(analysis.food.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    analysis.food.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getQualityColor(analysis.qualityRating),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      analysis.qualityRating,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          // Comparison Table
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Nutrient',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...analytics.map((analysis) {
                        return Expanded(
                          child: Text(
                            '${analysis.quantity.toInt()}g',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Comparison Rows
                _buildComparisonRow(
                  'Calories',
                  analytics.map((a) => '${a.totalCalories}').toList(),
                  'kcal',
                ),
                _buildComparisonRow(
                  'Protein',
                  analytics
                      .map((a) => '${a.totalProtein.toStringAsFixed(1)}')
                      .toList(),
                  'g',
                ),
                _buildComparisonRow(
                  'Carbs',
                  analytics
                      .map((a) => '${a.totalCarbs.toStringAsFixed(1)}')
                      .toList(),
                  'g',
                ),
                _buildComparisonRow(
                  'Fats',
                  analytics
                      .map((a) => '${a.totalFats.toStringAsFixed(1)}')
                      .toList(),
                  'g',
                ),
                _buildComparisonRow(
                  'Fiber',
                  analytics
                      .map((a) => '${a.totalFiber.toStringAsFixed(1)}')
                      .toList(),
                  'g',
                ),
                _buildComparisonRow(
                  'Sugar',
                  analytics
                      .map((a) => '${a.totalSugar.toStringAsFixed(1)}')
                      .toList(),
                  'g',
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Individual Food Details
          ...analytics.map((analysis) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(analysis.food.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              analysis.food.name,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              analysis.healthImpact,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (analysis.benefits.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Benefits:',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...analysis.benefits.take(2).map((benefit) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '• $benefit',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    String nutrient,
    List<String> values,
    String unit, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              nutrient,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          ...values.map((value) {
            final isHighest = _isHighestValue(value, values);
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isHighest
                      ? AppColors.primary.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$value$unit',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isHighest ? AppColors.primary : Colors.white,
                    fontWeight: isHighest ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  bool _isHighestValue(String value, List<String> values) {
    final numValue = double.tryParse(value) ?? 0.0;
    final numValues = values.map((v) => double.tryParse(v) ?? 0.0).toList();
    return numValue == numValues.reduce((a, b) => a > b ? a : b);
  }

  Color _getQualityColor(String quality) {
    switch (quality.toUpperCase()) {
      case 'EXCELLENT':
        return Colors.green;
      case 'GOOD':
        return Colors.blue;
      case 'AVERAGE':
        return Colors.orange;
      case 'POOR':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
