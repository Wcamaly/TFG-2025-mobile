import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/trainer.dart';

abstract class TrainerRepository {
  Future<Either<Failure, List<Trainer>>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  });

  Future<Either<Failure, List<Trainer>>> searchTrainers(String query);

  Future<Either<Failure, List<Trainer>>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  );

  Future<Either<Failure, Trainer>> getTrainerById(String id);

  Future<Either<Failure, List<Trainer>>> getRecommendedTrainers();
}
