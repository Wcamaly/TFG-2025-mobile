import '../../domain/entities/workout.dart';

abstract class WorkoutRemoteDataSource {
  Future<List<Workout>> getWorkouts({
    String? category,
    String? difficulty,
    String? trainer,
  });

  Future<Workout> getWorkoutById(String id);

  Future<List<String>> getCategories();

  Future<List<String>> getDifficulties();

  Future<void> rateWorkout({
    required String id,
    required double rating,
    String? review,
  });
}

class WorkoutRemoteDataSourceImpl implements WorkoutRemoteDataSource {
  // Aquí iría la implementación con tu servicio de backend real
  // Por ejemplo, una API REST, Firebase, etc.

  @override
  Future<List<Workout>> getWorkouts({
    String? category,
    String? difficulty,
    String? trainer,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getCategories() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getDifficulties() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> rateWorkout({
    required String id,
    required double rating,
    String? review,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }
}
