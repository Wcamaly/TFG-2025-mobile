import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_stats.dart';
import '../repositories/stats_repository.dart';

class GetCurrentStatsUseCase {
  final StatsRepository repository;

  GetCurrentStatsUseCase(this.repository);

  Future<Either<Failure, UserStats>> call() async {
    return repository.getCurrentStats();
  }
}
