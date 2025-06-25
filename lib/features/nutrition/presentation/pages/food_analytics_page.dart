import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/food_analytics_provider.dart';
import '../widgets/food_search_bar.dart';
import '../widgets/food_analytics_card.dart';
import '../../domain/entities/meal.dart';

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
  Food? _selectedFood;

  @override
  void initState() {
    super.initState();
    _quantityController.text = widget.initialQuantity?.toString() ?? '100';
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  // Helper method to get category-specific icons
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'protein':
        return Icons.set_meal;
      case 'fruit':
        return Icons.apple;
      case 'vegetable':
        return Icons.eco;
      case 'grain':
        return Icons.grain;
      case 'dairy':
        return Icons.local_drink;
      case 'nuts':
        return Icons.scatter_plot;
      default:
        return Icons.restaurant;
    }
  }

  // Helper method to get category-specific colors
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'protein':
        return Colors.red.shade400;
      case 'fruit':
        return Colors.orange.shade400;
      case 'vegetable':
        return Colors.green.shade400;
      case 'grain':
        return Colors.amber.shade400;
      case 'dairy':
        return Colors.blue.shade400;
      case 'nuts':
        return Colors.brown.shade400;
      default:
        return AppColors.primary;
    }
  }

  // Helper method to build food image/icon
  Widget _buildFoodIcon(Food food, {double size = 50}) {
    final categoryColor = _getCategoryColor(food.category);
    final categoryIcon = _getCategoryIcon(food.category);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: categoryColor.withOpacity(0.2),
        border: Border.all(
          color: categoryColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Icon(
        categoryIcon,
        color: categoryColor,
        size: size * 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(foodSearchProvider);
    final analyticsState = ref.watch(foodAnalyticsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Food',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search for a food item and enter the quantity to analyze its nutritional content',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search Section
            Text(
              'Search Food',
              style: AppTextStyles.headlineMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            FoodSearchBar(
              controller: _searchController,
              onSearch: (query) {
                if (query.isNotEmpty) {
                  ref.read(foodSearchProvider.notifier).searchFoods(query);
                } else {
                  ref.read(foodSearchProvider.notifier).clearSearch();
                }
              },
              hintText:
                  'Search for foods (e.g., apple, chicken breast, rice)...',
            ),

            const SizedBox(height: 16),

            // Search Results
            searchState.when(
              initial: () => _buildInitialSearchState(),
              loading: () => _buildLoadingState(),
              loaded: (foods) => _buildSearchResults(foods),
              error: (message) => _buildErrorState(message),
            ),

            // Selected Food & Quantity Section
            if (_selectedFood != null) ...[
              const SizedBox(height: 32),
              Text(
                'Selected Food',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildSelectedFoodCard(),
              const SizedBox(height: 24),
              _buildQuantitySection(),
              const SizedBox(height: 24),
              _buildAnalyzeButton(),
            ],

            // Analytics Results
            const SizedBox(height: 24),
            analyticsState.when(
              initial: () => const SizedBox(),
              loading: () => _buildAnalyticsLoading(),
              loaded: (analytics) => _buildAnalyticsResults(analytics),
              error: (message) => _buildAnalyticsError(message),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialSearchState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white54,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Start typing to search for foods...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }

  Widget _buildSearchResults(List<Food> foods) {
    if (foods.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_off,
              color: Colors.orange,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No foods found for "${_searchController.text}". Try different keywords.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results (${foods.length})',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...foods.map((food) => _buildFoodResultItem(food)).toList(),
      ],
    );
  }

  Widget _buildFoodResultItem(Food food) {
    final isSelected = _selectedFood?.id == food.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFood = food;
        });
        // Clear any previous analytics
        ref.read(foodAnalyticsProvider.notifier).reset();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppColors.primary : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildFoodIcon(food),
            const SizedBox(width: 16),
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
                    '${food.caloriesPer100g} kcal per 100g',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'P: ${food.proteinPer100g.toStringAsFixed(1)}g • C: ${food.carbsPer100g.toStringAsFixed(1)}g • F: ${food.fatsPer100g.toStringAsFixed(1)}g',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFoodCard() {
    if (_selectedFood == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildFoodIcon(_selectedFood!, size: 60),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedFood!.name,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Category: ${_selectedFood!.category}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedFood = null;
              });
              ref.read(foodAnalyticsProvider.notifier).reset();
            },
            child: Text(
              'Change',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter quantity',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  'grams',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Quick quantity buttons
        Row(
          children: [
            _buildQuickQuantityButton('50g', 50),
            const SizedBox(width: 8),
            _buildQuickQuantityButton('100g', 100),
            const SizedBox(width: 8),
            _buildQuickQuantityButton('150g', 150),
            const SizedBox(width: 8),
            _buildQuickQuantityButton('200g', 200),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickQuantityButton(String label, int quantity) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _quantityController.text = quantity.toString();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedFood != null && _quantityController.text.isNotEmpty
            ? () {
                final quantity = double.tryParse(_quantityController.text) ?? 0;
                if (quantity > 0) {
                  ref.read(foodAnalyticsProvider.notifier).analyzeFoodQuantity(
                        foodId: _selectedFood!.id,
                        quantity: quantity,
                      );
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Analyze Nutrition',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsLoading() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text(
              'Analyzing nutrition...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsResults(List<FoodAnalytics> analytics) {
    if (analytics.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Analysis',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        FoodAnalyticsCard(analytics: analytics.first),
        const SizedBox(height: 24),
        _buildAddToMealButton(analytics.first),
      ],
    );
  }

  Widget _buildAddToMealButton(FoodAnalytics analytics) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement add to meal functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('${analytics.food.name} added to your daily nutrition!'),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'View Stats',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/nutrition-stats');
                },
              ),
            ),
          );
          Navigator.pop(context);
        },
        icon: const Icon(Icons.add_circle, color: Colors.white),
        label: Text(
          'Add to Today\'s Meals',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsError(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search error: $message',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
