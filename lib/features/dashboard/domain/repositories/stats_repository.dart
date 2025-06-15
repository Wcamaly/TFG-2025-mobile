import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_stats.dart';

abstract class StatsRepository {
  Future<Either<Failure, UserStats>> getCurrentStats();
  Future<Either<Failure, List<DailyProgress>>> getWeeklyProgress();
  Future<Either<Failure, void>> updateWeight(double weight);
  Future<Either<Failure, void>> updateCalories(int calories);
  Future<Either<Failure, void>> updateHeartRate(int heartRate);
}
