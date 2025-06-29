import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';
import '../datasources/routines_local_data_source.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart' as db_tables;
import 'package:drift/drift.dart';
import 'dart:convert';

class RoutinesRepositoryImpl implements RoutinesRepository {
  final RoutinesLocalDataSource localDataSource;

  RoutinesRepositoryImpl(this.localDataSource);

  @override
  Future<List<Routine>> getRoutinesByTrainer(int trainerId) async {
    try {
      final dbRoutines = await localDataSource.getRoutinesByTrainer(trainerId);

      // Mapear cada rutina calculando dinámicamente los estudiantes asignados
      final routines = <Routine>[];
      for (final dbRoutine in dbRoutines) {
        final assignedStudentsCount = await countAssignedStudents(dbRoutine.id);
        final routine =
            _mapToEntityWithAssignedCount(dbRoutine, assignedStudentsCount);
        routines.add(routine);
      }

      return routines;
    } catch (e) {
      print('❌ Repository error getting routines: $e');
      rethrow;
    }
  }

  @override
  Future<Routine?> getRoutineById(int routineId) async {
    try {
      final dbRoutine = await localDataSource.getRoutineById(routineId);
      return dbRoutine != null ? _mapToEntity(dbRoutine) : null;
    } catch (e) {
      print('❌ Repository error getting routine by id: $e');
      rethrow;
    }
  }

  @override
  Future<Routine> createRoutine(Routine routine) async {
    try {
      final companion = _mapToCompanion(routine);
      final dbRoutine = await localDataSource.createRoutine(companion);
      return _mapToEntity(dbRoutine);
    } catch (e) {
      print('❌ Repository error creating routine: $e');
      rethrow;
    }
  }

  @override
  Future<Routine> updateRoutine(Routine routine) async {
    try {
      final companion = _mapToCompanionForUpdate(routine);
      final dbRoutine =
          await localDataSource.updateRoutine(routine.id, companion);
      return _mapToEntity(dbRoutine);
    } catch (e) {
      print('❌ Repository error updating routine: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteRoutine(int routineId) async {
    try {
      await localDataSource.deleteRoutine(routineId);
    } catch (e) {
      print('❌ Repository error deleting routine: $e');
      rethrow;
    }
  }

  @override
  Future<List<Routine>> searchRoutines(int trainerId, String query) async {
    try {
      final dbRoutines = await localDataSource.searchRoutines(trainerId, query);
      return dbRoutines.map<Routine>(_mapToEntity).toList();
    } catch (e) {
      print('❌ Repository error searching routines: $e');
      rethrow;
    }
  }

  @override
  Future<List<Routine>> getRoutinesByCategory(
      int trainerId, String category) async {
    try {
      final dbRoutines =
          await localDataSource.getRoutinesByCategory(trainerId, category);
      return dbRoutines.map<Routine>(_mapToEntity).toList();
    } catch (e) {
      print('❌ Repository error getting routines by category: $e');
      rethrow;
    }
  }

  @override
  Future<List<Routine>> getRoutinesByDifficulty(
      int trainerId, RoutineDifficulty difficulty) async {
    try {
      final dbDifficulty = _mapDifficultyToDb(difficulty);
      final dbRoutines = await localDataSource.getRoutinesByDifficulty(
          trainerId, dbDifficulty);
      return dbRoutines.map<Routine>(_mapToEntity).toList();
    } catch (e) {
      print('❌ Repository error getting routines by difficulty: $e');
      rethrow;
    }
  }

  @override
  Future<List<Routine>> getRoutinesByStatus(
      int trainerId, RoutineStatus status) async {
    try {
      final dbStatus = _mapStatusToDb(status);
      final dbRoutines =
          await localDataSource.getRoutinesByStatus(trainerId, dbStatus);
      return dbRoutines.map<Routine>(_mapToEntity).toList();
    } catch (e) {
      print('❌ Repository error getting routines by status: $e');
      rethrow;
    }
  }

  @override
  Future<Routine> duplicateRoutine(int routineId, String newName) async {
    try {
      final dbRoutine =
          await localDataSource.duplicateRoutine(routineId, newName);
      return _mapToEntity(dbRoutine);
    } catch (e) {
      print('❌ Repository error duplicating routine: $e');
      rethrow;
    }
  }

  @override
  Future<void> assignRoutineToStudents({
    required int routineId,
    required List<int> studentIds,
    required int trainerId,
    required DateTime scheduledDate,
  }) async {
    try {
      await localDataSource.assignRoutineToStudents(
        routineId: routineId,
        studentIds: studentIds,
        trainerId: trainerId,
        scheduledDate: scheduledDate,
      );

      print(
          '✅ Successfully assigned routine $routineId to ${studentIds.length} students');
    } catch (e) {
      print('❌ Repository error assigning routine to students: $e');
      rethrow;
    }
  }

  @override
  Future<int> countAssignedStudents(int routineId) async {
    try {
      return await localDataSource.countAssignedStudents(routineId);
    } catch (e) {
      print('❌ Repository error counting assigned students: $e');
      return 0;
    }
  }

  @override
  Future<List<Routine>> getRoutinesAssignedToStudent(int studentId) async {
    try {
      final dbRoutines =
          await localDataSource.getRoutinesAssignedToStudent(studentId);
      return dbRoutines.map(_mapToEntity).toList();
    } catch (e) {
      print('❌ Repository error getting assigned routines for student: $e');
      return [];
    }
  }

  // Métodos de mapeo privados
  Routine _mapToEntity(DbRoutine dbRoutine) {
    return Routine(
      id: dbRoutine.id,
      name: dbRoutine.name,
      description: dbRoutine.description,
      category: dbRoutine.category,
      duration: dbRoutine.durationMinutes,
      difficulty: _mapDifficultyFromDb(dbRoutine.difficulty),
      exercises: _parseExercises(dbRoutine.exercisesJson),
      createdBy: dbRoutine.createdBy,
      status: _mapStatusFromDb(dbRoutine.status),
      createdAt: dbRoutine.createdAt,
      updatedAt: dbRoutine.updatedAt,
    );
  }

  Routine _mapToEntityWithAssignedCount(
      DbRoutine dbRoutine, int assignedStudentsCount) {
    return Routine(
      id: dbRoutine.id,
      name: dbRoutine.name,
      description: dbRoutine.description,
      category: dbRoutine.category,
      duration: dbRoutine.durationMinutes,
      difficulty: _mapDifficultyFromDb(dbRoutine.difficulty),
      exercises: _parseExercises(dbRoutine.exercisesJson),
      createdBy: dbRoutine.createdBy,
      status: _mapStatusFromDb(dbRoutine.status),
      assignedStudents: assignedStudentsCount, // Valor calculado dinámicamente
      createdAt: dbRoutine.createdAt,
      updatedAt: dbRoutine.updatedAt,
    );
  }

  RoutinesCompanion _mapToCompanion(Routine routine) {
    return RoutinesCompanion.insert(
      name: routine.name,
      description: routine.description,
      category: routine.category,
      durationMinutes: routine.duration,
      difficulty: _mapDifficultyToDb(routine.difficulty),
      exerciseCount: Value(routine.exercises.length),
      createdBy: routine.createdBy,
      status: _mapStatusToDb(routine.status),
      exercisesJson: _serializeExercises(routine.exercises),
    );
  }

  RoutinesCompanion _mapToCompanionForUpdate(Routine routine) {
    return RoutinesCompanion(
      id: Value(routine.id),
      name: Value(routine.name),
      description: Value(routine.description),
      category: Value(routine.category),
      durationMinutes: Value(routine.duration),
      difficulty: Value(_mapDifficultyToDb(routine.difficulty)),
      exerciseCount: Value(routine.exercises.length),
      status: Value(_mapStatusToDb(routine.status)),
      exercisesJson: Value(_serializeExercises(routine.exercises)),
      updatedAt: Value(DateTime.now()),
    );
  }

  List<Exercise> _parseExercises(String exercisesJson) {
    try {
      if (exercisesJson.isEmpty || exercisesJson == '[]') {
        return [];
      }

      final List<dynamic> exercisesList = json.decode(exercisesJson);
      return exercisesList.map((exerciseData) {
        return Exercise(
          id: exerciseData['id'] ?? 0,
          name: exerciseData['name'] ?? '',
          description: exerciseData['description'] ?? '',
          sets: exerciseData['sets'] ?? 0,
          reps: exerciseData['reps'] ?? 0,
          restTime: exerciseData['restTime'] ?? 60,
          weight: exerciseData['weight']?.toDouble(),
          percentage: exerciseData['percentage'],
          duration: exerciseData['duration'],
          notes: exerciseData['notes'],
          imageUrl: exerciseData['imageUrl'],
          videoUrl: exerciseData['videoUrl'],
        );
      }).toList();
    } catch (e) {
      print('❌ Error parsing exercises JSON: $e');
      return [];
    }
  }

  String _serializeExercises(List<Exercise> exercises) {
    try {
      final exercisesList = exercises
          .map((exercise) => {
                'id': exercise.id,
                'name': exercise.name,
                'description': exercise.description,
                'sets': exercise.sets,
                'reps': exercise.reps,
                'restTime': exercise.restTime,
                if (exercise.weight != null) 'weight': exercise.weight,
                if (exercise.percentage != null)
                  'percentage': exercise.percentage,
                if (exercise.duration != null) 'duration': exercise.duration,
                if (exercise.notes != null) 'notes': exercise.notes,
                if (exercise.imageUrl != null) 'imageUrl': exercise.imageUrl,
                if (exercise.videoUrl != null) 'videoUrl': exercise.videoUrl,
              })
          .toList();

      return json.encode(exercisesList);
    } catch (e) {
      print('❌ Error serializing exercises: $e');
      return '[]';
    }
  }

  RoutineDifficulty _mapDifficultyFromDb(db_tables.DifficultyLevel difficulty) {
    switch (difficulty) {
      case db_tables.DifficultyLevel.beginner:
        return RoutineDifficulty.beginner;
      case db_tables.DifficultyLevel.intermediate:
        return RoutineDifficulty.intermediate;
      case db_tables.DifficultyLevel.advanced:
        return RoutineDifficulty.advanced;
    }
  }

  db_tables.DifficultyLevel _mapDifficultyToDb(RoutineDifficulty difficulty) {
    switch (difficulty) {
      case RoutineDifficulty.beginner:
        return db_tables.DifficultyLevel.beginner;
      case RoutineDifficulty.intermediate:
        return db_tables.DifficultyLevel.intermediate;
      case RoutineDifficulty.advanced:
        return db_tables.DifficultyLevel.advanced;
    }
  }

  RoutineStatus _mapStatusFromDb(db_tables.RoutineStatus status) {
    switch (status) {
      case db_tables.RoutineStatus.active:
        return RoutineStatus.active;
      case db_tables.RoutineStatus.paused:
        return RoutineStatus.paused;
      case db_tables.RoutineStatus.completed:
        return RoutineStatus.completed;
      case db_tables.RoutineStatus.cancelled:
        return RoutineStatus.paused; // Mapear cancelled a paused
    }
  }

  db_tables.RoutineStatus _mapStatusToDb(RoutineStatus status) {
    switch (status) {
      case RoutineStatus.active:
        return db_tables.RoutineStatus.active;
      case RoutineStatus.paused:
        return db_tables.RoutineStatus.paused;
      case RoutineStatus.completed:
        return db_tables.RoutineStatus.completed;
    }
  }
}
