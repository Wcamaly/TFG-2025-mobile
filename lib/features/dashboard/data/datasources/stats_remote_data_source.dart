import '../../domain/entities/user_stats.dart';

abstract class StatsRemoteDataSource {
  Future<UserStats> getCurrentStats();
  Future<void> updateStats(UserStats stats);
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  // Aquí iría la implementación con tu servicio de backend real
  // Por ejemplo, una API REST, Firebase, etc.

  @override
  Future<UserStats> getCurrentStats() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> updateStats(UserStats stats) async {
    // Implementación real aquí
    throw UnimplementedError();
  }
}
