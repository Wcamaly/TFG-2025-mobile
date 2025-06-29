import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/trainer_product.dart';
import '../../domain/repositories/trainer_products_repository.dart';
import '../datasources/trainer_products_local_data_source.dart';

class TrainerProductsRepositoryImpl implements TrainerProductsRepository {
  final TrainerProductsLocalDataSource localDataSource;

  TrainerProductsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<TrainerProduct>>> getProductsByTrainer(
      int trainerId) async {
    try {
      final products = await localDataSource.getProductsByTrainer(trainerId);
      return Right(products);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerProduct>> getProductById(int productId) async {
    try {
      final product = await localDataSource.getProductById(productId);
      if (product != null) {
        return Right(product);
      } else {
        return Left(NotFoundFailure(message: 'Product not found'));
      }
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message ?? 'Product not found'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerProduct>> createProduct(
      TrainerProduct product) async {
    try {
      final createdProduct = await localDataSource.createProduct(product);
      return Right(createdProduct);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerProduct>> updateProduct(
      TrainerProduct product) async {
    try {
      final updatedProduct = await localDataSource.updateProduct(product);
      return Right(updatedProduct);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int productId) async {
    try {
      await localDataSource.deleteProduct(productId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleProductStatus(
      int productId, ProductStatus status) async {
    try {
      await localDataSource.toggleProductStatus(productId, status);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrainerProduct>>> searchProducts(
      int trainerId, String query) async {
    try {
      final products = await localDataSource.searchProducts(trainerId, query);
      return Right(products);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}
