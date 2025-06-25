import '../../domain/entities/trainer.dart';

abstract class TrainerRemoteDataSource {
  Future<List<Trainer>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  });

  Future<List<Trainer>> searchTrainers(String query);

  Future<List<Trainer>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  );

  Future<Trainer> getTrainerById(String id);

  Future<List<Trainer>> getRecommendedTrainers();
}
