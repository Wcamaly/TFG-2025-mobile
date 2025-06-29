import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/students_table.dart';
import '../../../../core/database/tables/routines_table.dart';
import '../../../../core/database/tables/users_table.dart';
import 'package:drift/drift.dart';

abstract class DashboardLocalDataSource {
  Future<List<StudentWithUser>> getStudentsByTrainer(int trainerId);
  Future<List<DbRoutine>> getRoutinesByTrainer(int trainerId);
  Future<List<StudentWithUser>> getRecentStudents(int trainerId,
      {int limit = 5});
  Future<List<RoutineWithAssignments>> getTopRoutines(int trainerId,
      {int limit = 5});
  Future<double> calculateMonthlyIncome(int trainerId);
  Future<double> calculateTotalRevenue(int trainerId);
  Future<Map<String, int>> getStudentCountsByStatus(int trainerId);
}

class StudentWithUser {
  final DbStudent student;
  final DbUser user;

  StudentWithUser({required this.student, required this.user});
}

class RoutineWithAssignments {
  final DbRoutine routine;
  final int assignedCount;

  RoutineWithAssignments({required this.routine, required this.assignedCount});
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final AppDatabase database;

  DashboardLocalDataSourceImpl(this.database);

  @override
  Future<List<StudentWithUser>> getStudentsByTrainer(int trainerId) async {
    final query = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ])
      ..where(database.students.trainerId.equals(trainerId));

    final results = await query.get();

    return results.map((row) {
      final student = row.readTable(database.students);
      final user = row.readTable(database.users);
      return StudentWithUser(student: student, user: user);
    }).toList();
  }

  @override
  Future<List<DbRoutine>> getRoutinesByTrainer(int trainerId) async {
    return await (database.select(database.routines)
          ..where((r) => r.createdBy.equals(trainerId)))
        .get();
  }

  @override
  Future<List<StudentWithUser>> getRecentStudents(int trainerId,
      {int limit = 5}) async {
    final query = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ])
      ..where(database.students.trainerId.equals(trainerId))
      ..orderBy([OrderingTerm.desc(database.students.updatedAt)])
      ..limit(limit);

    final results = await query.get();

    return results.map((row) {
      final student = row.readTable(database.students);
      final user = row.readTable(database.users);
      return StudentWithUser(student: student, user: user);
    }).toList();
  }

  @override
  Future<List<RoutineWithAssignments>> getTopRoutines(int trainerId,
      {int limit = 5}) async {
    // Obtener rutinas del entrenador
    final routines = await (database.select(database.routines)
          ..where((r) => r.createdBy.equals(trainerId))
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)])
          ..limit(limit))
        .get();

    // Para cada rutina, contar cuántos estudiantes la tienen asignada
    final routinesWithAssignments = <RoutineWithAssignments>[];

    for (final routine in routines) {
      final assignedCount = await (database.selectOnly(database.studentRoutines)
            ..addColumns([database.studentRoutines.id.count()])
            ..where(database.studentRoutines.routineId.equals(routine.id)))
          .getSingle()
          .then((row) => row.read(database.studentRoutines.id.count()) ?? 0);

      routinesWithAssignments.add(
        RoutineWithAssignments(
          routine: routine,
          assignedCount: assignedCount,
        ),
      );
    }

    // Ordenar por número de asignaciones (descendente)
    routinesWithAssignments
        .sort((a, b) => b.assignedCount.compareTo(a.assignedCount));

    return routinesWithAssignments;
  }

  @override
  Future<double> calculateMonthlyIncome(int trainerId) async {
    final activeStudents = await (database.select(database.students)
          ..where((s) =>
              s.trainerId.equals(trainerId) &
              s.status.equalsValue(StudentStatus.active)))
        .get();

    double totalIncome = 0.0;
    for (final student in activeStudents) {
      totalIncome += student.monthlyFee;
    }

    return totalIncome;
  }

  @override
  Future<double> calculateTotalRevenue(int trainerId) async {
    // Calcular ingresos totales basado en todos los pagos históricos
    // Por ahora, simulamos con ingresos mensuales * 12 (año completo)
    final monthlyIncome = await calculateMonthlyIncome(trainerId);
    return monthlyIncome * 12; // Simulación de ingresos anuales
  }

  @override
  Future<Map<String, int>> getStudentCountsByStatus(int trainerId) async {
    final students = await (database.select(database.students)
          ..where((s) => s.trainerId.equals(trainerId)))
        .get();

    final counts = <String, int>{
      'active': 0,
      'inactive': 0,
      'suspended': 0,
    };

    for (final student in students) {
      final status = _mapStudentStatusToString(student.status);
      counts[status] = (counts[status] ?? 0) + 1;
    }

    return counts;
  }

  String _mapStudentStatusToString(StudentStatus status) {
    switch (status) {
      case StudentStatus.active:
        return 'active';
      case StudentStatus.inactive:
        return 'inactive';
      case StudentStatus.suspended:
        return 'suspended';
    }
  }
}
