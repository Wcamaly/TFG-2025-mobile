import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, List<Workout>>> getWorkouts({
    String? category,
    String? difficulty,
    String? trainer,
  });

  Future<Either<Failure, Workout>> getWorkoutById(String id);

  Future<Either<Failure, List<String>>> getCategories();

  Future<Either<Failure, List<String>>> getDifficulties();

  Future<Either<Failure, void>> rateWorkout({
    required String id,
    required double rating,
    String? review,
  });
}
