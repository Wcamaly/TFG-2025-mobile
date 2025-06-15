import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_remote_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSource remoteDataSource;

  WorkoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Workout>>> getWorkouts({
    String? category,
    String? difficulty,
    String? trainer,
  }) async {
    try {
      final workouts = await remoteDataSource.getWorkouts(
        category: category,
        difficulty: difficulty,
        trainer: trainer,
      );
      return Right(workouts);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Workout>> getWorkoutById(String id) async {
    try {
      final workout = await remoteDataSource.getWorkoutById(id);
      return Right(workout);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getDifficulties() async {
    try {
      final difficulties = await remoteDataSource.getDifficulties();
      return Right(difficulties);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rateWorkout({
    required String id,
    required double rating,
    String? review,
  }) async {
    try {
      await remoteDataSource.rateWorkout(
        id: id,
        rating: rating,
        review: review,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
