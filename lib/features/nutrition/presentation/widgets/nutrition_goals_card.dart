import 'package:flutter/material.dart';
import '../../domain/entities/meal.dart';

class NutritionGoalsCard extends StatelessWidget {
  final NutritionGoals goals;

  const NutritionGoalsCard({
    super.key,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                'Daily Goals',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, '/nutrition-goals');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutrientGoal(
                icon: Icons.local_fire_department_outlined,
                value: goals.dailyCalories.toString(),
                unit: 'kcal',
                label: 'Calories',
                color: Colors.orange,
              ),
              _NutrientGoal(
                icon: Icons.fitness_center_outlined,
                value: goals.dailyProtein.toStringAsFixed(1),
                unit: 'g',
                label: 'Protein',
                color: Colors.red,
              ),
              _NutrientGoal(
                icon: Icons.grain_outlined,
                value: goals.dailyCarbs.toStringAsFixed(1),
                unit: 'g',
                label: 'Carbs',
                color: Colors.blue,
              ),
              _NutrientGoal(
                icon: Icons.water_drop_outlined,
                value: goals.dailyFats.toStringAsFixed(1),
                unit: 'g',
                label: 'Fats',
                color: Colors.green,
              ),
            ],
          ),
          if (goals.dietaryRestrictions.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Dietary Restrictions',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: goals.dietaryRestrictions.map((restriction) {
                return Chip(
                  label: Text(
                    restriction,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _NutrientGoal extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final Color color;

  const _NutrientGoal({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
