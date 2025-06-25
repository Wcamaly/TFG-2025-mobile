import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/meal.dart';
import '../providers/food_analytics_provider.dart';
import '../widgets/food_analytics_card.dart';
import '../widgets/food_search_bar.dart';
import '../widgets/food_comparison_widget.dart';

class FoodAnalyticsPage extends ConsumerStatefulWidget {
  final String? initialFoodId;
  final double? initialQuantity;

  const FoodAnalyticsPage({
    super.key,
    this.initialFoodId,
    this.initialQuantity,
  });

  @override
  ConsumerState<FoodAnalyticsPage> createState() => _FoodAnalyticsPageState();
}

class _FoodAnalyticsPageState extends ConsumerState<FoodAnalyticsPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<String> _selectedFoodsForComparison = [];
  bool _isComparisonMode = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialFoodId != null) {
      _quantityController.text = widget.initialQuantity?.toString() ?? '100';
      Future.microtask(() {
        ref.read(foodAnalyticsProvider.notifier).analyzeFoodQuantity(
              foodId: widget.initialFoodId!,
              quantity: widget.initialQuantity ?? 100.0,
            );
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(foodAnalyticsProvider);
    final searchState = ref.watch(foodSearchProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Food Analytics',
          style: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isComparisonMode ? Icons.analytics : Icons.compare_arrows,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isComparisonMode = !_isComparisonMode;
                if (!_isComparisonMode) {
                  _selectedFoodsForComparison.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FoodSearchBar(
                  controller: _searchController,
                  onSearch: (query) {
                    if (query.isNotEmpty) {
                      ref.read(foodSearchProvider.notifier).searchFoods(query);
                    }
                  },
                ),
                const SizedBox(height: 16),
                if (_searchController.text.isNotEmpty) ...[
                  Container(
                    height: 120,
                    child: searchState.when(
                      initial: () => const SizedBox(),
                      loading: () => const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary),
                      ),
                      loaded: (foods) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return GestureDetector(
                            onTap: () {
                              if (_isComparisonMode) {
                                _toggleFoodForComparison(food.id);
                              } else {
                                _analyzeFood(food.id);
                              }
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: _selectedFoodsForComparison
                                        .contains(food.id)
                                    ? AppColors.primary.withOpacity(0.3)
                                    : AppColors.surfaceDark,
                                borderRadius: BorderRadius.circular(12),
                                border: _selectedFoodsForComparison
                                        .contains(food.id)
                                    ? Border.all(
                                        color: AppColors.primary, width: 2)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(food.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    food.name,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      error: (message) => Center(
                        child: Text(
                          message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),

          // Quantity Input
          if (!_isComparisonMode) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Cantidad (gramos)',
                        labelStyle: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      final quantity =
                          double.tryParse(_quantityController.text);
                      if (quantity != null &&
                          _searchController.text.isNotEmpty) {
                        // Analyze the first food in search results
                        searchState.whenOrNull(
                          loaded: (foods) {
                            if (foods.isNotEmpty) {
                              _analyzeFood(foods.first.id, quantity);
                            }
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Analizar',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Comparison Mode Controls
          if (_isComparisonMode && _selectedFoodsForComparison.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Cantidad para comparar (gramos)',
                        labelStyle: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      final quantity =
                          double.tryParse(_quantityController.text) ?? 100.0;
                      ref.read(foodAnalyticsProvider.notifier).compareFoods(
                            foodIds: _selectedFoodsForComparison,
                            quantity: quantity,
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Comparar',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: _selectedFoodsForComparison.map((foodId) {
                  return Chip(
                    label: Text(foodId),
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    labelStyle:
                        AppTextStyles.bodySmall.copyWith(color: Colors.white),
                    deleteIcon:
                        const Icon(Icons.close, color: Colors.white, size: 18),
                    onDeleted: () => _toggleFoodForComparison(foodId),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Analytics Results
          Expanded(
            child: state.when(
              initial: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: Colors.white24,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Busca un alimento para analizar',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
              loaded: (analytics) => _isComparisonMode && analytics.length > 1
                  ? FoodComparisonWidget(analytics: analytics)
                  : analytics.isNotEmpty
                      ? FoodAnalyticsCard(analytics: analytics.first)
                      : const SizedBox(),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
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

  void _analyzeFood(String foodId, [double? quantity]) {
    final qty = quantity ?? double.tryParse(_quantityController.text) ?? 100.0;
    ref.read(foodAnalyticsProvider.notifier).analyzeFoodQuantity(
          foodId: foodId,
          quantity: qty,
        );
  }

  void _toggleFoodForComparison(String foodId) {
    setState(() {
      if (_selectedFoodsForComparison.contains(foodId)) {
        _selectedFoodsForComparison.remove(foodId);
      } else {
        if (_selectedFoodsForComparison.length < 3) {
          _selectedFoodsForComparison.add(foodId);
        }
      }
    });
  }
}
