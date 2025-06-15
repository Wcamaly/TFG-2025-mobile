import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/trainer.dart';
import '../repositories/trainer_repository.dart';

class GetNearbyTrainersUseCase {
  final TrainerRepository repository;

  GetNearbyTrainersUseCase(this.repository);

  Future<Either<Failure, List<Trainer>>> call(GetNearbyTrainersParams params) {
    return repository.getNearbyTrainers(
      latitude: params.latitude,
      longitude: params.longitude,
      radius: params.radius,
      filters: params.filters,
    );
  }
}

class GetNearbyTrainersParams extends Equatable {
  final double latitude;
  final double longitude;
  final double radius;
  final Map<String, dynamic>? filters;

  const GetNearbyTrainersParams({
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.filters,
  });

  @override
  List<Object?> get props => [latitude, longitude, radius, filters];
}
