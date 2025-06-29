import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart';
import 'package:drift/drift.dart';

abstract class RoutinesLocalDataSource {
  Future<List<DbRoutine>> getRoutinesByTrainer(int trainerId);
  Future<DbRoutine?> getRoutineById(int routineId);
  Future<DbRoutine> createRoutine(RoutinesCompanion routine);
  Future<DbRoutine> updateRoutine(int routineId, RoutinesCompanion routine);
  Future<void> deleteRoutine(int routineId);
  Future<List<DbRoutine>> searchRoutines(int trainerId, String query);
  Future<List<DbRoutine>> getRoutinesByCategory(int trainerId, String category);
  Future<List<DbRoutine>> getRoutinesByDifficulty(
      int trainerId, DifficultyLevel difficulty);
  Future<List<DbRoutine>> getRoutinesByStatus(
      int trainerId, RoutineStatus status);
  Future<DbRoutine> duplicateRoutine(int routineId, String newName);
  Future<void> assignRoutineToStudents({
    required int routineId,
    required List<int> studentIds,
    required int trainerId,
    required DateTime scheduledDate,
  });

  /// Cuenta los estudiantes asignados a una rutina
  Future<int> countAssignedStudents(int routineId);

  /// Obtiene las rutinas asignadas a un estudiante específico
  Future<List<DbRoutine>> getRoutinesAssignedToStudent(int studentId);
}

class RoutinesLocalDataSourceImpl implements RoutinesLocalDataSource {
  final AppDatabase database;

  RoutinesLocalDataSourceImpl(this.database);

  @override
  Future<List<DbRoutine>> getRoutinesByTrainer(int trainerId) async {
    try {
      final routines = await (database.select(database.routines)
            ..where((r) => r.createdBy.equals(trainerId))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

      print('📋 Found ${routines.length} routines for trainer $trainerId');
      return routines;
    } catch (e) {
      print('❌ Error getting routines by trainer: $e');
      rethrow;
    }
  }

  @override
  Future<DbRoutine?> getRoutineById(int routineId) async {
    try {
      final routine = await (database.select(database.routines)
            ..where((r) => r.id.equals(routineId)))
          .getSingleOrNull();

      return routine;
    } catch (e) {
      print('❌ Error getting routine by id: $e');
      rethrow;
    }
  }

  @override
  Future<DbRoutine> createRoutine(RoutinesCompanion routine) async {
    try {
      final routineId = await database.into(database.routines).insert(routine);
      final createdRoutine = await getRoutineById(routineId);

      if (createdRoutine == null) {
        throw Exception('Failed to retrieve created routine');
      }

      print('✅ Created routine with id: $routineId');
      return createdRoutine;
    } catch (e) {
      print('❌ Error creating routine: $e');
      rethrow;
    }
  }

  @override
  Future<DbRoutine> updateRoutine(
      int routineId, RoutinesCompanion routine) async {
    try {
      await (database.update(database.routines)
            ..where((r) => r.id.equals(routineId)))
          .write(routine.copyWith(updatedAt: Value(DateTime.now())));

      final updatedRoutine = await getRoutineById(routineId);

      if (updatedRoutine == null) {
        throw Exception('Failed to retrieve updated routine');
      }

      print('✅ Updated routine with id: $routineId');
      return updatedRoutine;
    } catch (e) {
      print('❌ Error updating routine: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteRoutine(int routineId) async {
    try {
      final deletedCount = await (database.delete(database.routines)
            ..where((r) => r.id.equals(routineId)))
          .go();

      if (deletedCount == 0) {
        throw Exception('Routine not found or already deleted');
      }

      print('✅ Deleted routine with id: $routineId');
    } catch (e) {
      print('❌ Error deleting routine: $e');
      rethrow;
    }
  }

  @override
  Future<List<DbRoutine>> searchRoutines(int trainerId, String query) async {
    try {
      final lowerQuery = query.toLowerCase();
      final routines = await (database.select(database.routines)
            ..where((r) =>
                r.createdBy.equals(trainerId) &
                (r.name.lower().contains(lowerQuery) |
                    r.description.lower().contains(lowerQuery)))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

      print('🔍 Found ${routines.length} routines matching "$query"');
      return routines;
    } catch (e) {
      print('❌ Error searching routines: $e');
      rethrow;
    }
  }

  @override
  Future<List<DbRoutine>> getRoutinesByCategory(
      int trainerId, String category) async {
    try {
      final routines = await (database.select(database.routines)
            ..where((r) =>
                r.createdBy.equals(trainerId) & r.category.equals(category))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

      return routines;
    } catch (e) {
      print('❌ Error getting routines by category: $e');
      rethrow;
    }
  }

  @override
  Future<List<DbRoutine>> getRoutinesByDifficulty(
      int trainerId, DifficultyLevel difficulty) async {
    try {
      final routines = await (database.select(database.routines)
            ..where((r) =>
                r.createdBy.equals(trainerId) &
                r.difficulty.equals(difficulty.name))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

      return routines;
    } catch (e) {
      print('❌ Error getting routines by difficulty: $e');
      rethrow;
    }
  }

  @override
  Future<List<DbRoutine>> getRoutinesByStatus(
      int trainerId, RoutineStatus status) async {
    try {
      final routines = await (database.select(database.routines)
            ..where((r) =>
                r.createdBy.equals(trainerId) & r.status.equals(status.name))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

      return routines;
    } catch (e) {
      print('❌ Error getting routines by status: $e');
      rethrow;
    }
  }

  @override
  Future<DbRoutine> duplicateRoutine(int routineId, String newName) async {
    try {
      final originalRoutine = await getRoutineById(routineId);

      if (originalRoutine == null) {
        throw Exception('Original routine not found');
      }

      final duplicatedRoutine = RoutinesCompanion.insert(
        name: newName,
        description: '${originalRoutine.description} (Copia)',
        category: originalRoutine.category,
        durationMinutes: originalRoutine.durationMinutes,
        difficulty: originalRoutine.difficulty,
        exerciseCount: Value(originalRoutine.exerciseCount),
        createdBy: originalRoutine.createdBy,
        status: RoutineStatus.active,
        exercisesJson: originalRoutine.exercisesJson,
      );

      return await createRoutine(duplicatedRoutine);
    } catch (e) {
      print('❌ Error duplicating routine: $e');
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
      // Asignar la rutina a cada estudiante
      for (final studentId in studentIds) {
        await database.into(database.studentRoutines).insert(
              StudentRoutinesCompanion.insert(
                studentId: studentId,
                routineId: routineId,
                trainerId: trainerId,
                assignedDate: DateTime.now(),
                scheduledDate: scheduledDate,
                status: RoutineStatus.active,
              ),
            );
      }

      print('✅ Assigned routine $routineId to ${studentIds.length} students');
    } catch (e) {
      print('❌ Error assigning routine to students: $e');
      rethrow;
    }
  }

  @override
  Future<int> countAssignedStudents(int routineId) async {
    try {
      final count = await (database.selectOnly(database.studentRoutines)
            ..addColumns([database.studentRoutines.id.count()])
            ..where(database.studentRoutines.routineId.equals(routineId)))
          .getSingle();

      return count.read(database.studentRoutines.id.count()) ?? 0;
    } catch (e) {
      print('❌ Error counting assigned students: $e');
      return 0;
    }
  }

  @override
  Future<List<DbRoutine>> getRoutinesAssignedToStudent(int studentId) async {
    try {
      final query = database.select(database.routines).join([
        innerJoin(
          database.studentRoutines,
          database.studentRoutines.routineId.equalsExp(database.routines.id),
        )
      ])
        ..where(database.studentRoutines.studentId.equals(studentId))
        ..orderBy([OrderingTerm.desc(database.studentRoutines.scheduledDate)]);

      final results = await query.get();

      final routines = results.map((row) {
        return row.readTable(database.routines);
      }).toList();

      print(
          '📋 Found ${routines.length} assigned routines for student $studentId');
      return routines;
    } catch (e) {
      print('❌ Error getting assigned routines for student: $e');
      return [];
    }
  }
}
