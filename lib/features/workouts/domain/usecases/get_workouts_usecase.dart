import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutsUseCase {
  final WorkoutRepository repository;

  GetWorkoutsUseCase(this.repository);

  Future<Either<Failure, List<Workout>>> call(GetWorkoutsParams params) {
    return repository.getWorkouts(
      category: params.category,
      difficulty: params.difficulty,
      trainer: params.trainer,
    );
  }
}

class GetWorkoutsParams extends Equatable {
  final String? category;
  final String? difficulty;
  final String? trainer;

  const GetWorkoutsParams({
    this.category,
    this.difficulty,
    this.trainer,
  });

  @override
  List<Object?> get props => [category, difficulty, trainer];
}
