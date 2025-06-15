import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class UpdateNutritionGoalsUseCase {
  final NutritionRepository repository;

  UpdateNutritionGoalsUseCase(this.repository);

  Future<Either<Failure, void>> call(NutritionGoals goals) {
    return repository.updateNutritionGoals(goals);
  }
}
