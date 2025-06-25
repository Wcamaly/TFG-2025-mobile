import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class AnalyzeFoodUseCase {
  final NutritionRepository repository;

  AnalyzeFoodUseCase(this.repository);

  Future<Either<Failure, FoodAnalytics>> call({
    required String foodId,
    required double quantity,
  }) {
    return repository.analyzeFoodQuantity(
      foodId: foodId,
      quantity: quantity,
    );
  }
}
