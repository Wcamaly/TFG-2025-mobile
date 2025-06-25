import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/exercise_types.dart';
import '../providers/workout_progress_provider.dart';
import '../providers/advanced_workout_provider.dart';
import '../widgets/weekly_monitoring_card.dart';
import '../widgets/workout_calendar_selector.dart';
import '../widgets/flexible_exercise_card.dart';
import '../widgets/advanced_stats_card.dart';
import '../widgets/exercise_demo_card.dart';

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
    );
  }
}

class _WorkoutOfTheDayTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advancedWorkoutAsync = ref.watch(advancedWorkoutProvider);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(advancedWorkoutProvider.notifier).refreshWorkoutData(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: advancedWorkoutAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          data: (workoutState) => Column(
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
                'Gym • CrossFit • Powerlifting',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Ejercicios del día
              ...workoutState.todaysExercises.map((exercise) {
                final existingStats = workoutState.todaysStats
                        .where((s) => s.exerciseId == exercise.id)
                        .isNotEmpty
                    ? workoutState.todaysStats
                        .firstWhere((s) => s.exerciseId == exercise.id)
                    : null;

                return FlexibleExerciseCard(
                  exercise: exercise,
                  currentStats: existingStats,
                  onStatsUpdated: (stats) {
                    ref
                        .read(advancedWorkoutProvider.notifier)
                        .updateExerciseStats(exercise.id, stats);
                  },
                );
              }).toList(),
            ],
          ),
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
    final advancedWorkoutAsync = ref.watch(advancedWorkoutProvider);

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
              setState(() {
                _selectedDate = date;
              });
              // Aquí cargarías el workout para la fecha seleccionada
              ref.read(advancedWorkoutProvider.notifier).refreshWorkoutData();
            },
          ),

          const SizedBox(height: 24),

          Text(
            'Entrenamientos para ${_formatDate(_selectedDate)}',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Mostrar ejercicios organizados por categoría
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
            data: (workoutState) => Column(
              children: [
                // Ejercicios de Fuerza
                if (workoutState.todaysExercises
                    .where((e) => e.category == ExerciseCategory.strength)
                    .isNotEmpty)
                  ExerciseDemoCard(
                    title: 'Entrenamiento de Fuerza 💪',
                    subtitle: 'Powerlifting y ejercicios de fuerza máxima',
                    exercises: workoutState.todaysExercises
                        .where((e) => e.category == ExerciseCategory.strength)
                        .toList(),
                  ),

                // WODs de CrossFit
                if (workoutState.todaysExercises
                    .where((e) => e.category == ExerciseCategory.crossfit)
                    .isNotEmpty)
                  ExerciseDemoCard(
                    title: 'WODs de CrossFit 🔥',
                    subtitle: 'AMRAPs, EMOMs y entrenamientos for time',
                    exercises: workoutState.todaysExercises
                        .where((e) => e.category == ExerciseCategory.crossfit)
                        .toList(),
                  ),

                // Ejercicios Compuestos
                if (workoutState.todaysExercises
                    .where((e) => e.category == ExerciseCategory.compound)
                    .isNotEmpty)
                  ExerciseDemoCard(
                    title: 'Ejercicios Compuestos 🏋️‍♂️',
                    subtitle: 'Movimientos multi-articulares y funcionales',
                    exercises: workoutState.todaysExercises
                        .where((e) => e.category == ExerciseCategory.compound)
                        .toList(),
                  ),

                // Ejercicios de Cardio
                if (workoutState.todaysExercises
                    .where((e) => e.category == ExerciseCategory.cardio)
                    .isNotEmpty)
                  ExerciseDemoCard(
                    title: 'Entrenamiento Cardiovascular 🏃‍♂️',
                    subtitle: 'Ejercicios para mejorar la resistencia',
                    exercises: workoutState.todaysExercises
                        .where((e) => e.category == ExerciseCategory.cardio)
                        .toList(),
                  ),
              ],
            ),
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
    return '${date.day} de ${months[date.month - 1]} ${date.year}';
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
