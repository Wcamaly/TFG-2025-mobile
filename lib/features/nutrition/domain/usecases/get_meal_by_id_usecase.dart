import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetMealByIdUseCase {
  final NutritionRepository repository;

  GetMealByIdUseCase(this.repository);

  Future<Either<Failure, Meal>> call(String id) {
    return repository.getMealById(id);
  }
}
