import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../trainer_routines/domain/entities/routine.dart';
import '../../../trainer_routines/domain/usecases/get_student_assigned_routines_usecase.dart';
import '../../../../core/di/injection_container.dart';

// Provider para el use case
final getStudentAssignedRoutinesUseCaseProvider =
    Provider<GetStudentAssignedRoutinesUseCase>(
        (ref) => sl<GetStudentAssignedRoutinesUseCase>());

// Estado para las rutinas del estudiante
class StudentRoutinesState {
  final List<Routine> routines;
  final bool isLoading;
  final String? error;

  const StudentRoutinesState({
    this.routines = const [],
    this.isLoading = false,
    this.error,
  });

  StudentRoutinesState copyWith({
    List<Routine>? routines,
    bool? isLoading,
    String? error,
  }) {
    return StudentRoutinesState(
      routines: routines ?? this.routines,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Provider para gestionar las rutinas asignadas a un estudiante
class StudentRoutinesNotifier extends StateNotifier<StudentRoutinesState> {
  final GetStudentAssignedRoutinesUseCase _getStudentAssignedRoutinesUseCase;

  StudentRoutinesNotifier(this._getStudentAssignedRoutinesUseCase)
      : super(const StudentRoutinesState());

  Future<void> loadRoutinesForStudent(int studentId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final routines = await _getStudentAssignedRoutinesUseCase.call(studentId);
      state = state.copyWith(
        routines: routines,
        isLoading: false,
      );
      print('✅ Loaded ${routines.length} routines for student $studentId');
    } catch (e) {
      print('❌ Error loading routines for student: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearRoutines() {
    state = const StudentRoutinesState();
  }
}

// Provider para un estudiante específico
final studentRoutinesProvider =
    StateNotifierProvider<StudentRoutinesNotifier, StudentRoutinesState>((ref) {
  final useCase = ref.watch(getStudentAssignedRoutinesUseCaseProvider);
  return StudentRoutinesNotifier(useCase);
});
