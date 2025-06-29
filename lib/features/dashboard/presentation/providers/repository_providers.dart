import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../data/datasources/stats_local_data_source.dart';
import '../../data/repositories/stats_repository_impl.dart';
import '../../domain/repositories/stats_repository.dart';

final statsLocalDataSourceProvider = Provider<StatsLocalDataSource>((ref) {
  final database = sl<AppDatabase>();
  return StatsLocalDataSourceImpl(database);
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  final localDataSource = ref.watch(statsLocalDataSourceProvider);
  final database = sl<AppDatabase>();
  return StatsRepositoryImpl(localDataSource, database);
});
