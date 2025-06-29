import '../entities/routine.dart';
import '../repositories/routines_repository.dart';

class GetStudentAssignedRoutinesUseCase {
  final RoutinesRepository repository;

  GetStudentAssignedRoutinesUseCase(this.repository);

  Future<List<Routine>> call(int studentId) async {
    return await repository.getRoutinesAssignedToStudent(studentId);
  }
}
