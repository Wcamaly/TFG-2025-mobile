import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/exercise_types.dart';

final advancedWorkoutProvider = StateNotifierProvider<AdvancedWorkoutNotifier,
    AsyncValue<AdvancedWorkoutState>>((ref) {
  return AdvancedWorkoutNotifier();
});

final personalRecordsProvider = StateNotifierProvider<PersonalRecordsNotifier,
    AsyncValue<List<PersonalRecord>>>((ref) {
  return PersonalRecordsNotifier();
});

final workoutSessionsProvider = StateNotifierProvider<WorkoutSessionsNotifier,
    AsyncValue<List<WorkoutSession>>>((ref) {
  return WorkoutSessionsNotifier();
});

class AdvancedWorkoutState {
  final List<Exercise> todaysExercises;
  final List<ExerciseStats> todaysStats;
  final List<PersonalRecord> personalRecords;
  final List<WorkoutSession> recentSessions;

  AdvancedWorkoutState({
    required this.todaysExercises,
    required this.todaysStats,
    required this.personalRecords,
    required this.recentSessions,
  });

  AdvancedWorkoutState copyWith({
    List<Exercise>? todaysExercises,
    List<ExerciseStats>? todaysStats,
    List<PersonalRecord>? personalRecords,
    List<WorkoutSession>? recentSessions,
  }) {
    return AdvancedWorkoutState(
      todaysExercises: todaysExercises ?? this.todaysExercises,
      todaysStats: todaysStats ?? this.todaysStats,
      personalRecords: personalRecords ?? this.personalRecords,
      recentSessions: recentSessions ?? this.recentSessions,
    );
  }
}

class AdvancedWorkoutNotifier
    extends StateNotifier<AsyncValue<AdvancedWorkoutState>> {
  AdvancedWorkoutNotifier() : super(const AsyncValue.loading()) {
    _loadWorkoutData();
  }

  Future<void> _loadWorkoutData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final todaysExercises = _generateTodaysExercises();
      final personalRecords = _generatePersonalRecords();
      final recentSessions = _generateRecentSessions();

      final workoutState = AdvancedWorkoutState(
        todaysExercises: todaysExercises,
        todaysStats: [],
        personalRecords: personalRecords,
        recentSessions: recentSessions,
      );

      state = AsyncValue.data(workoutState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  List<Exercise> _generateTodaysExercises() {
    return [
      // Ejercicio tradicional de fuerza
      Exercise(
        id: '1',
        name: 'Back Squat',
        description: 'Sentadilla trasera con barra',
        category: ExerciseCategory.strength,
        workoutType: WorkoutType.traditional,
        muscleGroups: ['Cuádriceps', 'Glúteos', 'Core'],
        equipment: ['Barra', 'Discos'],
        sets: 5,
        reps: 5,
        restTimeSeconds: 180,
      ),

      // AMRAP de CrossFit
      Exercise(
        id: '2',
        name: 'Cindy',
        description: 'AMRAP 20 minutos: 5 Pull-ups, 10 Push-ups, 15 Air Squats',
        category: ExerciseCategory.crossfit,
        workoutType: WorkoutType.amrap,
        muscleGroups: ['Full Body'],
        equipment: ['Pull-up Bar'],
        durationMinutes: 20,
        subExercises: [
          SubExercise(name: 'Pull-ups', reps: 5),
          SubExercise(name: 'Push-ups', reps: 10),
          SubExercise(name: 'Air Squats', reps: 15),
        ],
      ),

      // EMOM
      Exercise(
        id: '3',
        name: 'EMOM Thrusters',
        description: 'EMOM 12 min: 8 Thrusters @40kg',
        category: ExerciseCategory.crossfit,
        workoutType: WorkoutType.emom,
        muscleGroups: ['Shoulders', 'Legs', 'Core'],
        equipment: ['Barra', 'Discos'],
        durationMinutes: 12,
        reps: 8,
      ),

      // For Time
      Exercise(
        id: '4',
        name: 'Fran',
        description: 'For Time: 21-15-9 Thrusters (43kg) + Pull-ups',
        category: ExerciseCategory.crossfit,
        workoutType: WorkoutType.forTime,
        muscleGroups: ['Full Body'],
        equipment: ['Barra', 'Pull-up Bar'],
        rounds: 3,
        subExercises: [
          SubExercise(name: 'Thrusters', reps: 21), // Luego 15, luego 9
          SubExercise(name: 'Pull-ups', reps: 21), // Luego 15, luego 9
        ],
      ),

      // Max Weight (1RM)
      Exercise(
        id: '5',
        name: 'Deadlift 1RM',
        description: 'Encontrar tu 1RM en peso muerto',
        category: ExerciseCategory.strength,
        workoutType: WorkoutType.maxWeight,
        muscleGroups: ['Espalda', 'Glúteos', 'Isquiotibiales'],
        equipment: ['Barra', 'Discos'],
        sets: 1,
        reps: 1,
      ),
    ];
  }

  List<PersonalRecord> _generatePersonalRecords() {
    return [
      PersonalRecord(
        exerciseId: '1',
        exerciseName: 'Back Squat',
        date: DateTime.now().subtract(const Duration(days: 7)),
        type: PRType.oneRM,
        value: 140.0,
        notes: '¡Nuevo PR! Técnica perfecta',
      ),
      PersonalRecord(
        exerciseId: '2',
        exerciseName: 'Cindy',
        date: DateTime.now().subtract(const Duration(days: 14)),
        type: PRType.maxRounds,
        value: 18.0,
        notes: 'Sin parar en los push-ups',
      ),
      PersonalRecord(
        exerciseId: '4',
        exerciseName: 'Fran',
        date: DateTime.now().subtract(const Duration(days: 21)),
        type: PRType.bestTime,
        value: 285.0, // 4:45 en segundos
        notes: 'Sub-5! Objetivo cumplido',
      ),
      PersonalRecord(
        exerciseId: '5',
        exerciseName: 'Deadlift',
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: PRType.oneRM,
        value: 180.0,
        notes: 'Fácil, queda más',
      ),
    ];
  }

  List<WorkoutSession> _generateRecentSessions() {
    return [
      WorkoutSession(
        id: '1',
        date: DateTime.now().subtract(const Duration(days: 1)),
        name: 'Strength Day',
        exercises: [],
        stats: [],
        durationMinutes: 75,
        caloriesBurned: 450,
        overallRating: 8.5,
        notes: 'Buen entrenamiento de fuerza',
      ),
      WorkoutSession(
        id: '2',
        date: DateTime.now().subtract(const Duration(days: 2)),
        name: 'CrossFit WOD',
        exercises: [],
        stats: [],
        durationMinutes: 45,
        caloriesBurned: 380,
        overallRating: 9.0,
        notes: 'AMRAP brutal pero divertido',
      ),
      WorkoutSession(
        id: '3',
        date: DateTime.now().subtract(const Duration(days: 3)),
        name: 'Powerlifting',
        exercises: [],
        stats: [],
        durationMinutes: 90,
        caloriesBurned: 320,
        overallRating: 7.5,
        notes: 'Trabajo técnico en peso muerto',
      ),
    ];
  }

  Future<void> updateExerciseStats(
      String exerciseId, ExerciseStats stats) async {
    state.whenData((currentState) {
      // Actualizar las stats del ejercicio
      final updatedStats = [...currentState.todaysStats];
      final existingIndex =
          updatedStats.indexWhere((s) => s.exerciseId == exerciseId);

      if (existingIndex >= 0) {
        updatedStats[existingIndex] = stats;
      } else {
        updatedStats.add(stats);
      }

      // Verificar si es un nuevo PR
      _checkForNewPR(stats, currentState);

      state = AsyncValue.data(currentState.copyWith(todaysStats: updatedStats));
    });
  }

  void _checkForNewPR(ExerciseStats stats, AdvancedWorkoutState currentState) {
    // Lógica para detectar nuevos PRs
    final exercise = currentState.todaysExercises
        .firstWhere((e) => e.id == stats.exerciseId);

    switch (stats.workoutType) {
      case WorkoutType.maxWeight:
        if (stats.weightUsed != null) {
          _addPRIfBetter(
            exerciseId: stats.exerciseId,
            exerciseName: exercise.name,
            type: PRType.oneRM,
            value: stats.weightUsed!,
            currentState: currentState,
          );
        }
        break;
      case WorkoutType.amrap:
        if (stats.rounds != null) {
          _addPRIfBetter(
            exerciseId: stats.exerciseId,
            exerciseName: exercise.name,
            type: PRType.maxRounds,
            value: stats.rounds!.toDouble(),
            currentState: currentState,
          );
        }
        break;
      case WorkoutType.forTime:
        if (stats.timeSeconds != null) {
          _addPRIfBetter(
            exerciseId: stats.exerciseId,
            exerciseName: exercise.name,
            type: PRType.bestTime,
            value: stats.timeSeconds!.toDouble(),
            currentState: currentState,
            isLowerBetter: true,
          );
        }
        break;
      default:
        break;
    }
  }

  void _addPRIfBetter({
    required String exerciseId,
    required String exerciseName,
    required PRType type,
    required double value,
    required AdvancedWorkoutState currentState,
    bool isLowerBetter = false,
  }) {
    final existingPR = currentState.personalRecords
        .where((pr) => pr.exerciseId == exerciseId && pr.type == type)
        .isNotEmpty;

    if (!existingPR) {
      // Primer registro para este ejercicio
      final newPR = PersonalRecord(
        exerciseId: exerciseId,
        exerciseName: exerciseName,
        date: DateTime.now(),
        type: type,
        value: value,
        notes: '¡Primer registro!',
      );

      final updatedPRs = [...currentState.personalRecords, newPR];
      state =
          AsyncValue.data(currentState.copyWith(personalRecords: updatedPRs));
    } else {
      // Verificar si es mejor que el anterior
      final currentBest = currentState.personalRecords
          .where((pr) => pr.exerciseId == exerciseId && pr.type == type)
          .first;

      final isBetter =
          isLowerBetter ? value < currentBest.value : value > currentBest.value;

      if (isBetter) {
        final newPR = PersonalRecord(
          exerciseId: exerciseId,
          exerciseName: exerciseName,
          date: DateTime.now(),
          type: type,
          value: value,
          notes: '¡Nuevo PR!',
        );

        final updatedPRs = currentState.personalRecords
            .where((pr) => !(pr.exerciseId == exerciseId && pr.type == type))
            .toList()
          ..add(newPR);

        state =
            AsyncValue.data(currentState.copyWith(personalRecords: updatedPRs));
      }
    }
  }

  Future<void> refreshWorkoutData() async {
    state = const AsyncValue.loading();
    await _loadWorkoutData();
  }
}

class PersonalRecordsNotifier
    extends StateNotifier<AsyncValue<List<PersonalRecord>>> {
  PersonalRecordsNotifier() : super(const AsyncValue.loading()) {
    _loadPersonalRecords();
  }

  Future<void> _loadPersonalRecords() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Cargar PRs desde la base de datos
      state = AsyncValue.data([]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class WorkoutSessionsNotifier
    extends StateNotifier<AsyncValue<List<WorkoutSession>>> {
  WorkoutSessionsNotifier() : super(const AsyncValue.loading()) {
    _loadWorkoutSessions();
  }

  Future<void> _loadWorkoutSessions() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Cargar sesiones desde la base de datos
      state = AsyncValue.data([]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
