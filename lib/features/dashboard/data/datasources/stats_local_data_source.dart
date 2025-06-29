import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/user_stats_table.dart' as db;
import '../../domain/entities/user_stats.dart';

abstract class StatsLocalDataSource {
  Future<UserStats?> getCurrentStats(int userId);
  Future<List<DailyProgress>> getWeeklyProgress(int userId);
  Future<void> updateStats(int userId, UserStats stats);
  Future<void> updateWeight(int userId, double weight);
  Future<void> updateCalories(int userId, int calories);
  Future<void> updateHeartRate(int userId, int heartRate);
  Future<void> updateSteps(int userId, int steps);
  Future<void> updateWorkoutMinutes(int userId, int minutes);
  Future<void> updateWorkoutsCompleted(int userId, int completed);
}

class StatsLocalDataSourceImpl implements StatsLocalDataSource {
  final AppDatabase _database;

  StatsLocalDataSourceImpl(this._database);

  @override
  Future<UserStats?> getCurrentStats(int userId) async {
    try {
      final dbStats = await _database.getCurrentUserStats(userId);
      if (dbStats == null) return null;

      final weeklyProgress = await getWeeklyProgress(userId);

      return UserStats(
        calories: dbStats.calories,
        heartRate: dbStats.heartRate,
        weight: dbStats.weight,
        workoutMinutes: dbStats.workoutMinutes,
        workoutsCompleted: dbStats.workoutsCompleted,
        weeklyProgress: weeklyProgress,
      );
    } catch (e) {
      print('Error getting current stats: $e');
      return null;
    }
  }

  @override
  Future<List<DailyProgress>> getWeeklyProgress(int userId) async {
    try {
      final dbProgress = await _database.getWeeklyProgress(userId);

      return dbProgress
          .map((dbItem) => DailyProgress(
                date: dbItem.date,
                calories: dbItem.calories,
                steps: dbItem.steps,
                weight: dbItem.weight,
              ))
          .toList();
    } catch (e) {
      print('Error getting weekly progress: $e');
      return [];
    }
  }

  @override
  Future<void> updateStats(int userId, UserStats stats) async {
    try {
      await _database.upsertUserStats(
        userId,
        calories: stats.calories,
        heartRate: stats.heartRate,
        weight: stats.weight,
        workoutMinutes: stats.workoutMinutes,
        workoutsCompleted: stats.workoutsCompleted,
        steps: stats.weeklyProgress.isNotEmpty
            ? stats.weeklyProgress.last.steps
            : 0,
      );
    } catch (e) {
      print('Error updating stats: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateWeight(int userId, double weight) async {
    try {
      await _database.upsertUserStats(userId, weight: weight);
    } catch (e) {
      print('Error updating weight: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCalories(int userId, int calories) async {
    try {
      await _database.upsertUserStats(userId, calories: calories);
    } catch (e) {
      print('Error updating calories: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateHeartRate(int userId, int heartRate) async {
    try {
      await _database.upsertUserStats(userId, heartRate: heartRate);
    } catch (e) {
      print('Error updating heart rate: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateSteps(int userId, int steps) async {
    try {
      await _database.upsertUserStats(userId, steps: steps);
    } catch (e) {
      print('Error updating steps: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateWorkoutMinutes(int userId, int minutes) async {
    try {
      await _database.upsertUserStats(userId, workoutMinutes: minutes);
    } catch (e) {
      print('Error updating workout minutes: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateWorkoutsCompleted(int userId, int completed) async {
    try {
      await _database.upsertUserStats(userId, workoutsCompleted: completed);
    } catch (e) {
      print('Error updating workouts completed: $e');
      rethrow;
    }
  }
}
