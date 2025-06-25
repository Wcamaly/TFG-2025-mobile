import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_types.freezed.dart';

enum ExerciseCategory {
  strength, // Powerlifting, fuerza
  cardio, // Cardio tradicional
  crossfit, // WODs, AMRAPs, EMOMs
  compound, // Ejercicios compuestos
  isolation, // Ejercicios de aislamiento
  mobility, // Movilidad y flexibilidad
}

enum WorkoutType {
  traditional, // Sets x Reps tradicionales
  amrap, // As Many Rounds As Possible
  emom, // Every Minute On the Minute
  tabata, // Tabata protocol
  forTime, // For Time (completar lo más rápido posible)
  maxReps, // Máximo de repeticiones
  maxWeight, // 1RM, 3RM, 5RM, etc.
  timeChallenge, // Desafío de tiempo (plancha, etc.)
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required String description,
    required ExerciseCategory category,
    required WorkoutType workoutType,
    required List<String> muscleGroups,
    required List<String> equipment,
    String? imageUrl,
    String? videoUrl,

    // Para ejercicios tradicionales
    int? sets,
    int? reps,
    int? restTimeSeconds,

    // Para WODs y ejercicios de tiempo
    int? durationMinutes,
    int? rounds,

    // Para ejercicios compuestos (lista de sub-ejercicios)
    List<SubExercise>? subExercises,

    // Configuración específica
    Map<String, dynamic>? config,
  }) = _Exercise;
}

@freezed
class SubExercise with _$SubExercise {
  const factory SubExercise({
    required String name,
    required int reps,
    String? notes,
  }) = _SubExercise;
}

@freezed
class ExerciseStats with _$ExerciseStats {
  const factory ExerciseStats({
    required String exerciseId,
    required DateTime date,
    required WorkoutType workoutType,

    // Stats comunes
    int? completedReps,
    double? weightUsed,
    int? timeSeconds,

    // Stats específicos por tipo
    int? rounds, // Para AMRAPs
    double? personalRecord, // Para PRs
    int? maxReps, // Para max reps
    String? notes,

    // Rating subjetivo
    int? difficultyRating, // 1-10
    int? energyLevel, // 1-10

    // Para ejercicios compuestos
    List<SubExerciseStats>? subExerciseStats,
  }) = _ExerciseStats;
}

@freezed
class SubExerciseStats with _$SubExerciseStats {
  const factory SubExerciseStats({
    required String name,
    required int completedReps,
    double? weight,
    String? notes,
  }) = _SubExerciseStats;
}

@freezed
class PersonalRecord with _$PersonalRecord {
  const factory PersonalRecord({
    required String exerciseId,
    required String exerciseName,
    required DateTime date,
    required PRType type,
    required double value,
    String? notes,
  }) = _PersonalRecord;
}

enum PRType {
  oneRM, // 1 Rep Max
  threeRM, // 3 Rep Max
  fiveRM, // 5 Rep Max
  maxReps, // Máximo de repeticiones
  bestTime, // Mejor tiempo
  maxRounds, // Máximo de rondas
}

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required DateTime date,
    required String name,
    required List<Exercise> exercises,
    required List<ExerciseStats> stats,
    required int durationMinutes,
    int? caloriesBurned,
    String? notes,
    double? overallRating,
  }) = _WorkoutSession;
}
