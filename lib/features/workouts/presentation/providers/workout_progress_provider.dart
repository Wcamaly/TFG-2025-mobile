import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/workout_progress.dart';

final workoutProgressProvider =
    StateNotifierProvider<WorkoutProgressNotifier, AsyncValue<WorkoutProgress>>(
        (ref) {
  return WorkoutProgressNotifier();
});

final weeklyStatsProvider =
    StateNotifierProvider<WeeklyStatsNotifier, AsyncValue<WeeklyStats>>((ref) {
  return WeeklyStatsNotifier();
});

class WorkoutProgressNotifier
    extends StateNotifier<AsyncValue<WorkoutProgress>> {
  WorkoutProgressNotifier() : super(const AsyncValue.loading()) {
    _loadTodayProgress();
  }

  Future<void> _loadTodayProgress() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final progress = WorkoutProgress(
        date: DateTime.now().toIso8601String(),
        totalWorkouts: 5,
        completedWorkouts: 3,
        totalMinutes: 150,
        completedMinutes: 90,
        caloriesBurned: 350,
        progressPercentage: 60.0,
        goals: [
          const DailyGoal(
            id: '1',
            title: 'A Warm Welcome',
            description: 'Complete warm-up routine',
            isCompleted: true,
            order: 1,
            type: GoalType.warmUp,
          ),
          const DailyGoal(
            id: '2',
            title: 'Strength Essentials: Your First Routine',
            description: 'Complete strength training',
            isCompleted: true,
            order: 2,
            type: GoalType.strength,
          ),
          const DailyGoal(
            id: '3',
            title: 'Scoop of Joy',
            description: 'Complete cardio session',
            isCompleted: true,
            order: 3,
            type: GoalType.cardio,
          ),
          const DailyGoal(
            id: '4',
            title: '50 Push-Up Challenge',
            description: 'Complete 50 push-ups',
            isCompleted: false,
            order: 4,
            type: GoalType.strength,
          ),
          const DailyGoal(
            id: '5',
            title: 'Milk Before Nap',
            description: 'Complete cool-down routine',
            isCompleted: false,
            order: 5,
            type: GoalType.coolDown,
          ),
        ],
      );

      state = AsyncValue.data(progress);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleGoal(String goalId) async {
    state.whenData((progress) {
      final updatedGoals = progress.goals.map((goal) {
        if (goal.id == goalId) {
          return goal.copyWith(isCompleted: !goal.isCompleted);
        }
        return goal;
      }).toList();

      final completedCount =
          updatedGoals.where((goal) => goal.isCompleted).length;
      final newProgress = (completedCount / updatedGoals.length) * 100;

      final updatedProgress = progress.copyWith(
        goals: updatedGoals,
        progressPercentage: newProgress,
        completedWorkouts: completedCount,
      );

      state = AsyncValue.data(updatedProgress);
    });
  }

  Future<void> refreshProgress() async {
    state = const AsyncValue.loading();
    await _loadTodayProgress();
  }
}

class WeeklyStatsNotifier extends StateNotifier<AsyncValue<WeeklyStats>> {
  WeeklyStatsNotifier() : super(const AsyncValue.loading()) {
    _loadWeeklyStats();
  }

  Future<void> _loadWeeklyStats() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      final weeklyStats = WeeklyStats(
        days: [
          const DayStats(
              day: 'Mon',
              workouts: 2,
              minutes: 60,
              calories: 200,
              progress: 80),
          const DayStats(
              day: 'Tue',
              workouts: 1,
              minutes: 45,
              calories: 150,
              progress: 60),
          const DayStats(
              day: 'Wed', workouts: 0, minutes: 0, calories: 0, progress: 20),
          const DayStats(
              day: 'Thu',
              workouts: 3,
              minutes: 90,
              calories: 300,
              progress: 100),
          const DayStats(
              day: 'Fri',
              workouts: 1,
              minutes: 30,
              calories: 100,
              progress: 40),
          const DayStats(
              day: 'Sat',
              workouts: 2,
              minutes: 75,
              calories: 250,
              progress: 90),
        ],
        totalWorkouts: 9,
        totalMinutes: 300,
        totalCalories: 1000,
        averageProgress: 65.0,
      );

      state = AsyncValue.data(weeklyStats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshStats() async {
    state = const AsyncValue.loading();
    await _loadWeeklyStats();
  }
}
