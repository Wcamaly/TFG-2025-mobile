import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/trainer_product.dart';
import '../repositories/trainer_products_repository.dart';

class UpdateTrainerProductUseCase
    implements UseCase<TrainerProduct, TrainerProduct> {
  final TrainerProductsRepository repository;

  UpdateTrainerProductUseCase(this.repository);

  @override
  Future<Either<Failure, TrainerProduct>> call(TrainerProduct product) async {
    return await repository.updateProduct(product);
  }
}
