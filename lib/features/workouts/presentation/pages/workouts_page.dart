import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/workouts_provider.dart';
import '../widgets/workout_list_item.dart';
import '../widgets/filter_chip_list.dart';

class WorkoutsPage extends ConsumerStatefulWidget {
  const WorkoutsPage({super.key});

  @override
  ConsumerState<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends ConsumerState<WorkoutsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(workoutsProvider.notifier).loadWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workoutsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (workouts, categories, difficulties, selectedCategory,
              selectedDifficulty) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.background,
                  title: Text(
                    'Workouts',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  floating: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Implementar búsqueda
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FilterChipList(
                        items: categories,
                        selectedItem: selectedCategory ?? 'All',
                        onSelected: (category) {
                          ref
                              .read(workoutsProvider.notifier)
                              .filterByCategory(category);
                        },
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Difficulty',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FilterChipList(
                        items: difficulties,
                        selectedItem: selectedDifficulty ?? 'All',
                        onSelected: (difficulty) {
                          ref
                              .read(workoutsProvider.notifier)
                              .filterByDifficulty(difficulty);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final workout = workouts[index];
                        return WorkoutListItem(
                          workout: workout,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/workout-detail',
                              arguments: workout,
                            );
                          },
                        );
                      },
                      childCount: workouts.length,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 16.0),
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
                    ref.read(workoutsProvider.notifier).loadWorkouts();
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
