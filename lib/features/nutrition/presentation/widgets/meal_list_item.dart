import 'package:flutter/material.dart';
import '../../domain/entities/meal.dart';

class MealListItem extends StatelessWidget {
  final MealSchedule meal;
  final VoidCallback onTap;

  const MealListItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  meal.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meal.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _NutrientInfo(
                          value: meal.calories,
                          unit: 'kcal',
                          icon: Icons.local_fire_department_outlined,
                        ),
                        const SizedBox(width: 16),
                        _NutrientInfo(
                          value: meal.protein.toInt(),
                          unit: 'g',
                          label: 'P',
                        ),
                        const SizedBox(width: 8),
                        _NutrientInfo(
                          value: meal.carbs.toInt(),
                          unit: 'g',
                          label: 'C',
                        ),
                        const SizedBox(width: 8),
                        _NutrientInfo(
                          value: meal.fats.toInt(),
                          unit: 'g',
                          label: 'F',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  meal.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: meal.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  // TODO: Implement favorite toggle
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NutrientInfo extends StatelessWidget {
  final int value;
  final String unit;
  final IconData? icon;
  final String? label;

  const _NutrientInfo({
    required this.value,
    required this.unit,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: Colors.grey[600],
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
        const SizedBox(width: 4),
        Text(
          '$value$unit',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
