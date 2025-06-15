import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionGoalsUseCase {
  final NutritionRepository repository;

  GetNutritionGoalsUseCase(this.repository);

  Future<Either<Failure, NutritionGoals>> call() {
    return repository.getNutritionGoals();
  }
}
