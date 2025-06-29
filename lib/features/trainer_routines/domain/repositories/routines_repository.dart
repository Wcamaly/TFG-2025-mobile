import '../entities/routine.dart';

abstract class RoutinesRepository {
  /// Obtiene todas las rutinas de un entrenador
  Future<List<Routine>> getRoutinesByTrainer(int trainerId);

  /// Obtiene una rutina específica por ID
  Future<Routine?> getRoutineById(int routineId);

  /// Crea una nueva rutina
  Future<Routine> createRoutine(Routine routine);

  /// Actualiza una rutina existente
  Future<Routine> updateRoutine(Routine routine);

  /// Elimina una rutina
  Future<void> deleteRoutine(int routineId);

  /// Busca rutinas por nombre o descripción
  Future<List<Routine>> searchRoutines(int trainerId, String query);

  /// Filtra rutinas por categoría
  Future<List<Routine>> getRoutinesByCategory(int trainerId, String category);

  /// Filtra rutinas por dificultad
  Future<List<Routine>> getRoutinesByDifficulty(
      int trainerId, RoutineDifficulty difficulty);

  /// Filtra rutinas por estado
  Future<List<Routine>> getRoutinesByStatus(
      int trainerId, RoutineStatus status);

  /// Duplica una rutina existente
  Future<Routine> duplicateRoutine(int routineId, String newName);

  /// Asigna una rutina a múltiples estudiantes
  Future<void> assignRoutineToStudents({
    required int routineId,
    required List<int> studentIds,
    required int trainerId,
    required DateTime scheduledDate,
  });

  /// Cuenta los estudiantes asignados a una rutina
  Future<int> countAssignedStudents(int routineId);

  /// Obtiene las rutinas asignadas a un estudiante específico
  Future<List<Routine>> getRoutinesAssignedToStudent(int studentId);
}
