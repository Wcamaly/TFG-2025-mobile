import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/routine.dart';
import '../../domain/usecases/get_routines_usecase.dart';
import '../../domain/usecases/assign_routine_usecase.dart';
import '../../domain/repositories/routines_repository.dart';
import '../../data/repositories/routines_repository_impl.dart';
import '../../data/datasources/routines_local_data_source.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

// Provider para el repository
final routinesRepositoryProvider = Provider<RoutinesRepository>((ref) {
  final database = sl<AppDatabase>();
  final dataSource = RoutinesLocalDataSourceImpl(database);
  return RoutinesRepositoryImpl(dataSource);
});

// Provider para el use case
final getRoutinesUseCaseProvider = Provider<GetRoutinesUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return GetRoutinesUseCase(repository);
});

// Provider para otros use cases
final createRoutineUseCaseProvider = Provider<CreateRoutineUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return CreateRoutineUseCase(repository);
});

final updateRoutineUseCaseProvider = Provider<UpdateRoutineUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return UpdateRoutineUseCase(repository);
});

final deleteRoutineUseCaseProvider = Provider<DeleteRoutineUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return DeleteRoutineUseCase(repository);
});

final searchRoutinesUseCaseProvider = Provider<SearchRoutinesUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return SearchRoutinesUseCase(repository);
});

final duplicateRoutineUseCaseProvider =
    Provider<DuplicateRoutineUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return DuplicateRoutineUseCase(repository);
});

final assignRoutineUseCaseProvider = Provider<AssignRoutineUseCase>((ref) {
  final repository = ref.read(routinesRepositoryProvider);
  return AssignRoutineUseCase(repository);
});

class RoutinesState {
  final List<Routine> routines;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final int currentPage;
  final String currentFilter;
  final String currentSearch;

  const RoutinesState({
    this.routines = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.currentPage = 0,
    this.currentFilter = 'all',
    this.currentSearch = '',
  });

  RoutinesState copyWith({
    List<Routine>? routines,
    bool? isLoading,
    bool? hasMore,
    String? error,
    int? currentPage,
    String? currentFilter,
    String? currentSearch,
  }) {
    return RoutinesState(
      routines: routines ?? this.routines,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      currentFilter: currentFilter ?? this.currentFilter,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }
}

class RoutinesNotifier extends StateNotifier<RoutinesState> {
  final GetRoutinesUseCase _getRoutinesUseCase;
  final CreateRoutineUseCase _createRoutineUseCase;
  final UpdateRoutineUseCase _updateRoutineUseCase;
  final DeleteRoutineUseCase _deleteRoutineUseCase;
  final SearchRoutinesUseCase _searchRoutinesUseCase;
  final DuplicateRoutineUseCase _duplicateRoutineUseCase;
  final AssignRoutineUseCase _assignRoutineUseCase;
  final Ref _ref;

  RoutinesNotifier(
    this._getRoutinesUseCase,
    this._createRoutineUseCase,
    this._updateRoutineUseCase,
    this._deleteRoutineUseCase,
    this._searchRoutinesUseCase,
    this._duplicateRoutineUseCase,
    this._assignRoutineUseCase,
    this._ref,
  ) : super(const RoutinesState());

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

  Future<void> loadRoutines({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    final trainerId = _currentTrainerId;
    if (trainerId == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'Usuario no autenticado',
      );
      return;
    }

    if (refresh) {
      state = state.copyWith(isLoading: true, error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      print('📋 Loading routines for trainer $trainerId');

      List<Routine> routines;

      // Aplicar búsqueda si existe
      if (state.currentSearch.isNotEmpty) {
        routines =
            await _searchRoutinesUseCase.call(trainerId, state.currentSearch);
      } else {
        routines = await _getRoutinesUseCase.call(trainerId);
      }

      // Aplicar filtros
      if (state.currentFilter != 'all') {
        routines = _applyFilter(routines, state.currentFilter);
      }

      print('✅ Loaded ${routines.length} routines successfully');

      state = state.copyWith(
        routines: routines,
        isLoading: false,
        hasMore: false,
        currentPage: refresh ? 1 : state.currentPage + 1,
      );
    } catch (e) {
      print('❌ Error loading routines: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshRoutines() async {
    await loadRoutines(refresh: true);
  }

  Future<void> searchRoutines(String query) async {
    state = state.copyWith(currentSearch: query);
    await loadRoutines(refresh: true);
  }

  Future<void> filterRoutines(String filter) async {
    state = state.copyWith(currentFilter: filter);
    await loadRoutines(refresh: true);
  }

  Future<void> createRoutine(Routine routine) async {
    final trainerId = _currentTrainerId;
    if (trainerId == null) {
      state = state.copyWith(error: 'Usuario no autenticado');
      return;
    }

    try {
      final routineWithTrainer = routine.copyWith(createdBy: trainerId);
      await _createRoutineUseCase.call(routineWithTrainer);
      await refreshRoutines();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateRoutine(Routine routine) async {
    try {
      await _updateRoutineUseCase.call(routine);
      await refreshRoutines();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteRoutine(int routineId) async {
    try {
      await _deleteRoutineUseCase.call(routineId);
      await refreshRoutines();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> duplicateRoutine(int routineId, String newName) async {
    try {
      await _duplicateRoutineUseCase.call(routineId, newName);
      await refreshRoutines();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> assignRoutineToStudents({
    required int routineId,
    required List<int> studentIds,
    required DateTime scheduledDate,
  }) async {
    final trainerId = _currentTrainerId;
    if (trainerId == null) {
      state = state.copyWith(error: 'Usuario no autenticado');
      return;
    }

    try {
      await _assignRoutineUseCase.call(
        routineId: routineId,
        studentIds: studentIds,
        trainerId: trainerId,
        scheduledDate: scheduledDate,
      );

      // Recargar las rutinas para actualizar los contadores
      await refreshRoutines();
      print('✅ Routines refreshed after assignment');
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  List<Routine> _applyFilter(List<Routine> routines, String filter) {
    switch (filter) {
      case 'active':
        return routines.where((r) => r.status == RoutineStatus.active).toList();
      case 'paused':
        return routines.where((r) => r.status == RoutineStatus.paused).toList();
      case 'completed':
        return routines
            .where((r) => r.status == RoutineStatus.completed)
            .toList();
      case 'beginner':
        return routines
            .where((r) => r.difficulty == RoutineDifficulty.beginner)
            .toList();
      case 'intermediate':
        return routines
            .where((r) => r.difficulty == RoutineDifficulty.intermediate)
            .toList();
      case 'advanced':
        return routines
            .where((r) => r.difficulty == RoutineDifficulty.advanced)
            .toList();
      default:
        return routines;
    }
  }
}

final routinesProvider =
    StateNotifierProvider<RoutinesNotifier, RoutinesState>((ref) {
  final getRoutinesUseCase = ref.read(getRoutinesUseCaseProvider);
  final createRoutineUseCase = ref.read(createRoutineUseCaseProvider);
  final updateRoutineUseCase = ref.read(updateRoutineUseCaseProvider);
  final deleteRoutineUseCase = ref.read(deleteRoutineUseCaseProvider);
  final searchRoutinesUseCase = ref.read(searchRoutinesUseCaseProvider);
  final duplicateRoutineUseCase = ref.read(duplicateRoutineUseCaseProvider);
  final assignRoutineUseCase = ref.read(assignRoutineUseCaseProvider);

  return RoutinesNotifier(
    getRoutinesUseCase,
    createRoutineUseCase,
    updateRoutineUseCase,
    deleteRoutineUseCase,
    searchRoutinesUseCase,
    duplicateRoutineUseCase,
    assignRoutineUseCase,
    ref,
  );
});
