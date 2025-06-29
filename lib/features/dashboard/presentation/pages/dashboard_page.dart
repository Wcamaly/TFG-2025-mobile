import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/stats_card_simple.dart';
import '../widgets/workout_card.dart';
import '../widgets/nutrition_card_simple.dart';
import '../widgets/todays_routines_card.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../trainers/presentation/pages/trainer_search_page.dart';
import '../../../workouts/presentation/pages/workouts_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'tabs/nutrition_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../onboarding/presentation/providers/onboarding_provider.dart';
import '../providers/dashboard_routines_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print('🏠 DashboardPage: initState called');

    // Agregar un post frame callback para ejecutar después del build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _debugDashboardState();
    });
  }

  void _debugDashboardState() {
    print('🔍 DashboardPage: Debugging dashboard state...');

    // Debug del estado de autenticación
    final authState = ref.read(authProvider);
    authState.when(
      initial: () => print('   🔐 Auth State: Initial'),
      loading: () => print('   🔐 Auth State: Loading'),
      authenticated: (user) {
        print('   🔐 Auth State: Authenticated');
        print('      User ID: ${user.id}');
        print('      User Email: ${user.email}');
        print('      User Name: ${user.name}');
      },
      unauthenticated: (message) =>
          print('   🔐 Auth State: Unauthenticated - $message'),
    );

    // Debug del estado del dashboard
    final dashboardState = ref.read(dashboardProvider);
    dashboardState.when(
      initial: () => print('   📊 Dashboard State: Initial'),
      loading: () => print('   📊 Dashboard State: Loading'),
      loaded: (stats) {
        print('   📊 Dashboard State: Loaded');
        print('      Calories: ${stats.calories}');
        print('      Weekly Progress: ${stats.weeklyProgress.length} entries');
      },
      error: (message) => print('   📊 Dashboard State: Error - $message'),
    );

    // Debug del estado de las rutinas
    final routinesState = ref.read(dashboardRoutinesProvider);
    print('   💪 Routines State:');
    print('      Loading: ${routinesState.isLoading}');
    print('      Error: ${routinesState.error}');
    print('      Routines Count: ${routinesState.routines.length}');

    for (int i = 0; i < routinesState.routines.length; i++) {
      final routine = routinesState.routines[i];
      print('      Routine $i: ${routine.name} (ID: ${routine.id})');
    }
  }

  List<Widget> get _pages => [
        HomeTab(
          onNavigateToTrainers: () {
            print('🏠 DashboardPage: Navigating to trainers');
            setState(() {
              _currentIndex = 1;
            });
          },
          onNavigateToWorkouts: () {
            print('🏠 DashboardPage: Navigating to workouts');
            setState(() {
              _currentIndex = 2;
            });
          },
          onNavigateToNutrition: () {
            print('🏠 DashboardPage: Navigating to nutrition');
            setState(() {
              _currentIndex = 3;
            });
          },
        ),
        const TrainerSearchPage(),
        const WorkoutsPage(),
        const NutritionTab(),
      ];

  @override
  Widget build(BuildContext context) {
    print('🏠 DashboardPage: Building dashboard page');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          print('🏠 DashboardPage: Bottom navigation tapped - index: $index');
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            label: 'findTrainer'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center_outlined),
            activeIcon: const Icon(Icons.fitness_center),
            label: 'yourWorkouts'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_menu_outlined),
            activeIcon: const Icon(Icons.restaurant_menu),
            label: 'nutrition'.tr(),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends ConsumerWidget {
  final VoidCallback onNavigateToTrainers;
  final VoidCallback onNavigateToWorkouts;
  final VoidCallback onNavigateToNutrition;

  const HomeTab({
    super.key,
    required this.onNavigateToTrainers,
    required this.onNavigateToWorkouts,
    required this.onNavigateToNutrition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('🏠 HomeTab: Building home tab');

    final dashboardState = ref.watch(dashboardProvider);
    final authState = ref.watch(authProvider);

    // Debug del estado de autenticación en HomeTab
    authState.when(
      initial: () => print('🏠 HomeTab: Auth State - Initial'),
      loading: () => print('🏠 HomeTab: Auth State - Loading'),
      authenticated: (user) {
        print('🏠 HomeTab: Auth State - Authenticated');
        print('   User ID: ${user.id}');
        print('   User Email: ${user.email}');
      },
      unauthenticated: (message) =>
          print('🏠 HomeTab: Auth State - Unauthenticated: $message'),
    );

    // Debug del estado del dashboard en HomeTab
    dashboardState.when(
      initial: () => print('🏠 HomeTab: Dashboard State - Initial'),
      loading: () => print('🏠 HomeTab: Dashboard State - Loading'),
      loaded: (stats) {
        print('🏠 HomeTab: Dashboard State - Loaded');
        print('   Calories: ${stats.calories}');
        print('   Weekly Progress Entries: ${stats.weeklyProgress.length}');
      },
      error: (message) =>
          print('🏠 HomeTab: Dashboard State - Error: $message'),
    );

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
                      'welcomeBack'.tr(),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'John Doe',
                      style: AppTextStyles.displayMedium,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print('🏠 HomeTab: Profile avatar tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authProvider);
                      return authState.when(
                        initial: () => const CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.surfaceLight,
                          child: Icon(
                            Icons.person,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        loading: () => const CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.surfaceLight,
                          child: Icon(
                            Icons.person,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        authenticated: (user) => CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary,
                          backgroundImage: user.photoUrl != null
                              ? NetworkImage(user.photoUrl!)
                              : null,
                          child: user.photoUrl == null
                              ? Text(
                                  user.name.isNotEmpty
                                      ? user.name[0].toUpperCase()
                                      : 'U',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        unauthenticated: (message) => const CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.surfaceLight,
                          child: Icon(
                            Icons.person,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'todaysStats'.tr(),
              style: AppTextStyles.headlineLarge,
            ),
            const SizedBox(height: 16),
            dashboardState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (stats) => Row(
                children: [
                  Expanded(
                    child: StatsCardSimple(
                      icon: Icons.local_fire_department,
                      value: stats.calories.toString(),
                      unit: 'kcal',
                      label: 'caloriesBurned'.tr(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatsCardSimple(
                      icon: Icons.directions_run,
                      value: stats.weeklyProgress.isNotEmpty
                          ? stats.weeklyProgress.last.steps.toString()
                          : '0',
                      unit: 'steps',
                      label: 'steps'.tr(),
                    ),
                  ),
                ],
              ),
              error: (message) => Center(
                child: Column(
                  children: [
                    Text(
                      'Error: $message',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        print('🏠 HomeTab: Retry button pressed');
                        ref.read(dashboardProvider.notifier).refreshStats();
                      },
                      child: Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TodaysRoutinesCard(
              onNavigateToWorkouts: onNavigateToWorkouts,
            ),
            const SizedBox(height: 24),
            Text(
              'nutrition'.tr(),
              style: AppTextStyles.headlineLarge,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                print('🏠 HomeTab: Nutrition card tapped');
                onNavigateToNutrition();
              },
              child: const NutritionCardSimple(
                calories: 1450,
                protein: 85,
                carbs: 180,
                fats: 65,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
