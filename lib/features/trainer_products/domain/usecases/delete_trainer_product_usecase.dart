import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/trainer_products_repository.dart';

class DeleteTrainerProductUseCase implements UseCase<void, int> {
  final TrainerProductsRepository repository;

  DeleteTrainerProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int productId) async {
    return await repository.deleteProduct(productId);
  }
}
