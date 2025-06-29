import '../entities/dashboard_stats.dart';

abstract class DashboardRepository {
  /// Obtiene las estadísticas completas del dashboard para un entrenador
  Future<DashboardStats> getDashboardStats(int trainerId);

  /// Obtiene los estudiantes recientes del entrenador
  Future<List<RecentStudent>> getRecentStudents(int trainerId, {int limit = 5});

  /// Obtiene las rutinas más populares del entrenador
  Future<List<TopRoutine>> getTopRoutines(int trainerId, {int limit = 5});

  /// Obtiene el desglose de ingresos mensuales
  Future<List<MonthlyIncomeItem>> getMonthlyIncomeBreakdown(int trainerId);

  /// Obtiene el conteo de estudiantes por estado
  Future<List<StudentStatusCount>> getStudentsByStatus(int trainerId);

  /// Calcula los ingresos mensuales totales
  Future<double> getMonthlyIncome(int trainerId);

  /// Obtiene el total de ingresos acumulados
  Future<double> getTotalRevenue(int trainerId);
}
