import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/nutrition_stats_provider.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/nutrition_overview_card.dart';
import '../widgets/quick_food_search.dart';
import '../widgets/daily_nutrition_summary.dart';
import 'food_analytics_page.dart';
import 'user_profile_page.dart';
import 'nutrition_stats_page.dart';

class NutritionMainPage extends ConsumerStatefulWidget {
  const NutritionMainPage({super.key});

  @override
  ConsumerState<NutritionMainPage> createState() => _NutritionMainPageState();
}

class _NutritionMainPageState extends ConsumerState<NutritionMainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(nutritionStatsProvider.notifier).loadDailyStats(DateTime.now());
      ref.read(userProfileProvider.notifier).loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final nutritionState = ref.watch(nutritionStatsProvider);
    final profileState = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Nutrition',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfilePage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.analytics, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NutritionStatsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Quick Food Search
                  QuickFoodSearch(
                    onFoodAnalyze: (foodId, quantity) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodAnalyticsPage(
                            initialFoodId: foodId,
                            initialQuantity: quantity,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Today's Nutrition Overview
                  nutritionState.when(
                    initial: () => const SizedBox(),
                    loading: () => const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    ),
                    loaded: (stats) => NutritionOverviewCard(
                      stats: stats,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NutritionStatsPage(),
                          ),
                        );
                      },
                    ),
                    error: (message) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Error loading nutrition data: $message',
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Daily Nutrition Summary
                  nutritionState.whenOrNull(
                        loaded: (stats) => DailyNutritionSummary(
                          stats: stats,
                          onAddFood: () {
                            print('DEBUG: Add Food button pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FoodAnalyticsPage(),
                              ),
                            );
                          },
                        ),
                      ) ??
                      const SizedBox(),

                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildQuickActions(context),

                  const SizedBox(height: 24),

                  // Profile Summary
                  profileState.whenOrNull(
                        loaded: (profile) =>
                            _buildProfileSummary(context, profile),
                      ) ??
                      const SizedBox(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Food Analytics',
                subtitle: 'Analyze food nutrition',
                icon: Icons.analytics,
                color: AppColors.primary,
                onTap: () {
                  print('DEBUG: Food Analytics button pressed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FoodAnalyticsPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Statistics',
                subtitle: 'View nutrition stats',
                icon: Icons.bar_chart,
                color: Colors.blue,
                onTap: () {
                  print('DEBUG: Statistics button pressed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NutritionStatsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Profile & BMI',
                subtitle: 'Manage your profile',
                icon: Icons.person_outline,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Compare Foods',
                subtitle: 'Compare nutrition',
                icon: Icons.compare_arrows,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FoodAnalyticsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSummary(BuildContext context, profile) {
    // Calculate BMI for display
    final heightInMeters = profile.height / 100.0;
    final bmi = profile.weight / (heightInMeters * heightInMeters);

    String bmiCategory;
    Color bmiColor;

    if (bmi < 18.5) {
      bmiCategory = 'Underweight';
      bmiColor = Colors.blue;
    } else if (bmi < 25.0) {
      bmiCategory = 'Normal';
      bmiColor = Colors.green;
    } else if (bmi < 30.0) {
      bmiCategory = 'Overweight';
      bmiColor = Colors.orange;
    } else {
      bmiCategory = 'Obese';
      bmiColor = Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Summary',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: Text(
                      profile.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : 'U',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${profile.age} years old, ${profile.gender}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '${profile.weight.toStringAsFixed(1)} kg, ${profile.height.toStringAsFixed(0)} cm',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: bmiColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: bmiColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'BMI',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            bmi.toStringAsFixed(1),
                            style: AppTextStyles.headlineLarge.copyWith(
                              color: bmiColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            bmiCategory,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: bmiColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Goal',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getGoalLabel(profile.goal),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getGoalLabel(String goal) {
    switch (goal) {
      case 'lose_weight':
        return 'Lose Weight';
      case 'maintain_weight':
        return 'Maintain Weight';
      case 'gain_weight':
        return 'Gain Weight';
      case 'gain_muscle':
        return 'Gain Muscle';
      default:
        return goal;
    }
  }
}
