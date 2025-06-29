import '../../../../core/database/app_database.dart';

/// Repositorio abstracto para las rutinas del dashboard
/// Define el contrato para la capa de dominio siguiendo Clean Architecture
abstract class DashboardRoutinesRepository {
  /// Obtiene las rutinas programadas para hoy del usuario especificado
  Future<List<DbRoutine>> getTodaysRoutinesForUser(int userId);
}
