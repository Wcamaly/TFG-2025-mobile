import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_2025_mobile/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:tfg_2025_mobile/features/dashboard/presentation/widgets/nutrition_card.dart';
import 'package:tfg_2025_mobile/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:tfg_2025_mobile/features/dashboard/presentation/widgets/workout_card.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    return SafeArea(
      child: state.when(
        initial: () => const SizedBox(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (stats) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                floating: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Progress',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      StatsCard(stats: stats),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Workouts',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          // Solo mostrar "See All" si hay workouts
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.pushNamed(context, '/workouts');
                          //   },
                          //   child: const Text('See All'),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Empty state - no workouts
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                Theme.of(context).dividerColor.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No Workouts Yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Find a personal trainer to start your fitness journey',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/trainer-search');
                                },
                                icon: const Icon(Icons.search),
                                label: const Text('Find a Trainer'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nutrition',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              // Implementar navegación a nutrición
                            },
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const NutritionCard(
                        calories: 2000,
                      ),
                    ],
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
                  ref.read(dashboardProvider.notifier).loadStats();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
