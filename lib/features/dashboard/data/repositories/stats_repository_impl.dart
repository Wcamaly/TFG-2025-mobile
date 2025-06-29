import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_local_data_source.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsLocalDataSource _localDataSource;
  final AppDatabase _database;

  StatsRepositoryImpl(this._localDataSource, this._database);

  // Obtener el ID del usuario autenticado desde la base de datos
  Future<int?> _getCurrentUserId() async {
    try {
      // Obtener el primer usuario activo (asumiendo que es el usuario actual)
      final users = await _database.getAllUsers();
      final activeUser = users.where((user) => user.isActive).firstOrNull;
      return activeUser?.id;
    } catch (e) {
      print('Error getting current user ID: $e');
      return null;
    }
  }

  @override
  Future<Either<Failure, UserStats>> getCurrentStats() async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        return Left(ServerFailure(message: 'Usuario no autenticado'));
      }

      final stats = await _localDataSource.getCurrentStats(userId);
      if (stats == null) {
        // Si no hay estadísticas, crear unas por defecto
        final defaultStats = UserStats(
          calories: 0,
          heartRate: 0,
          weight: 0.0,
          workoutMinutes: 0,
          workoutsCompleted: 0,
          weeklyProgress: [],
        );
        return Right(defaultStats);
      }

      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyProgress>>> getWeeklyProgress() async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        return Left(ServerFailure(message: 'Usuario no autenticado'));
      }

      final progress = await _localDataSource.getWeeklyProgress(userId);
      return Right(progress);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWeight(double weight) async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        return Left(ServerFailure(message: 'Usuario no autenticado'));
      }

      await _localDataSource.updateWeight(userId, weight);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCalories(int calories) async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        return Left(ServerFailure(message: 'Usuario no autenticado'));
      }

      await _localDataSource.updateCalories(userId, calories);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHeartRate(int heartRate) async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        return Left(ServerFailure(message: 'Usuario no autenticado'));
      }

      await _localDataSource.updateHeartRate(userId, heartRate);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
