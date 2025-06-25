import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/meal.dart';

class FoodEntriesList extends StatelessWidget {
  final List<Food> foodEntries;
  final Function(String) onRemoveEntry;

  const FoodEntriesList({
    super.key,
    required this.foodEntries,
    required this.onRemoveEntry,
  });

  @override
  Widget build(BuildContext context) {
    if (foodEntries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.restaurant_menu_outlined,
              size: 48,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No food entries today',
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some food to track your nutrition',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: foodEntries.map((food) => _buildFoodEntry(food)).toList(),
    );
  }

  Widget _buildFoodEntry(Food food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Food icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getFoodIcon(food.category),
              color: AppColors.primary,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          // Food info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(food.caloriesPer100g * 1.0).toStringAsFixed(0)} kcal • 100g',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Nutrition info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'P: ${food.proteinPer100g.toStringAsFixed(1)}g',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green,
                ),
              ),
              Text(
                'C: ${food.carbsPer100g.toStringAsFixed(1)}g',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.orange,
                ),
              ),
              Text(
                'F: ${food.fatsPer100g.toStringAsFixed(1)}g',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),

          // Remove button
          IconButton(
            onPressed: () => onRemoveEntry(food.id),
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.red.withOpacity(0.7),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFoodIcon(String category) {
    switch (category.toLowerCase()) {
      case 'fruit':
        return Icons.apple;
      case 'vegetable':
        return Icons.eco;
      case 'protein':
        return Icons.egg;
      case 'dairy':
        return Icons.local_drink;
      case 'grain':
        return Icons.grain;
      case 'snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }
}
