import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/trainer.dart';
import '../../data/repositories/trainer_repository_impl.dart';
import '../../data/datasources/trainer_local_data_source.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';

final trainerLocalDataSourceProvider = Provider((ref) {
  final database = sl<AppDatabase>();
  return TrainerLocalDataSourceImpl(database);
});

final trainerRepositoryProvider = Provider((ref) {
  final localDataSource = ref.watch(trainerLocalDataSourceProvider);
  return TrainerRepositoryImpl(localDataSource: localDataSource);
});

final trainerSearchProvider =
    StateNotifierProvider<TrainerSearchNotifier, TrainerSearchState>((ref) {
  return TrainerSearchNotifier(ref.watch(trainerRepositoryProvider));
});

class TrainerSearchNotifier extends StateNotifier<TrainerSearchState> {
  final TrainerRepositoryImpl _repository;

  TrainerSearchNotifier(this._repository)
      : super(const TrainerSearchState.initial());

  Future<void> searchTrainers(String query) async {
    state = const TrainerSearchState.loading();

    try {
      final result = await _repository.searchTrainers(query);
      result.fold(
        (failure) => state = TrainerSearchState.error(failure.message),
        (trainers) => state = TrainerSearchState.loaded(trainers),
      );
    } catch (e) {
      state = TrainerSearchState.error(e.toString());
    }
  }

  Future<void> getTrainersByLocation(
      double latitude, double longitude, double radiusKm) async {
    state = const TrainerSearchState.loading();

    try {
      final result = await _repository.getTrainersByLocation(
          latitude, longitude, radiusKm);
      result.fold(
        (failure) => state = TrainerSearchState.error(failure.message),
        (trainers) => state = TrainerSearchState.loaded(trainers),
      );
    } catch (e) {
      state = TrainerSearchState.error(e.toString());
    }
  }
}

class TrainerSearchState {
  const TrainerSearchState();

  const factory TrainerSearchState.initial() = _Initial;
  const factory TrainerSearchState.loading() = _Loading;
  const factory TrainerSearchState.loaded(List<Trainer> trainers) = _Loaded;
  const factory TrainerSearchState.error(String message) = _Error;

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Trainer> trainers) loaded,
    required T Function(String message) error,
  }) {
    if (this is _Initial) return initial();
    if (this is _Loading) return loading();
    if (this is _Loaded) return loaded((this as _Loaded).trainers);
    if (this is _Error) return error((this as _Error).message);
    throw Exception('Unknown state');
  }
}

class _Initial extends TrainerSearchState {
  const _Initial();
}

class _Loading extends TrainerSearchState {
  const _Loading();
}

class _Loaded extends TrainerSearchState {
  final List<Trainer> trainers;
  const _Loaded(this.trainers);
}

class _Error extends TrainerSearchState {
  final String message;
  const _Error(this.message);
}
