import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String duration,
    required String difficulty,
    required List<WorkoutExercise> exercises,
    required String trainer,
    required String category,
    required int caloriesBurn,
    required double rating,
    required int reviewCount,
  }) = _Workout;
}

@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String name,
    required String description,
    required String imageUrl,
    required String videoUrl,
    required int sets,
    required int reps,
    required int restTime,
    required String equipment,
    required String muscleGroup,
  }) = _WorkoutExercise;
}
