import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../providers/nutrition_goals_provider.dart';

class NutritionGoalsPage extends ConsumerStatefulWidget {
  const NutritionGoalsPage({super.key});

  @override
  ConsumerState<NutritionGoalsPage> createState() => _NutritionGoalsPageState();
}

class _NutritionGoalsPageState extends ConsumerState<NutritionGoalsPage> {
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _carbsController;
  late TextEditingController _fatsController;
  late TextEditingController _mealsPerDayController;
  List<String> _selectedRestrictions = [];

  final List<String> _availableRestrictions = [
    'Vegetarian',
    'Vegan',
    'Gluten-free',
    'Dairy-free',
    'Nut-free',
    'Low-carb',
    'Keto',
    'Paleo',
  ];

  @override
  void initState() {
    super.initState();
    _caloriesController = TextEditingController();
    _proteinController = TextEditingController();
    _carbsController = TextEditingController();
    _fatsController = TextEditingController();
    _mealsPerDayController = TextEditingController();
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();
    _mealsPerDayController.dispose();
    super.dispose();
  }

  void _updateControllers(NutritionGoals goals) {
    _caloriesController.text = goals.dailyCalories.toString();
    _proteinController.text = goals.dailyProtein.toString();
    _carbsController.text = goals.dailyCarbs.toString();
    _fatsController.text = goals.dailyFats.toString();
    _mealsPerDayController.text = goals.mealsPerDay.toString();
    setState(() {
      _selectedRestrictions = List.from(goals.dietaryRestrictions);
    });
  }

  @override
  Widget build(BuildContext context) {
    final goalsState = ref.watch(nutritionGoalsProvider);

    ref.listen<AsyncValue<NutritionGoals>>(nutritionGoalsProvider,
        (prev, next) {
      next.whenData((goals) => _updateControllers(goals));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Goals'),
      ),
      body: goalsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.red,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(nutritionGoalsProvider.notifier).loadGoals();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        data: (goals) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Targets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _NutrientInput(
                controller: _caloriesController,
                label: 'Daily Calories',
                unit: 'kcal',
                icon: Icons.local_fire_department_outlined,
              ),
              const SizedBox(height: 16),
              _NutrientInput(
                controller: _proteinController,
                label: 'Daily Protein',
                unit: 'g',
                icon: Icons.fitness_center_outlined,
              ),
              const SizedBox(height: 16),
              _NutrientInput(
                controller: _carbsController,
                label: 'Daily Carbs',
                unit: 'g',
                icon: Icons.grain_outlined,
              ),
              const SizedBox(height: 16),
              _NutrientInput(
                controller: _fatsController,
                label: 'Daily Fats',
                unit: 'g',
                icon: Icons.water_drop_outlined,
              ),
              const SizedBox(height: 16),
              _NutrientInput(
                controller: _mealsPerDayController,
                label: 'Meals per Day',
                unit: 'meals',
                icon: Icons.restaurant_outlined,
              ),
              const SizedBox(height: 24),
              Text(
                'Dietary Restrictions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableRestrictions.map((restriction) {
                  final isSelected =
                      _selectedRestrictions.contains(restriction);
                  return FilterChip(
                    label: Text(restriction),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedRestrictions.add(restriction);
                        } else {
                          _selectedRestrictions.remove(restriction);
                        }
                      });
                    },
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final newGoals = NutritionGoals(
                      dailyCalories: int.parse(_caloriesController.text),
                      dailyProtein: double.parse(_proteinController.text),
                      dailyCarbs: double.parse(_carbsController.text),
                      dailyFats: double.parse(_fatsController.text),
                      mealsPerDay: int.parse(_mealsPerDayController.text),
                      dietaryRestrictions: _selectedRestrictions,
                    );
                    ref
                        .read(nutritionGoalsProvider.notifier)
                        .updateGoals(newGoals);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NutrientInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String unit;
  final IconData icon;

  const _NutrientInput({
    required this.controller,
    required this.label,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
