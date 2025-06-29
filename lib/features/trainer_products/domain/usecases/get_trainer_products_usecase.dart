import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/trainer_product.dart';
import '../repositories/trainer_products_repository.dart';

class GetTrainerProductsUseCase implements UseCase<List<TrainerProduct>, int> {
  final TrainerProductsRepository repository;

  GetTrainerProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TrainerProduct>>> call(int trainerId) async {
    return await repository.getProductsByTrainer(trainerId);
  }
}
