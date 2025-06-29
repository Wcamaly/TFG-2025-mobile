import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../trainer_dashboard/domain/entities/student.dart';
import '../../domain/repositories/students_repository.dart';
import '../../data/repositories/students_repository_impl.dart';
import '../../data/datasources/students_local_data_source.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection_container.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../../core/database/tables/users_table.dart'; // Para UserRole

class StudentsState {
  final List<Student> students;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final int currentPage;

  const StudentsState({
    this.students = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.currentPage = 0,
  });

  StudentsState copyWith({
    List<Student>? students,
    bool? isLoading,
    bool? hasMore,
    String? error,
    int? currentPage,
  }) {
    return StudentsState(
      students: students ?? this.students,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class StudentsNotifier extends StateNotifier<StudentsState> {
  final StudentsRepository _repository;
  final Ref _ref;

  StudentsNotifier(this._repository, this._ref) : super(const StudentsState());

  // Obtener el ID del entrenador autenticado
  int? get _currentTrainerId {
    final authState = _ref.read(authProvider);
    return authState.when(
      initial: () => null,
      loading: () => null,
      authenticated: (user) => int.tryParse(user.id),
      unauthenticated: (_) => null,
    );
  }

  Future<void> loadStudents({bool refresh = false}) async {
    if (state.isLoading) return;

    final trainerId = _currentTrainerId;
    print('🔍 Loading students for trainer ID: $trainerId');

    if (trainerId == null) {
      print('❌ No trainer ID found - user not authenticated');
      state = state.copyWith(
        isLoading: false,
        error: 'Usuario no autenticado',
      );
      return;
    }

    if (refresh) {
      state = const StudentsState(isLoading: true);
    } else {
      if (!state.hasMore) return;
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      print('📊 Loading students from database...');
      final students = await _repository.getStudentsByTrainer(trainerId);
      print('📋 Found ${students.length} students for trainer $trainerId');

      // Debug: Mostrar información de cada estudiante
      for (final student in students) {
        print(
            '   - Student: ${student.name} (ID: ${student.id}, UserID: ${student.userId})');
      }

      state = state.copyWith(
        students: students,
        isLoading: false,
        hasMore: false, // Por ahora no implementamos paginación
        currentPage: refresh ? 1 : state.currentPage + 1,
      );
    } catch (e) {
      print('❌ Error loading students: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshStudents() async {
    await loadStudents(refresh: true);
  }

  // Método específico para debug y reinicialización
  Future<void> debugReinitializeStudents() async {
    print('🔄 DEBUG: Starting complete database reinitialization...');

    try {
      // 1. Limpiar estado
      state = const StudentsState(isLoading: true);

      // 2. Obtener database
      final database = sl<AppDatabase>();

      // 3. Usar el nuevo método completo que resetea todo y obtiene el ID real del entrenador
      print('🔄 DEBUG: Using complete database reset...');
      await database.resetDatabaseForTrainer(
          0); // El parámetro no se usa, se obtiene del JSON

      // 4. Obtener el ID real del entrenador insertado
      final trainers = await (database.select(database.users)
            ..where((u) => u.role.equalsValue(UserRole.trainer)))
          .get();

      if (trainers.isEmpty) {
        throw Exception('No trainer found after database reset');
      }

      final realTrainerId = trainers.first.id;
      print('👨‍💼 DEBUG: Real trainer ID found: $realTrainerId');

      // 5. Verificar que se crearon correctamente
      print('✅ DEBUG: Verifying students creation...');
      final students = await _repository.getStudentsByTrainer(realTrainerId);
      print(
          '📊 DEBUG: Found ${students.length} students for trainer $realTrainerId');

      for (final student in students) {
        print(
            '   📝 Student: ${student.name} (UserID: ${student.userId}, TrainerID: ${student.trainerId})');
      }

      // 6. Actualizar estado
      state = state.copyWith(
        students: students,
        isLoading: false,
        hasMore: false,
        error: null,
      );

      print('✅ DEBUG: Complete reinitialization completed successfully');
    } catch (e) {
      print('❌ DEBUG: Error during complete reinitialization: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void searchStudents(String query) async {
    final trainerId = _currentTrainerId;
    if (trainerId == null) return;

    try {
      state = state.copyWith(isLoading: true);
      final students = await _repository.searchStudents(trainerId, query);
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterStudents(String filter) async {
    final trainerId = _currentTrainerId;
    if (trainerId == null) return;

    try {
      state = state.copyWith(isLoading: true);
      StudentStatus? status;

      switch (filter) {
        case 'active':
          status = StudentStatus.active;
          break;
        case 'inactive':
          status = StudentStatus.inactive;
          break;
        case 'suspended':
          status = StudentStatus.suspended;
          break;
        default:
          status = null;
      }

      final students = await _repository.filterStudents(trainerId, status);
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateStudentStatus(
      String studentId, StudentStatus newStatus) async {
    try {
      await _repository.updateStudentStatus(int.parse(studentId), newStatus);

      // Actualizar el estado local
      final updatedStudents = state.students.map((student) {
        if (student.id == studentId) {
          return student.copyWith(
            status: newStatus,
            updatedAt: DateTime.now(),
          );
        }
        return student;
      }).toList();

      state = state.copyWith(students: updatedStudents);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<void> updateStudentNotes(String studentId, String notes) async {
    try {
      await _repository.updateStudentNotes(int.parse(studentId), notes);

      // Actualizar el estado local
      final updatedStudents = state.students.map((student) {
        if (student.id == studentId) {
          return student.copyWith(
            notes: notes.isEmpty ? null : notes,
            updatedAt: DateTime.now(),
          );
        }
        return student;
      }).toList();

      state = state.copyWith(students: updatedStudents);
      print('✅ Updated notes for student $studentId');
    } catch (e) {
      print('❌ Error updating student notes: $e');
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }
}

// Provider para el repository
final studentsRepositoryProvider = Provider<StudentsRepository>((ref) {
  final database = sl<AppDatabase>();
  final dataSource = StudentsLocalDataSourceImpl(database);
  return StudentsRepositoryImpl(dataSource);
});

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, StudentsState>((ref) {
  final repository = ref.read(studentsRepositoryProvider);
  return StudentsNotifier(repository, ref);
});
