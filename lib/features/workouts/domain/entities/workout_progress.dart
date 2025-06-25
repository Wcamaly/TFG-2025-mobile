import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_progress.freezed.dart';

@freezed
class WorkoutProgress with _$WorkoutProgress {
  const factory WorkoutProgress({
    required String date,
    required int totalWorkouts,
    required int completedWorkouts,
    required int totalMinutes,
    required int completedMinutes,
    required int caloriesBurned,
    required double progressPercentage,
    required List<DailyGoal> goals,
  }) = _WorkoutProgress;
}

@freezed
class DailyGoal with _$DailyGoal {
  const factory DailyGoal({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required int order,
    GoalType? type,
  }) = _DailyGoal;
}

enum GoalType {
  warmUp,
  strength,
  cardio,
  coolDown,
}

@freezed
class WeeklyStats with _$WeeklyStats {
  const factory WeeklyStats({
    required List<DayStats> days,
    required int totalWorkouts,
    required int totalMinutes,
    required int totalCalories,
    required double averageProgress,
  }) = _WeeklyStats;
}

@freezed
class DayStats with _$DayStats {
  const factory DayStats({
    required String day,
    required int workouts,
    required int minutes,
    required int calories,
    required double progress,
  }) = _DayStats;
}
