import '../../../../core/database/app_database.dart';
import '../../domain/repositories/dashboard_routines_repository.dart';
import '../datasources/dashboard_routines_data_source.dart';

/// Implementación del repositorio para rutinas del dashboard
/// Implementa la capa de datos siguiendo Clean Architecture
class DashboardRoutinesRepositoryImpl implements DashboardRoutinesRepository {
  final DashboardRoutinesDataSource _dataSource;

  DashboardRoutinesRepositoryImpl(this._dataSource);

  @override
  Future<List<DbRoutine>> getTodaysRoutinesForUser(int userId) async {
    print(
        '📚 DashboardRoutinesRepositoryImpl: Getting today\'s routines for user $userId');
    final routines = await _dataSource.getTodaysRoutinesForUser(userId);
    print(
        '📚 DashboardRoutinesRepositoryImpl: Data source returned ${routines.length} routines');
    return routines;
  }
}
