import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart';
import '../../../../core/database/tables/students_table.dart';
import '../../../../core/database/tables/users_table.dart';

/// Data source abstracto para las rutinas del dashboard
/// Sigue el patrón de puertos y adaptadores (Hexagonal Architecture)
abstract class DashboardRoutinesDataSource {
  /// Obtiene las rutinas programadas para hoy del usuario especificado
  Future<List<DbRoutine>> getTodaysRoutinesForUser(int userId);
}

/// Implementación del data source para rutinas del dashboard
/// Implementa la capa de infraestructura siguiendo Clean Architecture
class DashboardRoutinesDataSourceImpl implements DashboardRoutinesDataSource {
  final AppDatabase _database;

  DashboardRoutinesDataSourceImpl(this._database);

  @override
  Future<List<DbRoutine>> getTodaysRoutinesForUser(int userId) async {
    print(
        '🔍 DashboardRoutinesDataSource: Getting today\'s routines for user $userId');

    try {
      // Primero, obtener el studentId asociado al userId
      final student = await (_database.select(_database.students)
            ..where((s) => s.userId.equals(userId)))
          .getSingleOrNull();

      if (student == null) {
        print('⚠️ No student found for user $userId');
        return [];
      }

      print('✅ Found student ${student.id} for user $userId');

      // Consulta directa: obtener rutinas asignadas para hoy al estudiante
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      print(
          '📅 Looking for routines on ${today.toIso8601String().split('T')[0]} for student ${student.id}');

      // Consulta directa: DbStudentRoutine JOIN DbRoutine WHERE studentId = ? AND scheduledDate = today
      final query = _database.select(_database.routines).join([
        innerJoin(
          _database.studentRoutines,
          _database.studentRoutines.routineId.equalsExp(_database.routines.id),
        ),
      ])
        ..where(_database.studentRoutines.studentId.equals(student.id))
        ..where(_database.studentRoutines.scheduledDate
            .isBiggerOrEqualValue(startOfDay))
        ..where(_database.studentRoutines.scheduledDate
            .isSmallerThanValue(endOfDay))
        ..where(
            _database.studentRoutines.status.equalsValue(RoutineStatus.active))
        ..orderBy([OrderingTerm.asc(_database.studentRoutines.scheduledDate)]);

      final results = await query.get();
      final routines =
          results.map((row) => row.readTable(_database.routines)).toList();

      print(
          '📋 Found ${routines.length} routines for student ${student.id} today');
      for (final routine in routines) {
        print('   - ${routine.name} (ID: ${routine.id})');
      }

      return routines;
    } catch (e) {
      print('❌ Error getting today\'s routines for user: $e');
      return [];
    }
  }
}
