import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nutrition_provider.dart';
import '../widgets/meal_list_item.dart';
import '../widgets/filter_chip_list.dart';

class MealSearchPage extends ConsumerStatefulWidget {
  const MealSearchPage({super.key});

  @override
  ConsumerState<MealSearchPage> createState() => _MealSearchPageState();
}

class _MealSearchPageState extends ConsumerState<MealSearchPage> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nutritionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meals'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search meals...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    // TODO: Implement search functionality
                  },
                ),
                const SizedBox(height: 16),
                state.when(
                  initial: () => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (mealPlan, goals, categories, selectedCategory) {
                    return FilterChipList(
                      items: categories,
                      selectedItem: _selectedCategory,
                      onSelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                        ref
                            .read(nutritionProvider.notifier)
                            .filterByCategory(category);
                      },
                    );
                  },
                  error: (message) => Center(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (mealPlan, goals, categories, selectedCategory) {
                final filteredMeals = mealPlan.meals.where((meal) {
                  final matchesCategory = selectedCategory == null ||
                      selectedCategory == 'All' ||
                      meal.category == selectedCategory;
                  final matchesSearch = _searchController.text.isEmpty ||
                      meal.name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());
                  return matchesCategory && matchesSearch;
                }).toList();

                if (filteredMeals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No meals found',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredMeals.length,
                  itemBuilder: (context, index) {
                    final meal = filteredMeals[index];
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
        ],
      ),
    );
  }
}
