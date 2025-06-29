import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../authentication/domain/entities/user.dart';
import 'package:drift/drift.dart';

// Provider para todas las rutinas asignadas
final allAssignedRoutinesProvider =
    FutureProvider<List<DbRoutine>>((ref) async {
  final authState = ref.read(authProvider);
  User? user;

  authState.when(
    initial: () => user = null,
    loading: () => user = null,
    authenticated: (authenticatedUser) => user = authenticatedUser,
    unauthenticated: (message) => user = null,
  );

  if (user == null) return [];

  try {
    final database = sl<AppDatabase>();
    final userId = int.tryParse(user!.id);
    if (userId == null) return [];

    // Buscar el estudiante asociado al usuario
    final student = await (database.select(database.students)
          ..where((s) => s.userId.equals(userId)))
        .getSingleOrNull();

    if (student == null) return [];

    // Obtener todas las rutinas asignadas al estudiante
    final assignedRoutines = await (database.select(database.studentRoutines)
          ..where((sr) => sr.studentId.equals(student.id)))
        .get();

    if (assignedRoutines.isEmpty) return [];

    // Obtener los IDs de las rutinas asignadas
    final routineIds = assignedRoutines.map((sr) => sr.routineId).toList();

    // Obtener las rutinas completas
    final routines = await (database.select(database.routines)
          ..where((r) => r.id.isIn(routineIds)))
        .get();

    return routines;
  } catch (e) {
    print('❌ Error loading all assigned routines: $e');
    return [];
  }
});

// Provider para rutinas asignadas en una fecha específica
final assignedRoutinesByDateProvider =
    FutureProvider.family<List<DbRoutine>, DateTime>((ref, date) async {
  final authState = ref.read(authProvider);
  User? user;

  authState.when(
    initial: () => user = null,
    loading: () => user = null,
    authenticated: (authenticatedUser) => user = authenticatedUser,
    unauthenticated: (message) => user = null,
  );

  if (user == null) return [];

  try {
    final database = sl<AppDatabase>();
    final userId = int.tryParse(user!.id);
    if (userId == null) return [];

    // Obtener el studentId asociado al usuario
    final student = await (database.select(database.students)
          ..where((s) => s.userId.equals(userId)))
        .getSingleOrNull();
    if (student == null) return [];

    // Rango de fecha para el día seleccionado
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    print(
        '📅 [CALENDAR] startOfDay: $startOfDay (${startOfDay.timeZoneName}), endOfDay: $endOfDay (${endOfDay.timeZoneName})');

    // JOIN rutinas y asignaciones, filtrando por studentId, scheduledDate y status active
    final query = database.select(database.routines).join([
      innerJoin(
        database.studentRoutines,
        database.studentRoutines.routineId.equalsExp(database.routines.id),
      ),
    ])
      ..where(database.studentRoutines.studentId.equals(student.id))
      ..where(database.studentRoutines.scheduledDate
          .isBiggerOrEqualValue(startOfDay))
      ..where(
          database.studentRoutines.scheduledDate.isSmallerThanValue(endOfDay))
      ..where(database.studentRoutines.status.equalsValue(RoutineStatus.active))
      ..orderBy([OrderingTerm.asc(database.studentRoutines.scheduledDate)]);

    final results = await query.get();
    print('📅 [CALENDAR] Query returned ${results.length} rows');
    for (final row in results) {
      final routine = row.readTable(database.routines);
      final assignment = row.readTable(database.studentRoutines);
      print(
          '📅 [CALENDAR] Routine: ${routine.name} (ID: ${routine.id}) | scheduledDate: ${assignment.scheduledDate} (${assignment.scheduledDate.timeZoneName}) | status: ${assignment.status}');
    }

    final routines =
        results.map((row) => row.readTable(database.routines)).toList();

    return routines;
  } catch (e) {
    print('❌ Error loading assigned routines for date $date: $e');
    return [];
  }
});
