import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../datasources/trainer_remote_data_source.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final TrainerRemoteDataSource remoteDataSource;

  TrainerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Trainer>>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    try {
      final trainers = await remoteDataSource.getNearbyTrainers(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );
      return Right(trainers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Trainer>>> searchTrainers(String query) async {
    try {
      final trainers = await remoteDataSource.searchTrainers(query);
      return Right(trainers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Trainer>>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    try {
      final trainers = await remoteDataSource.getTrainersByLocation(
        latitude,
        longitude,
        radiusKm,
      );
      return Right(trainers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trainer>> getTrainerById(String id) async {
    try {
      final trainer = await remoteDataSource.getTrainerById(id);
      return Right(trainer);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Trainer>>> getRecommendedTrainers() async {
    try {
      final trainers = await remoteDataSource.getRecommendedTrainers();
      return Right(trainers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
