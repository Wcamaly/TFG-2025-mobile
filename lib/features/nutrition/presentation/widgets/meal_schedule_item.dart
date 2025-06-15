import 'package:flutter/material.dart';
import '../../domain/entities/meal.dart';

class MealScheduleItem extends StatelessWidget {
  final MealSchedule meal;
  final VoidCallback onDelete;
  final Function(String) onTimeChanged;

  const MealScheduleItem({
    super.key,
    required this.meal,
    required this.onDelete,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  meal.time,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  ),
                  const SizedBox(height: 4),
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
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (newTime != null) {
                      onTimeChanged('${newTime.hour}:${newTime.minute}');
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
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
