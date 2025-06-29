import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/trainer_product.dart';

abstract class TrainerProductsRepository {
  Future<Either<Failure, List<TrainerProduct>>> getProductsByTrainer(
      int trainerId);

  Future<Either<Failure, TrainerProduct>> getProductById(int productId);

  Future<Either<Failure, TrainerProduct>> createProduct(TrainerProduct product);

  Future<Either<Failure, TrainerProduct>> updateProduct(TrainerProduct product);

  Future<Either<Failure, void>> deleteProduct(int productId);

  Future<Either<Failure, void>> toggleProductStatus(
      int productId, ProductStatus status);

  Future<Either<Failure, List<TrainerProduct>>> searchProducts(
      int trainerId, String query);
}
