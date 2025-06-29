import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dashboard/presentation/providers/dashboard_routines_provider.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart';
import '../../../../core/di/injection_container.dart';

// Provider que carga las rutinas asignadas al usuario autenticado para la página de workouts
final workoutRoutinesProvider = FutureProvider<List<DbRoutine>>((ref) async {
  print('🔄 workoutRoutinesProvider: Starting to load routines');

  final authState = ref.watch(authProvider);

  return authState.when(
    initial: () {
      print(
          '🔄 workoutRoutinesProvider: Auth state is initial, returning empty list');
      return [];
    },
    loading: () {
      print(
          '🔄 workoutRoutinesProvider: Auth state is loading, returning empty list');
      return [];
    },
    authenticated: (user) async {
      print('🔄 workoutRoutinesProvider: User authenticated, loading routines');
      print('   User ID: ${user.id}');
      print('   User Email: ${user.email}');

      final userId = int.tryParse(user.id);
      if (userId == null) {
        print(
            '🔄 workoutRoutinesProvider: Invalid user ID, returning empty list');
        return [];
      }

      print('🔄 workoutRoutinesProvider: Getting use case and calling it');
      final useCase = ref.read(getTodaysRoutinesUseCaseProvider);

      try {
        final routines = await useCase.execute(userId);
        print(
            '🔄 workoutRoutinesProvider: Successfully loaded ${routines.length} routines');
        for (int i = 0; i < routines.length; i++) {
          final routine = routines[i];
          print('   Routine $i: ${routine.name} (ID: ${routine.id})');
        }
        return routines;
      } catch (e) {
        print('🔄 workoutRoutinesProvider: Error loading routines: $e');
        rethrow;
      }
    },
    unauthenticated: (message) {
      print(
          '🔄 workoutRoutinesProvider: User unauthenticated: $message, returning empty list');
      return [];
    },
  );
});

// Provider para obtener todas las rutinas asignadas (para el calendario)
final allAssignedRoutinesProvider =
    FutureProvider<List<DbRoutine>>((ref) async {
  print(
      '🔄 allAssignedRoutinesProvider: Starting to load all assigned routines');

  final authState = ref.watch(authProvider);

  return authState.when(
    initial: () {
      print(
          '🔄 allAssignedRoutinesProvider: Auth state is initial, returning empty list');
      return [];
    },
    loading: () {
      print(
          '🔄 allAssignedRoutinesProvider: Auth state is loading, returning empty list');
      return [];
    },
    authenticated: (user) async {
      print(
          '🔄 allAssignedRoutinesProvider: User authenticated, loading all routines');
      print('   User ID: ${user.id}');
      print('   User Email: ${user.email}');

      final userId = int.tryParse(user.id);
      if (userId == null) {
        print(
            '🔄 allAssignedRoutinesProvider: Invalid user ID, returning empty list');
        return [];
      }

      try {
        final database = sl<AppDatabase>();

        // Primero, obtener el studentId asociado al userId
        final student = await (database.select(database.students)
              ..where((s) => s.userId.equals(userId)))
            .getSingleOrNull();

        if (student == null) {
          print('⚠️ No student found for user $userId');
          return [];
        }

        print('✅ Found student ${student.id} for user $userId');

        // Consulta directa: obtener todas las rutinas asignadas al estudiante
        final studentRoutines = await (database.select(database.studentRoutines)
              ..where((sr) => sr.studentId.equals(student.id))
              ..where((sr) => sr.status.equalsValue(RoutineStatus.active)))
            .get();

        final routineIds = studentRoutines.map((sr) => sr.routineId).toList();

        if (routineIds.isEmpty) {
          return [];
        }

        final routines = await (database.select(database.routines)
              ..where((r) => r.id.isIn(routineIds)))
            .get();

        print(
            '📋 Found ${routines.length} total assigned routines for student ${student.id}');
        for (final routine in routines) {
          print('   - ${routine.name} (ID: ${routine.id})');
        }

        return routines;
      } catch (e) {
        print('🔄 allAssignedRoutinesProvider: Error loading routines: $e');
        rethrow;
      }
    },
    unauthenticated: (message) {
      print(
          '🔄 allAssignedRoutinesProvider: User unauthenticated: $message, returning empty list');
      return [];
    },
  );
});
