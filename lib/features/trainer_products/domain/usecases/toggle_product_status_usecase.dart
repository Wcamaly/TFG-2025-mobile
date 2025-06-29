import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/trainer_product.dart';
import '../repositories/trainer_products_repository.dart';

class ToggleProductStatusUseCase
    implements UseCase<void, ToggleProductStatusParams> {
  final TrainerProductsRepository repository;

  ToggleProductStatusUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleProductStatusParams params) async {
    return await repository.toggleProductStatus(
        params.productId, params.status);
  }
}

class ToggleProductStatusParams {
  final int productId;
  final ProductStatus status;

  ToggleProductStatusParams({
    required this.productId,
    required this.status,
  });
}
