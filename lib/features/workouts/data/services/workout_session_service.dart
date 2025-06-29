import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/workout_sessions_table.dart';
import '../../domain/entities/workout_progress.dart';

class WorkoutSessionService {
  final AppDatabase _database;

  WorkoutSessionService(this._database);

  /// Guarda una nueva sesión de entrenamiento
  Future<int> saveWorkoutSession({
    required int studentId,
    required int routineId,
    required int durationMinutes,
    double caloriesBurned = 0.0,
    double overallRating = 0.0,
    String? notes,
  }) async {
    final session = WorkoutSessionsCompanion.insert(
      studentId: studentId,
      routineId: routineId,
      sessionDate: DateTime.now(),
      durationMinutes: durationMinutes,
      caloriesBurned: Value(caloriesBurned),
      overallRating: Value(overallRating),
      notes: notes != null ? Value(notes) : const Value.absent(),
      status: WorkoutSessionStatus.completed,
    );

    return await _database.into(_database.workoutSessions).insert(session);
  }

  /// Guarda los ejercicios de una sesión
  Future<int> saveExerciseSession({
    required int workoutSessionId,
    required String exerciseName,
    required String exerciseDescription,
    required int sets,
    required int reps,
    required int restTimeSeconds,
    double? weightKg,
    int? percentage,
    int? durationSeconds,
    String? notes,
  }) async {
    final exerciseSession = ExerciseSessionsCompanion.insert(
      workoutSessionId: workoutSessionId,
      exerciseName: exerciseName,
      exerciseDescription: exerciseDescription,
      sets: sets,
      reps: reps,
      restTimeSeconds: restTimeSeconds,
      weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
      percentage: percentage != null ? Value(percentage) : const Value.absent(),
      durationSeconds: durationSeconds != null
          ? Value(durationSeconds)
          : const Value.absent(),
      notes: notes != null ? Value(notes) : const Value.absent(),
    );

    return await _database
        .into(_database.exerciseSessions)
        .insert(exerciseSession);
  }

  /// Guarda los sets individuales de un ejercicio
  Future<int> saveExerciseSet({
    required int exerciseSessionId,
    required int setNumber,
    required int reps,
    double? weightKg,
    int? percentage,
    int? durationSeconds,
    double? restTimeSeconds,
    String? notes,
  }) async {
    final exerciseSet = ExerciseSetsCompanion.insert(
      exerciseSessionId: exerciseSessionId,
      setNumber: setNumber,
      reps: reps,
      weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
      percentage: percentage != null ? Value(percentage) : const Value.absent(),
      durationSeconds: durationSeconds != null
          ? Value(durationSeconds)
          : const Value.absent(),
      restTimeSeconds: restTimeSeconds != null
          ? Value(restTimeSeconds)
          : const Value.absent(),
      notes: notes != null ? Value(notes) : const Value.absent(),
    );

    return await _database.into(_database.exerciseSets).insert(exerciseSet);
  }

  /// Obtiene las sesiones de entrenamiento de un estudiante
  Future<List<DbWorkoutSession>> getWorkoutSessionsByStudent(
      int studentId) async {
    return await (_database.select(_database.workoutSessions)
          ..where((ws) => ws.studentId.equals(studentId))
          ..orderBy([(ws) => OrderingTerm.desc(ws.sessionDate)]))
        .get();
  }

  /// Obtiene los ejercicios de una sesión de entrenamiento
  Future<List<DbExerciseSession>> getExerciseSessionsByWorkoutSession(
      int workoutSessionId) async {
    return await (_database.select(_database.exerciseSessions)
          ..where((es) => es.workoutSessionId.equals(workoutSessionId))
          ..orderBy([(es) => OrderingTerm.asc(es.id)]))
        .get();
  }

  /// Obtiene los sets de un ejercicio
  Future<List<DbExerciseSet>> getExerciseSetsByExerciseSession(
      int exerciseSessionId) async {
    return await (_database.select(_database.exerciseSets)
          ..where((es) => es.exerciseSessionId.equals(exerciseSessionId))
          ..orderBy([(es) => OrderingTerm.asc(es.setNumber)]))
        .get();
  }

  /// Guarda una sesión completa de entrenamiento con ejercicios y sets
  Future<int> saveCompleteWorkoutSession({
    required int studentId,
    required int routineId,
    required int durationMinutes,
    required List<Map<String, dynamic>> exercisesData,
    double caloriesBurned = 0.0,
    double overallRating = 0.0,
    String? notes,
  }) async {
    // 1. Guardar la sesión principal
    final sessionId = await saveWorkoutSession(
      studentId: studentId,
      routineId: routineId,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      overallRating: overallRating,
      notes: notes,
    );

    // 2. Guardar cada ejercicio
    for (final exerciseData in exercisesData) {
      final exerciseSessionId = await saveExerciseSession(
        workoutSessionId: sessionId,
        exerciseName: exerciseData['name'],
        exerciseDescription: exerciseData['description'],
        sets: exerciseData['sets'],
        reps: exerciseData['reps'],
        restTimeSeconds: exerciseData['restTime'],
        weightKg: exerciseData['weightKg'],
        percentage: exerciseData['percentage'],
        durationSeconds: exerciseData['durationSeconds'],
        notes: exerciseData['notes'],
      );

      // 3. Guardar los sets del ejercicio si existen
      final sets = exerciseData['setsData'] as List<Map<String, dynamic>>?;
      if (sets != null) {
        for (int i = 0; i < sets.length; i++) {
          final setData = sets[i];
          await saveExerciseSet(
            exerciseSessionId: exerciseSessionId,
            setNumber: i + 1,
            reps: setData['reps'],
            weightKg: setData['weightKg'],
            percentage: setData['percentage'],
            durationSeconds: setData['durationSeconds'],
            restTimeSeconds: setData['restTimeSeconds'],
            notes: setData['notes'],
          );
        }
      }
    }

    return sessionId;
  }

  /// Limpia registros duplicados de ejercicios para una sesión
  Future<void> cleanDuplicateExercises(int workoutSessionId) async {
    try {
      // Obtener todos los ejercicios de la sesión
      final exercises = await (_database.select(_database.exerciseSessions)
            ..where((es) => es.workoutSessionId.equals(workoutSessionId)))
          .get();

      // Agrupar por nombre de ejercicio
      final Map<String, List<DbExerciseSession>> exerciseGroups = {};
      for (final exercise in exercises) {
        exerciseGroups
            .putIfAbsent(exercise.exerciseName, () => [])
            .add(exercise);
      }

      // Para cada grupo, mantener solo el más reciente
      for (final entry in exerciseGroups.entries) {
        final exerciseList = entry.value;
        if (exerciseList.length > 1) {
          // Ordenar por ID (el más alto es el más reciente)
          exerciseList.sort((a, b) => b.id.compareTo(a.id));

          // Eliminar todos excepto el primero (más reciente)
          for (int i = 1; i < exerciseList.length; i++) {
            await (_database.delete(_database.exerciseSessions)
                  ..where((es) => es.id.equals(exerciseList[i].id)))
                .go();
          }

          print(
              '🧹 Cleaned ${exerciseList.length - 1} duplicate exercises for ${entry.key}');
        }
      }
    } catch (e) {
      print('❌ Error cleaning duplicate exercises: $e');
    }
  }

  /// Limpia todos los registros duplicados de ejercicios (método de emergencia)
  Future<void> cleanAllDuplicateExercises() async {
    try {
      // Obtener todas las sesiones
      final sessions =
          await (_database.select(_database.workoutSessions)).get();

      for (final session in sessions) {
        await cleanDuplicateExercises(session.id);
      }

      print('🧹 Cleaned all duplicate exercises across all sessions');
    } catch (e) {
      print('❌ Error cleaning all duplicate exercises: $e');
    }
  }

  /// Guarda métricas individuales de un ejercicio
  Future<int> saveExerciseMetrics({
    required int studentId,
    required int routineId,
    required String exerciseName,
    required String exerciseDescription,
    int? repsCompleted,
    double? weightUsed,
    int? timeSpent,
    String? notes,
    bool isCompleted = false,
  }) async {
    try {
      // Crear una sesión de entrenamiento si no existe para hoy
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      // Buscar si ya existe una sesión para hoy
      var session = await (_database.select(_database.workoutSessions)
            ..where((ws) =>
                ws.studentId.equals(studentId) &
                ws.routineId.equals(routineId) &
                ws.sessionDate.isBiggerOrEqualValue(startOfDay) &
                ws.sessionDate.isSmallerThanValue(endOfDay)))
          .getSingleOrNull();

      int sessionId;
      if (session != null) {
        sessionId = session.id;
      } else {
        // Crear nueva sesión
        sessionId = await saveWorkoutSession(
          studentId: studentId,
          routineId: routineId,
          durationMinutes: 0, // Se actualizará después
          notes: 'Sesión iniciada',
        );
      }

      // Limpiar duplicados antes de buscar
      await cleanDuplicateExercises(sessionId);

      // Buscar si ya existe el ejercicio para la sesión de hoy
      final existingExercises =
          await (_database.select(_database.exerciseSessions)
                ..where((es) =>
                    es.workoutSessionId.equals(sessionId) &
                    es.exerciseName.equals(exerciseName)))
              .get();

      int exerciseId;
      if (existingExercises.isNotEmpty) {
        // Usar el primer ejercicio encontrado (el más reciente)
        final existingExercise = existingExercises.first;

        // Actualizar el registro existente
        await (_database.update(_database.exerciseSessions)
              ..where((es) => es.id.equals(existingExercise.id)))
            .write(ExerciseSessionsCompanion(
          reps: repsCompleted != null
              ? Value(repsCompleted)
              : const Value.absent(),
          weightKg:
              weightUsed != null ? Value(weightUsed) : const Value.absent(),
          durationSeconds:
              timeSpent != null ? Value(timeSpent) : const Value.absent(),
          notes: notes != null ? Value(notes) : const Value.absent(),
        ));
        exerciseId = existingExercise.id;
        print('✅ Updated existing exercise: $exerciseName (ID: $exerciseId)');
      } else {
        // Insertar nuevo si no existe
        exerciseId = await saveExerciseSession(
          workoutSessionId: sessionId,
          exerciseName: exerciseName,
          exerciseDescription: exerciseDescription,
          sets: 1, // Por defecto
          reps: repsCompleted ?? 0,
          restTimeSeconds: 0,
          weightKg: weightUsed,
          percentage: null,
          durationSeconds: timeSpent,
          notes: notes,
        );

        // Si hay métricas específicas, guardarlas como sets
        if (repsCompleted != null || weightUsed != null || timeSpent != null) {
          await saveExerciseSet(
            exerciseSessionId: exerciseId,
            setNumber: 1,
            reps: repsCompleted ?? 0,
            weightKg: weightUsed,
            percentage: null,
            durationSeconds: timeSpent,
            restTimeSeconds: null,
            notes: notes,
          );
        }
        print('✅ Created new exercise: $exerciseName (ID: $exerciseId)');
      }

      // Limpiar duplicados después de guardar
      await cleanDuplicateExercises(sessionId);

      return exerciseId;
    } catch (e) {
      print('❌ Error in saveExerciseMetrics: $e');
      rethrow;
    }
  }

  /// Actualiza el estado de completado de un ejercicio
  Future<void> updateExerciseCompletionStatus({
    required int studentId,
    required int routineId,
    required String exerciseName,
    required bool isCompleted,
  }) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Buscar la sesión de hoy
    final session = await (_database.select(_database.workoutSessions)
          ..where((ws) =>
              ws.studentId.equals(studentId) &
              ws.routineId.equals(routineId) &
              ws.sessionDate.isBiggerOrEqualValue(startOfDay) &
              ws.sessionDate.isSmallerThanValue(endOfDay)))
        .getSingleOrNull();

    if (session != null) {
      // Buscar TODOS los ejercicios con ese nombre (puede haber múltiples)
      final exercises = await (_database.select(_database.exerciseSessions)
            ..where((es) =>
                es.workoutSessionId.equals(session.id) &
                es.exerciseName.equals(exerciseName)))
          .get();

      // Actualizar todos los ejercicios encontrados
      for (final exercise in exercises) {
        await (_database.update(_database.exerciseSessions)
              ..where((es) => es.id.equals(exercise.id)))
            .write(ExerciseSessionsCompanion(
          notes: Value(isCompleted ? 'Completado' : 'Pendiente'),
        ));
      }
    }
  }

  /// Obtiene las métricas de un ejercicio específico para hoy
  Future<Map<String, dynamic>?> getExerciseMetricsForToday({
    required int studentId,
    required int routineId,
    required String exerciseName,
  }) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Buscar la sesión de hoy
    final session = await (_database.select(_database.workoutSessions)
          ..where((ws) =>
              ws.studentId.equals(studentId) &
              ws.routineId.equals(routineId) &
              ws.sessionDate.isBiggerOrEqualValue(startOfDay) &
              ws.sessionDate.isSmallerThanValue(endOfDay)))
        .getSingleOrNull();

    if (session != null) {
      // Buscar TODOS los ejercicios con ese nombre (puede haber múltiples)
      final exercises = await (_database.select(_database.exerciseSessions)
            ..where((es) =>
                es.workoutSessionId.equals(session.id) &
                es.exerciseName.equals(exerciseName)))
          .get();

      if (exercises.isNotEmpty) {
        // Usar el primer ejercicio encontrado (el más reciente)
        final exercise = exercises.first;

        // Obtener los sets del ejercicio
        final sets = await getExerciseSetsByExerciseSession(exercise.id);

        return {
          'exerciseId': exercise.id,
          'reps': exercise.reps,
          'weightKg': exercise.weightKg,
          'durationSeconds': exercise.durationSeconds,
          'notes': exercise.notes,
          'isCompleted': exercise.notes == 'Completado',
          'sets': sets,
        };
      }
    }

    return null;
  }
}
