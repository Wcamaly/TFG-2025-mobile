import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<DashboardStats> call(int trainerId) async {
    return await repository.getDashboardStats(trainerId);
  }
}

class GetRecentStudentsUseCase {
  final DashboardRepository repository;

  GetRecentStudentsUseCase(this.repository);

  Future<List<RecentStudent>> call(int trainerId, {int limit = 5}) async {
    return await repository.getRecentStudents(trainerId, limit: limit);
  }
}

class GetTopRoutinesUseCase {
  final DashboardRepository repository;

  GetTopRoutinesUseCase(this.repository);

  Future<List<TopRoutine>> call(int trainerId, {int limit = 5}) async {
    return await repository.getTopRoutines(trainerId, limit: limit);
  }
}
