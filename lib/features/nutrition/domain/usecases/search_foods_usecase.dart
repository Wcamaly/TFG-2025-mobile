import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class SearchFoodsUseCase {
  final NutritionRepository repository;

  SearchFoodsUseCase(this.repository);

  Future<Either<Failure, List<Food>>> call(String query) {
    return repository.searchFoods(query);
  }
}
