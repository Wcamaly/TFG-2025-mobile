import '../entities/routine.dart';
import '../repositories/routines_repository.dart';

class GetRoutinesUseCase {
  final RoutinesRepository repository;

  GetRoutinesUseCase(this.repository);

  Future<List<Routine>> call(int trainerId) async {
    return await repository.getRoutinesByTrainer(trainerId);
  }
}

class GetRoutineByIdUseCase {
  final RoutinesRepository repository;

  GetRoutineByIdUseCase(this.repository);

  Future<Routine?> call(int routineId) async {
    return await repository.getRoutineById(routineId);
  }
}

class CreateRoutineUseCase {
  final RoutinesRepository repository;

  CreateRoutineUseCase(this.repository);

  Future<Routine> call(Routine routine) async {
    return await repository.createRoutine(routine);
  }
}

class UpdateRoutineUseCase {
  final RoutinesRepository repository;

  UpdateRoutineUseCase(this.repository);

  Future<Routine> call(Routine routine) async {
    return await repository.updateRoutine(routine);
  }
}

class DeleteRoutineUseCase {
  final RoutinesRepository repository;

  DeleteRoutineUseCase(this.repository);

  Future<void> call(int routineId) async {
    await repository.deleteRoutine(routineId);
  }
}

class SearchRoutinesUseCase {
  final RoutinesRepository repository;

  SearchRoutinesUseCase(this.repository);

  Future<List<Routine>> call(int trainerId, String query) async {
    return await repository.searchRoutines(trainerId, query);
  }
}

class DuplicateRoutineUseCase {
  final RoutinesRepository repository;

  DuplicateRoutineUseCase(this.repository);

  Future<Routine> call(int routineId, String newName) async {
    return await repository.duplicateRoutine(routineId, newName);
  }
}
