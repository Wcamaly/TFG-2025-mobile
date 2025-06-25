import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class CalculateBMIUseCase {
  final NutritionRepository repository;

  CalculateBMIUseCase(this.repository);

  Future<Either<Failure, BMIData>> call({
    required double weight,
    required double height,
  }) {
    return repository.calculateBMI(
      weight: weight,
      height: height,
    );
  }
}
