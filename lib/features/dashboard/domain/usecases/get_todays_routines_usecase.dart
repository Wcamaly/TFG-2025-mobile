import '../../../../core/database/app_database.dart';
import '../repositories/dashboard_routines_repository.dart';

/// Use case para obtener las rutinas programadas para hoy
/// Implementa la lógica de negocio siguiendo Clean Architecture
class GetTodaysRoutinesUseCase {
  final DashboardRoutinesRepository _repository;

  GetTodaysRoutinesUseCase(this._repository);

  /// Ejecuta el use case para obtener las rutinas de hoy para un usuario
  Future<List<DbRoutine>> execute(int userId) async {
    print('🎯 GetTodaysRoutinesUseCase: Starting execution for user $userId');
    final routines = await _repository.getTodaysRoutinesForUser(userId);
    print(
        '🎯 GetTodaysRoutinesUseCase: Repository returned ${routines.length} routines');
    return routines;
  }
}
