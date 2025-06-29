import '../entities/routine.dart';
import '../repositories/routines_repository.dart';

class AssignRoutineUseCase {
  final RoutinesRepository repository;

  AssignRoutineUseCase(this.repository);

  Future<void> call({
    required int routineId,
    required List<int> studentIds,
    required int trainerId,
    required DateTime scheduledDate,
  }) async {
    await repository.assignRoutineToStudents(
      routineId: routineId,
      studentIds: studentIds,
      trainerId: trainerId,
      scheduledDate: scheduledDate,
    );
  }
}
