import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/exercise_types.dart' as workout_exercise;
import '../providers/workout_progress_provider.dart';
import '../providers/advanced_workout_provider.dart';
import '../providers/workout_routines_provider.dart';
import '../widgets/weekly_monitoring_card.dart';
import '../widgets/workout_calendar_selector.dart';
import '../widgets/flexible_exercise_card.dart';
import '../widgets/advanced_stats_card.dart';
import '../widgets/exercise_demo_card.dart';
import 'workout_detail_page.dart';
import 'workout_history_page.dart';
import '../../domain/entities/workout_progress.dart';
import '../../domain/entities/workout.dart';
import '../../../trainer_routines/domain/entities/routine.dart'
    as routine_entity;
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/routines_table.dart';
import 'dart:convert';
import '../providers/all_assigned_routines_provider.dart';

class WorkoutsPage extends ConsumerStatefulWidget {
  const WorkoutsPage({super.key});

  @override
  ConsumerState<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends ConsumerState<WorkoutsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Función estática para convertir DbRoutine a Routine
  static routine_entity.Routine _convertDbRoutineToRoutine(
      DbRoutine dbRoutine) {
    List<routine_entity.Exercise> exercises = [];

    // Parsear los ejercicios desde JSON si existe
    if (dbRoutine.exercisesJson != null &&
        dbRoutine.exercisesJson!.isNotEmpty) {
      try {
        final List<dynamic> exercisesJson =
            json.decode(dbRoutine.exercisesJson!);
        exercises = exercisesJson
            .map((json) => routine_entity.Exercise.fromJson(json))
            .toList();
      } catch (e) {
        print('Error parsing exercises JSON: $e');
      }
    }

    return routine_entity.Routine(
      id: dbRoutine.id,
      name: dbRoutine.name,
      description: dbRoutine.description,
      category: dbRoutine.category,
      duration: dbRoutine.durationMinutes,
      difficulty: _convertDifficulty(dbRoutine.difficulty),
      status: _convertStatus(dbRoutine.status),
      createdBy: dbRoutine.createdBy,
      createdAt: dbRoutine.createdAt,
      updatedAt: dbRoutine.updatedAt,
      exercises: exercises,
      assignedStudents: 0, // TODO: Calcular desde la base de datos
      avgRating: 0.0, // TODO: Calcular desde la base de datos
    );
  }

  static routine_entity.RoutineDifficulty _convertDifficulty(
      DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return routine_entity.RoutineDifficulty.beginner;
      case DifficultyLevel.intermediate:
        return routine_entity.RoutineDifficulty.intermediate;
      case DifficultyLevel.advanced:
        return routine_entity.RoutineDifficulty.advanced;
    }
  }

  static routine_entity.RoutineStatus _convertStatus(RoutineStatus dbStatus) {
    switch (dbStatus) {
      case RoutineStatus.active:
        return routine_entity.RoutineStatus.active;
      case RoutineStatus.paused:
        return routine_entity.RoutineStatus.paused;
      case RoutineStatus.completed:
        return routine_entity.RoutineStatus.completed;
      case RoutineStatus.cancelled:
        return routine_entity.RoutineStatus.paused; // Mapear cancelled a paused
    }
  }

  // Función para convertir Routine a DailyGoal para workout_detail_page
  static DailyGoal _convertRoutineToDailyGoal(routine_entity.Routine routine) {
    return DailyGoal(
      id: routine.id.toString(),
      title: routine.name,
      description: routine.description,
      isCompleted: false, // Por defecto no completado
      order: 1,
      type: _getGoalTypeFromCategory(routine.category),
    );
  }

  // Función para mapear categorías de rutina a tipos de goal
  static GoalType? _getGoalTypeFromCategory(String category) {
    switch (category.toLowerCase()) {
      case 'fuerza':
      case 'strength':
        return GoalType.strength;
      case 'cardio':
      case 'cardiovascular':
        return GoalType.cardio;
      case 'calentamiento':
      case 'warmup':
        return GoalType.warmUp;
      case 'enfriamiento':
      case 'cooldown':
        return GoalType.coolDown;
      default:
        return GoalType.strength; // Por defecto
    }
  }

  // Función para convertir ejercicios de la rutina a WorkoutExercise
  static List<WorkoutExercise> _convertRoutineExercisesToWorkoutExercises(
      List<routine_entity.Exercise> routineExercises) {
    return routineExercises
        .map((exercise) => WorkoutExercise(
              name: exercise.name,
              description: exercise.description,
              imageUrl:
                  exercise.imageUrl ?? 'assets/images/exercises/default.png',
              videoUrl: exercise.videoUrl ?? '',
              sets: exercise.sets,
              reps: exercise.reps,
              restTime: exercise.restTime,
              equipment:
                  'Equipment', // TODO: Mapear desde la rutina si está disponible
              muscleGroup:
                  'Muscle Group', // TODO: Mapear desde la rutina si está disponible
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Build your Body',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Workout'),
                  Tab(text: 'Calendario'),
                  Tab(text: 'Estadísticas'),
                ],
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: AppTextStyles.bodySmall,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: 16),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _WorkoutOfTheDayTab(),
                  _CalendarTab(),
                  _MyStatsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          'Workouts',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkoutHistoryPage(),
                ),
              );
            },
            tooltip: 'Historial de entrenamientos',
          ),
        ],
      ),
    );
  }
}

class _WorkoutOfTheDayTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutRoutinesAsync = ref.watch(workoutRoutinesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(workoutRoutinesProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Entrenamiento de Hoy',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rutinas Asignadas',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Rutinas asignadas para hoy
            workoutRoutinesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error: $error',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              data: (routines) {
                if (routines.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.fitness_center_outlined,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tienes rutinas asignadas para hoy',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Contacta a tu entrenador para que te asigne una rutina',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutinas del Día (${routines.length})',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...routines
                        .map((routine) => Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  routine.name,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  routine.description ?? 'Sin descripción',
                                  style: AppTextStyles.bodyMedium,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textSecondary,
                                ),
                                onTap: () {
                                  final convertedRoutine = _WorkoutsPageState
                                      ._convertDbRoutineToRoutine(routine);
                                  final dailyGoal = _WorkoutsPageState
                                      ._convertRoutineToDailyGoal(
                                          convertedRoutine);
                                  final workoutExercises = _WorkoutsPageState
                                      ._convertRoutineExercisesToWorkoutExercises(
                                          convertedRoutine.exercises);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkoutDetailPage(
                                        goal: dailyGoal,
                                        customExercises: workoutExercises,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ))
                        .toList(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<_CalendarTab> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final routinesForSelectedDateAsync =
        ref.watch(assignedRoutinesByDateProvider(_selectedDate));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Planificación de Entrenamientos',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          WorkoutCalendarSelector(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              final normalizedDate = DateTime(date.year, date.month, date.day);
              setState(() {
                _selectedDate = normalizedDate;
              });
              // Invalidar el provider para recargar datos
              ref.invalidate(assignedRoutinesByDateProvider(normalizedDate));
              print(
                  '🔄 Date selected: ${normalizedDate.toString()}, invalidating provider');
            },
          ),

          const SizedBox(height: 24),

          Text(
            'Rutinas del ${_formatDate(_selectedDate)}',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Mostrar rutinas asignadas para la fecha seleccionada
          routinesForSelectedDateAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
            data: (routines) {
              if (routines.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tienes rutinas asignadas para este día',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Selecciona otra fecha o contacta a tu entrenador',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: routines
                    .map((routine) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              routine.name,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  routine.description ?? 'Sin descripción',
                                  style: AppTextStyles.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${routine.durationMinutes} min',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(
                                      Icons.category,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      routine.category,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textSecondary,
                            ),
                            onTap: () {
                              final convertedRoutine =
                                  _WorkoutsPageState._convertDbRoutineToRoutine(
                                      routine);
                              final dailyGoal =
                                  _WorkoutsPageState._convertRoutineToDailyGoal(
                                      convertedRoutine);
                              final workoutExercises = _WorkoutsPageState
                                  ._convertRoutineExercisesToWorkoutExercises(
                                      convertedRoutine.exercises);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkoutDetailPage(
                                    goal: dailyGoal,
                                    customExercises: workoutExercises,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]}';
  }
}

class _MyStatsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyStatsAsync = ref.watch(weeklyStatsProvider);
    final advancedWorkoutAsync = ref.watch(advancedWorkoutProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(weeklyStatsProvider.notifier).refreshStats();
        await ref.read(advancedWorkoutProvider.notifier).refreshWorkoutData();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Estadísticas avanzadas
            advancedWorkoutAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error: $error',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              data: (workoutState) => AdvancedStatsCard(
                personalRecords: workoutState.personalRecords,
                recentSessions: workoutState.recentSessions,
                title: 'Estadísticas Avanzadas',
              ),
            ),

            // Estadísticas semanales
            weeklyStatsAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
              data: (weeklyStats) => WeeklyMonitoringCard(
                weeklyStats: weeklyStats,
                title: 'Progreso Semanal',
                subtitle: 'Monitoreo diario',
                onTap: () {
                  // Navigate to detailed stats
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
