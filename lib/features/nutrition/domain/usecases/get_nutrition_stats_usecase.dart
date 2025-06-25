import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionStatsUseCase {
  final NutritionRepository repository;

  GetNutritionStatsUseCase(this.repository);

  Future<Either<Failure, NutritionStats>> call(DateTime date) {
    return repository.getDailyNutritionStats(date);
  }
}
