import 'package:flutter/material.dart';

class NutrientInfoCard extends StatelessWidget {
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  const NutrientInfoCard({
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NutrientIndicator(
                icon: Icons.local_fire_department_outlined,
                value: calories,
                unit: 'kcal',
                label: 'Calories',
                color: Colors.orange,
              ),
              _NutrientIndicator(
                icon: Icons.fitness_center_outlined,
                value: protein.toInt(),
                unit: 'g',
                label: 'Protein',
                color: Colors.red,
              ),
              _NutrientIndicator(
                icon: Icons.grain_outlined,
                value: carbs.toInt(),
                unit: 'g',
                label: 'Carbs',
                color: Colors.blue,
              ),
              _NutrientIndicator(
                icon: Icons.water_drop_outlined,
                value: fats.toInt(),
                unit: 'g',
                label: 'Fats',
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: (protein + carbs + fats) / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientIndicator extends StatelessWidget {
  final IconData icon;
  final int value;
  final String unit;
  final String label;
  final Color color;

  const _NutrientIndicator({
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
                text: value.toString(),
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
