import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int calories,
    required int heartRate,
    required double weight,
    required int workoutMinutes,
    required int workoutsCompleted,
    required List<DailyProgress> weeklyProgress,
  }) = _UserStats;
}

@freezed
class DailyProgress with _$DailyProgress {
  const factory DailyProgress({
    required DateTime date,
    required int calories,
    required int steps,
    required double weight,
  }) = _DailyProgress;
}
