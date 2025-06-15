import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource remoteDataSource;

  StatsRepositoryImpl(this.remoteDataSource);

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
