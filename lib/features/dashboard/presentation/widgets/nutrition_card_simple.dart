import 'package:flutter/material.dart';
import 'package:tfg_2025_mobile/core/theme/app_colors.dart';
import 'package:tfg_2025_mobile/core/theme/app_text_styles.dart';

class NutritionCardSimple extends StatelessWidget {
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  const NutritionCardSimple({
    super.key,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_fire_department_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Nutrition',
                    style: AppTextStyles.headlineMedium,
                  ),
                  Text(
                    'Goal: 2000 kcal',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NutrientInfo(
                label: 'Protein',
                value: protein,
                unit: 'g',
                color: Colors.blue,
              ),
              _NutrientInfo(
                label: 'Carbs',
                value: carbs,
                unit: 'g',
                color: Colors.green,
              ),
              _NutrientInfo(
                label: 'Fats',
                value: fats,
                unit: 'g',
                color: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: calories / 2000,
              backgroundColor: AppColors.surfaceLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$calories kcal',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Remaining: ${2000 - calories} kcal',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NutrientInfo extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
  final Color color;

  const _NutrientInfo({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.toString(),
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: unit,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
      ],
    );
  }
}
