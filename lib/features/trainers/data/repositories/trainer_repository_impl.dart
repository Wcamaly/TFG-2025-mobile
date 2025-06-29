import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../datasources/trainer_local_data_source.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final TrainerLocalDataSource localDataSource;

  TrainerRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Trainer>>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    try {
      final trainers = await localDataSource.getTrainersByLocation(
        latitude,
        longitude,
        radiusKm,
      );
      return Right(trainers);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Trainer>>> searchTrainers(String query) async {
    try {
      final trainers = await localDataSource.searchTrainers(query);
      return Right(trainers);
    } on Exception catch (e) {
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
      final trainers = await localDataSource.getTrainersByLocation(
        latitude,
        longitude,
        radiusKm,
      );
      return Right(trainers);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trainer>> getTrainerById(String id) async {
    try {
      final trainer = await localDataSource.getTrainerById(id);
      if (trainer == null) {
        return Left(UnknownFailure(message: 'Trainer not found'));
      }
      return Right(trainer);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Trainer>>> getRecommendedTrainers() async {
    try {
      final trainers = await localDataSource.getRecommendedTrainers();
      return Right(trainers);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
