import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/stats_repository_impl.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../data/datasources/stats_remote_data_source.dart';

final statsRemoteDataSourceProvider = Provider<StatsRemoteDataSource>((ref) {
  return StatsRemoteDataSourceImpl();
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepositoryImpl(ref.watch(statsRemoteDataSourceProvider));
});
