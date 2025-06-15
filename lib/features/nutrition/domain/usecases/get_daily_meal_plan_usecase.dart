import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetDailyMealPlanUseCase {
  final NutritionRepository repository;

  GetDailyMealPlanUseCase(this.repository);

  Future<Either<Failure, DailyMealPlan>> call(DateTime date) {
    return repository.getDailyMealPlan(date);
  }
}
