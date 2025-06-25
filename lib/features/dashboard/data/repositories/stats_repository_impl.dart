import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource remoteDataSource;

  StatsRepositoryImpl(this.remoteDataSource);

  static final _mockStats = UserStats(
    calories: 1800,
    heartRate: 75,
    weight: 70.5,
    workoutMinutes: 45,
    workoutsCompleted: 3,
    weeklyProgress: [
      DailyProgress(
        date: DateTime(2024, 3, 1),
        calories: 1800,
        steps: 8000,
        weight: 70.5,
      ),
      DailyProgress(
        date: DateTime(2024, 3, 2),
        calories: 2000,
        steps: 10000,
        weight: 70.4,
      ),
    ],
  );

  @override
  Future<Either<Failure, UserStats>> getCurrentStats() async {
    try {
      final stats = await remoteDataSource.getCurrentStats();
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateStats(UserStats stats) async {
    try {
      await remoteDataSource.updateStats(stats);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyProgress>>> getWeeklyProgress() async {
    try {
      return Right(_mockStats.weeklyProgress);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWeight(double weight) async {
    try {
      // Aquí actualizarías el peso en una implementación real
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCalories(int calories) async {
    try {
      // Aquí actualizarías las calorías en una implementación real
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHeartRate(int heartRate) async {
    try {
      // Aquí actualizarías la frecuencia cardíaca en una implementación real
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
