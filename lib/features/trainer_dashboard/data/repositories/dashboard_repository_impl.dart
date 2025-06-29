import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_data_source.dart';
import '../../../../core/database/tables/students_table.dart' as db_tables;
import '../../../../core/database/tables/routines_table.dart' as db_routines;

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl(this.localDataSource);

  @override
  Future<DashboardStats> getDashboardStats(int trainerId) async {
    // Obtener datos en paralelo para mejor performance
    final results = await Future.wait([
      localDataSource.getStudentsByTrainer(trainerId),
      localDataSource.getRoutinesByTrainer(trainerId),
      localDataSource.getRecentStudents(trainerId, limit: 5),
      localDataSource.getTopRoutines(trainerId, limit: 5),
      localDataSource.calculateMonthlyIncome(trainerId),
      localDataSource.calculateTotalRevenue(trainerId),
      localDataSource.getStudentCountsByStatus(trainerId),
    ]);

    final students = results[0] as List<StudentWithUser>;
    final routines = results[1] as List<dynamic>;
    final recentStudents = results[2] as List<StudentWithUser>;
    final topRoutines = results[3] as List<RoutineWithAssignments>;
    final monthlyIncome = results[4] as double;
    final totalRevenue = results[5] as double;
    final statusCounts = results[6] as Map<String, int>;

    // Calcular estadísticas
    final totalStudents = students.length;
    final activeStudents = statusCounts['active'] ?? 0;
    final inactiveStudents = statusCounts['inactive'] ?? 0;
    final suspendedStudents = statusCounts['suspended'] ?? 0;
    final totalRoutines = routines.length;
    final activeRoutines = routines
        .where((r) => r.status == db_routines.RoutineStatus.active)
        .length;

    return DashboardStats(
      totalStudents: totalStudents,
      activeStudents: activeStudents,
      inactiveStudents: inactiveStudents,
      suspendedStudents: suspendedStudents,
      totalRoutines: totalRoutines,
      activeRoutines: activeRoutines,
      monthlyIncome: monthlyIncome,
      totalRevenue: totalRevenue,
      recentStudents: recentStudents.map(_mapToRecentStudent).toList(),
      topRoutines: topRoutines.map(_mapToTopRoutine).toList(),
      incomeBreakdown: _generateIncomeBreakdown(monthlyIncome),
      studentsByStatus: _mapToStudentStatusCounts(statusCounts, totalStudents),
    );
  }

  @override
  Future<List<RecentStudent>> getRecentStudents(int trainerId,
      {int limit = 5}) async {
    final students =
        await localDataSource.getRecentStudents(trainerId, limit: limit);
    return students.map(_mapToRecentStudent).toList();
  }

  @override
  Future<List<TopRoutine>> getTopRoutines(int trainerId,
      {int limit = 5}) async {
    final routines =
        await localDataSource.getTopRoutines(trainerId, limit: limit);
    return routines.map(_mapToTopRoutine).toList();
  }

  @override
  Future<List<MonthlyIncomeItem>> getMonthlyIncomeBreakdown(
      int trainerId) async {
    final monthlyIncome =
        await localDataSource.calculateMonthlyIncome(trainerId);
    return _generateIncomeBreakdown(monthlyIncome);
  }

  @override
  Future<List<StudentStatusCount>> getStudentsByStatus(int trainerId) async {
    final statusCounts =
        await localDataSource.getStudentCountsByStatus(trainerId);
    final totalStudents =
        statusCounts.values.fold(0, (sum, count) => sum + count);
    return _mapToStudentStatusCounts(statusCounts, totalStudents);
  }

  @override
  Future<double> getMonthlyIncome(int trainerId) async {
    return await localDataSource.calculateMonthlyIncome(trainerId);
  }

  @override
  Future<double> getTotalRevenue(int trainerId) async {
    return await localDataSource.calculateTotalRevenue(trainerId);
  }

  // Métodos de mapeo privados
  RecentStudent _mapToRecentStudent(StudentWithUser studentWithUser) {
    final student = studentWithUser.student;
    final user = studentWithUser.user;

    return RecentStudent(
      id: student.id.toString(),
      name: '${user.firstName} ${user.lastName}',
      email: user.email,
      status: _mapStudentStatus(student.status),
      lastActivity: student.updatedAt ?? student.createdAt,
      photoUrl: 'https://i.pravatar.cc/150?img=${user.id}',
      progressPercentage: student.progressPercentage ?? 0.0,
      remainingClasses: student.remainingClasses ?? 0,
    );
  }

  TopRoutine _mapToTopRoutine(RoutineWithAssignments routineWithAssignments) {
    final routine = routineWithAssignments.routine;

    return TopRoutine(
      id: routine.id.toString(),
      name: routine.name,
      assignedStudents: routineWithAssignments.assignedCount,
      category: routine.category,
      difficulty: _mapDifficulty(routine.difficulty),
      durationMinutes: routine.durationMinutes,
      avgRating: 4.5, // Simulado por ahora
    );
  }

  List<MonthlyIncomeItem> _generateIncomeBreakdown(double monthlyIncome) {
    return [
      MonthlyIncomeItem(
        title: 'Suscripciones Básicas',
        amount: monthlyIncome * 0.6,
        category: 'subscriptions',
      ),
      MonthlyIncomeItem(
        title: 'Suscripciones Premium',
        amount: monthlyIncome * 0.25,
        category: 'subscriptions',
      ),
      MonthlyIncomeItem(
        title: 'Sesiones Personales',
        amount: monthlyIncome * 0.1,
        category: 'personal_training',
      ),
      MonthlyIncomeItem(
        title: 'Productos y Suplementos',
        amount: monthlyIncome * 0.05,
        category: 'products',
      ),
    ];
  }

  List<StudentStatusCount> _mapToStudentStatusCounts(
      Map<String, int> statusCounts, int totalStudents) {
    return statusCounts.entries.map((entry) {
      final percentage =
          totalStudents > 0 ? (entry.value / totalStudents * 100) : 0.0;
      return StudentStatusCount(
        status: entry.key,
        count: entry.value,
        percentage: percentage,
      );
    }).toList();
  }

  String _mapStudentStatus(db_tables.StudentStatus status) {
    switch (status) {
      case db_tables.StudentStatus.active:
        return 'Activo';
      case db_tables.StudentStatus.inactive:
        return 'Inactivo';
      case db_tables.StudentStatus.suspended:
        return 'Suspendido';
    }
  }

  String _mapDifficulty(db_routines.DifficultyLevel difficulty) {
    switch (difficulty) {
      case db_routines.DifficultyLevel.beginner:
        return 'Principiante';
      case db_routines.DifficultyLevel.intermediate:
        return 'Intermedio';
      case db_routines.DifficultyLevel.advanced:
        return 'Avanzado';
    }
  }

  String _mapRoutineStatus(db_routines.RoutineStatus status) {
    switch (status) {
      case db_routines.RoutineStatus.active:
        return 'Activa';
      case db_routines.RoutineStatus.completed:
        return 'Completada';
      case db_routines.RoutineStatus.paused:
        return 'Pausada';
      case db_routines.RoutineStatus.cancelled:
        return 'Cancelada';
    }
  }
}
