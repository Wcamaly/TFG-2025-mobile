import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../data/services/workout_session_service.dart';
import '../../../../core/database/tables/workout_sessions_table.dart';

final workoutHistoryProvider =
    FutureProvider.family<List<DbWorkoutSession>, int>(
  (ref, studentId) async {
    final sessionService = sl<WorkoutSessionService>();
    return await sessionService.getWorkoutSessionsByStudent(studentId);
  },
);

final exerciseSessionsProvider =
    FutureProvider.family<List<DbExerciseSession>, int>(
  (ref, workoutSessionId) async {
    final sessionService = sl<WorkoutSessionService>();
    return await sessionService
        .getExerciseSessionsByWorkoutSession(workoutSessionId);
  },
);

final exerciseSetsProvider = FutureProvider.family<List<DbExerciseSet>, int>(
  (ref, exerciseSessionId) async {
    final sessionService = sl<WorkoutSessionService>();
    return await sessionService
        .getExerciseSetsByExerciseSession(exerciseSessionId);
  },
);

// Provider para refrescar el estado de los ejercicios
final exerciseStatusProvider =
    StateNotifierProvider<ExerciseStatusNotifier, Map<String, bool>>(
  (ref) => ExerciseStatusNotifier(),
);

class ExerciseStatusNotifier extends StateNotifier<Map<String, bool>> {
  ExerciseStatusNotifier() : super({});

  void updateExerciseStatus(String exerciseName, bool isCompleted) {
    state = {...state, exerciseName: isCompleted};
  }

  void refreshAll() {
    state = {};
  }
}
