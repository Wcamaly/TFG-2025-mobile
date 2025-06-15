import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/workout.dart';

part 'workouts_state.freezed.dart';

@freezed
class WorkoutsState with _$WorkoutsState {
  const factory WorkoutsState.initial() = _Initial;
  const factory WorkoutsState.loading() = _Loading;
  const factory WorkoutsState.loaded({
    required List<Workout> workouts,
    required List<String> categories,
    required List<String> difficulties,
    String? selectedCategory,
    String? selectedDifficulty,
  }) = _Loaded;
  const factory WorkoutsState.error(String message) = _Error;
}
