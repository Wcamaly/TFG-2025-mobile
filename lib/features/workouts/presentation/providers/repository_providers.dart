import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../data/datasources/workout_remote_data_source.dart';

final workoutRemoteDataSourceProvider =
    Provider<WorkoutRemoteDataSource>((ref) {
  return WorkoutRemoteDataSourceImpl();
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(ref.watch(workoutRemoteDataSourceProvider));
});
