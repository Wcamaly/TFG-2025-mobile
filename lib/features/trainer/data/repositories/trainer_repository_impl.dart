import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final List<Trainer> _mockTrainers = [
    const Trainer(
      id: '1',
      name: 'John Doe',
      photoUrl: 'assets/images/trainer1.png',
      rating: 4.8,
      languages: ['English', 'Spanish'],
      description: 'Certified personal trainer with 5 years of experience',
      trainingPacks: [
        TrainingPack(
          id: '1',
          title: 'Beginner Fitness',
          description: '4-week program for beginners',
          price: 99.99,
          durationInWeeks: 4,
          difficulty: 'Beginner',
        ),
        TrainingPack(
          id: '2',
          title: 'Advanced Strength',
          description: '8-week intensive program',
          price: 199.99,
          durationInWeeks: 8,
          difficulty: 'Advanced',
        ),
      ],
      location: Location(
        latitude: 40.7128,
        longitude: -74.0060,
        address: '123 Fitness St',
        city: 'New York',
        country: 'USA',
      ),
    ),
    const Trainer(
      id: '2',
      name: 'Jane Smith',
      photoUrl: 'assets/images/trainer2.png',
      rating: 4.9,
      languages: ['English', 'French'],
      description: 'Specialized in HIIT and nutrition',
      trainingPacks: [
        TrainingPack(
          id: '3',
          title: 'HIIT Challenge',
          description: '6-week high intensity program',
          price: 149.99,
          durationInWeeks: 6,
          difficulty: 'Intermediate',
        ),
      ],
      location: const Location(
        latitude: 40.7282,
        longitude: -73.9942,
        address: '456 Health Ave',
        city: 'New York',
        country: 'USA',
      ),
    ),
  ];

  @override
  Future<Either<Failure, List<Trainer>>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    required double radius,
    Map<String, dynamic>? filters,
  }) async {
    try {
      // En una implementación real, filtrarías por distancia y aplicarías los filtros
      return Right(_mockTrainers);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trainer>> getTrainerDetails(String trainerId) async {
    try {
      final trainer = _mockTrainers.firstWhere(
        (trainer) => trainer.id == trainerId,
        orElse: () => throw Exception('Trainer not found'),
      );
      return Right(trainer);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subscribeToTrainingPack({
    required String trainerId,
    required String packId,
  }) async {
    try {
      // En una implementación real, aquí procesarías la suscripción
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrainingPack>>> getTrainerPacks(
    String trainerId,
  ) async {
    try {
      final trainer = _mockTrainers.firstWhere(
        (trainer) => trainer.id == trainerId,
        orElse: () => throw Exception('Trainer not found'),
      );
      return Right(trainer.trainingPacks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
