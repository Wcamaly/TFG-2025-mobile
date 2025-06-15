import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nutrition_provider.dart';
import '../widgets/daily_meal_plan_card.dart';
import '../widgets/nutrition_goals_card.dart';
import '../widgets/meal_list_item.dart';
import '../widgets/filter_chip_list.dart';

class NutritionPage extends ConsumerStatefulWidget {
  const NutritionPage({super.key});

  @override
  ConsumerState<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends ConsumerState<NutritionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(nutritionProvider.notifier).loadNutritionData(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nutritionProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (mealPlan, goals, categories, selectedCategory) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    'Nutrition',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  floating: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, '/nutrition-settings');
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NutritionGoalsCard(goals: goals),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today\'s Meal Plan',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/meal-schedule');
                              },
                              icon: const Icon(Icons.calendar_month),
                              label: const Text('Schedule'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DailyMealPlanCard(mealPlan: mealPlan),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Meals',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/meal-search');
                              },
                              child: const Text('Search'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        FilterChipList(
                          items: categories,
                          selectedItem: selectedCategory ?? 'All',
                          onSelected: (category) {
                            ref
                                .read(nutritionProvider.notifier)
                                .filterByCategory(category);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final meal = mealPlan.meals[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MealListItem(
                            meal: meal,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/meal-detail',
                                arguments: meal.mealId,
                              );
                            },
                          ),
                        );
                      },
                      childCount: mealPlan.meals.length,
                    ),
                  ),
                ),
              ],
            );
          },
          error: (message) => Center(
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
                  message,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.red,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(nutritionProvider.notifier)
                        .loadNutritionData(DateTime.now());
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
