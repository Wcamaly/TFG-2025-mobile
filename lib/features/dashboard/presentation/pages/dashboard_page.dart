import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/stats_card_simple.dart';
import '../widgets/workout_card.dart';
import '../widgets/nutrition_card_simple.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../trainers/presentation/pages/trainer_search_page.dart';
import '../../../workouts/presentation/pages/workouts_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'tabs/nutrition_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
        HomeTab(onNavigateToTrainers: () {
          setState(() {
            _currentIndex = 1;
          });
        }),
        const TrainerSearchPage(),
        const WorkoutsPage(),
        const NutritionTab(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Trainers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            activeIcon: Icon(Icons.restaurant_menu),
            label: 'Nutrition',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends ConsumerWidget {
  final VoidCallback onNavigateToTrainers;

  const HomeTab({
    super.key,
    required this.onNavigateToTrainers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(dashboardProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'John Doe',
                      style: AppTextStyles.displayMedium,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.surfaceLight,
                    child: Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.todaysStats,
              style: AppTextStyles.headlineLarge,
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: StatsCardSimple(
                    icon: Icons.local_fire_department,
                    value: '350',
                    unit: 'kcal',
                    label: 'Calories Burned',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StatsCardSimple(
                    icon: Icons.directions_run,
                    value: '5,230',
                    unit: 'steps',
                    label: 'Steps',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Workouts',
                  style: AppTextStyles.headlineLarge,
                ),
                TextButton(
                  onPressed: onNavigateToTrainers,
                  child: const Text('Find More'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 280,
                    child: const WorkoutCard(
                      title: 'Full Body Workout',
                      duration: '45 min',
                      difficulty: 'Intermediate',
                      imageUrl: '',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 280,
                    child: const WorkoutCard(
                      title: 'HIIT Training',
                      duration: '30 min',
                      difficulty: 'Advanced',
                      imageUrl: '',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nutrition',
                  style: AppTextStyles.headlineLarge,
                ),
                TextButton(
                  onPressed: () {
                    // Navegar a la sección de nutrición
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
