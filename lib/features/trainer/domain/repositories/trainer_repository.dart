import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/trainer.dart';

abstract class TrainerRepository {
  Future<Either<Failure, List<Trainer>>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    required double radius,
    Map<String, dynamic>? filters,
  });

  Future<Either<Failure, Trainer>> getTrainerDetails(String trainerId);

  Future<Either<Failure, void>> subscribeToTrainingPack({
    required String trainerId,
    required String packId,
  });

  Future<Either<Failure, List<TrainingPack>>> getTrainerPacks(String trainerId);
}
