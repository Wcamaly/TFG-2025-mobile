import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_progress.dart';
import '../../data/services/workout_session_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../authentication/domain/entities/user.dart';
import '../providers/workout_history_provider.dart';
import 'package:flutter/foundation.dart';

class WorkoutDetailPage extends ConsumerStatefulWidget {
  final DailyGoal goal;
  final List<WorkoutExercise>? customExercises;

  const WorkoutDetailPage({
    super.key,
    required this.goal,
    this.customExercises,
  });

  @override
  ConsumerState<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends ConsumerState<WorkoutDetailPage> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _exerciseStats = {};
  int? _studentId;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadStudentId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refrescar datos cuando cambian las dependencias (como cuando regresas a la página)
    _refreshExerciseData();
  }

  void _initializeControllers() {
    // Simulamos ejercicios basados en el tipo de goal
    final exercises = _getExercisesForGoal(widget.goal);
    for (var exercise in exercises) {
      _controllers['${exercise.name}_reps'] = TextEditingController();
      _controllers['${exercise.name}_weight'] = TextEditingController();
      _controllers['${exercise.name}_time'] = TextEditingController();
    }
  }

  Future<void> _loadStudentId() async {
    final authState = ref.read(authProvider);
    User? user;

    authState.when(
      initial: () => user = null,
      loading: () => user = null,
      authenticated: (authenticatedUser) => user = authenticatedUser,
      unauthenticated: (message) => user = null,
    );

    if (user != null) {
      final database = sl<AppDatabase>();
      final userId = int.tryParse(user!.id);
      if (userId != null) {
        final student = await (database.select(database.students)
              ..where((s) => s.userId.equals(userId)))
            .getSingleOrNull();

        if (student != null) {
          setState(() {
            _studentId = student.id;
          });
        }
      }
    }
  }

  List<WorkoutExercise> _getExercisesForGoal(DailyGoal goal) {
    // Si hay ejercicios personalizados, usarlos
    if (widget.customExercises != null && widget.customExercises!.isNotEmpty) {
      return widget.customExercises!;
    }

    // Si no, usar ejercicios mock basados en el tipo de goal
    switch (goal.type) {
      case GoalType.warmUp:
        return [
          const WorkoutExercise(
            name: 'Jumping Jacks',
            description: 'Full body warm-up exercise',
            imageUrl: 'assets/images/exercises/jumping_jacks.png',
            videoUrl: '',
            sets: 3,
            reps: 20,
            restTime: 30,
            equipment: 'None',
            muscleGroup: 'Full Body',
          ),
          const WorkoutExercise(
            name: 'Arm Circles',
            description: 'Shoulder warm-up exercise',
            imageUrl: 'assets/images/exercises/arm_circles.png',
            videoUrl: '',
            sets: 2,
            reps: 15,
            restTime: 15,
            equipment: 'None',
            muscleGroup: 'Shoulders',
          ),
        ];
      case GoalType.strength:
        return [
          const WorkoutExercise(
            name: 'Push-ups',
            description: 'Upper body strength exercise',
            imageUrl: 'assets/images/exercises/pushups.png',
            videoUrl: '',
            sets: 3,
            reps: 50,
            restTime: 60,
            equipment: 'None',
            muscleGroup: 'Chest, Arms',
          ),
          const WorkoutExercise(
            name: 'Bicep Curls',
            description: 'Bicep strengthening exercise',
            imageUrl: 'assets/images/exercises/bicep_curls.png',
            videoUrl: '',
            sets: 3,
            reps: 12,
            restTime: 45,
            equipment: 'Dumbbells',
            muscleGroup: 'Biceps',
          ),
        ];
      case GoalType.cardio:
        return [
          const WorkoutExercise(
            name: 'Running',
            description: 'Cardiovascular exercise',
            imageUrl: 'assets/images/exercises/running.png',
            videoUrl: '',
            sets: 1,
            reps: 0,
            restTime: 0,
            equipment: 'None',
            muscleGroup: 'Legs, Cardio',
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercisesForGoal(widget.goal);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          // Refrescar todos los ejercicios
          for (final exercise in exercises) {
            // Esto forzará a que cada _ExerciseCard recargue sus datos
            setState(() {});
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: AppColors.surface,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.goal.title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withOpacity(0.8),
                        AppColors.primary.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getIconForGoalType(widget.goal.type),
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descripción',
                            style: AppTextStyles.headlineMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.goal.description,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Exercises
                    Text(
                      'Ejercicios (${exercises.length})',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ...exercises
                        .map((exercise) => _ExerciseCard(
                              exercise: exercise,
                              controllers: _controllers,
                              onStatsChanged: (value) {
                                // TODO: Implementar cambio de estadísticas
                              },
                              routineId: widget.goal.id,
                              studentId: _studentId ?? 0,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.goal.isCompleted
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Completado ✓',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.buttonLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              : PrimaryButton(
                  text: 'Marcar como Completado',
                  onPressed: _completeWorkout,
                ),
        ),
      ),
    );
  }

  IconData _getIconForGoalType(GoalType? type) {
    switch (type) {
      case GoalType.warmUp:
        return Icons.self_improvement;
      case GoalType.strength:
        return Icons.fitness_center;
      case GoalType.cardio:
        return Icons.directions_run;
      case GoalType.coolDown:
        return Icons.spa;
      default:
        return Icons.fitness_center;
    }
  }

  void _completeWorkout() async {
    try {
      if (_studentId == null) {
        _showErrorDialog('Error', 'Usuario no autenticado');
        return;
      }

      // Mostrar diálogo de confirmación
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Completar Rutina',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres marcar esta rutina como completada? Asegúrate de haber guardado todas las métricas de los ejercicios.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancelar',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'Completar',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      // Marcar todos los ejercicios como completados
      final sessionService = sl<WorkoutSessionService>();
      final exercises = _getExercisesForGoal(widget.goal);

      for (final exercise in exercises) {
        await sessionService.updateExerciseCompletionStatus(
          studentId: _studentId!,
          routineId: int.tryParse(widget.goal.id) ?? 0,
          exerciseName: exercise.name,
          isCompleted: true,
        );
      }

      // Mostrar diálogo de éxito
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            '¡Rutina Completada!',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            'Excelente trabajo! Has completado esta rutina. Todas las métricas guardadas han sido registradas.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true); // Retornar que se completó
              },
              child: Text(
                'Continuar',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      print('❌ Error completing workout: $e');
      _showErrorDialog('Error', 'No se pudo completar la rutina: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.error,
          ),
        ),
        content: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _refreshExerciseData() async {
    // Forzar a que todos los _ExerciseCard recarguen sus datos
    setState(() {});
  }
}

class _ExerciseCard extends ConsumerStatefulWidget {
  final WorkoutExercise exercise;
  final Map<String, TextEditingController> controllers;
  final Function(String) onStatsChanged;
  final String routineId;
  final int studentId;

  const _ExerciseCard({
    required this.exercise,
    required this.controllers,
    required this.onStatsChanged,
    required this.routineId,
    required this.studentId,
  });

  @override
  ConsumerState<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<_ExerciseCard> {
  bool _isExpanded = false;
  bool _isCompleted = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadExerciseStatus();
  }

  @override
  void didUpdateWidget(_ExerciseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Recargar datos cuando cambian los parámetros del widget
    if (oldWidget.studentId != widget.studentId ||
        oldWidget.routineId != widget.routineId) {
      _loadExerciseStatus();
    }
  }

  Future<void> _loadExerciseStatus() async {
    try {
      print('🔄 Loading exercise status for: ${widget.exercise.name}');

      final sessionService = sl<WorkoutSessionService>();
      final metrics = await sessionService.getExerciseMetricsForToday(
        studentId: widget.studentId,
        routineId: int.tryParse(widget.routineId) ?? 0,
        exerciseName: widget.exercise.name,
      );

      if (mounted) {
        setState(() {
          if (metrics != null) {
            _isCompleted = metrics['isCompleted'] ?? false;
            print(
                '✅ Loaded metrics for ${widget.exercise.name}: completed=$_isCompleted');

            // Cargar métricas existentes en los controllers
            final repsController =
                widget.controllers['${widget.exercise.name}_reps'];
            final weightController =
                widget.controllers['${widget.exercise.name}_weight'];
            final timeController =
                widget.controllers['${widget.exercise.name}_time'];

            if (repsController != null && metrics['reps'] != null) {
              repsController.text = metrics['reps'].toString();
              print('📊 Loaded reps: ${metrics['reps']}');
            }
            if (weightController != null && metrics['weightKg'] != null) {
              weightController.text = metrics['weightKg'].toString();
              print('🏋️ Loaded weight: ${metrics['weightKg']}kg');
            }
            if (timeController != null && metrics['durationSeconds'] != null) {
              timeController.text =
                  (metrics['durationSeconds'] / 60).round().toString();
              print('⏱️ Loaded time: ${metrics['durationSeconds']}s');
            }
          } else {
            _isCompleted = false;
            print('📭 No metrics found for ${widget.exercise.name}');
          }
        });
      }
    } catch (e) {
      print('❌ Error loading exercise status for ${widget.exercise.name}: $e');
    }
  }

  Future<void> _saveExerciseMetrics() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final sessionService = sl<WorkoutSessionService>();
      final repsController = widget.controllers['${widget.exercise.name}_reps'];
      final weightController =
          widget.controllers['${widget.exercise.name}_weight'];
      final timeController = widget.controllers['${widget.exercise.name}_time'];

      await sessionService.saveExerciseMetrics(
        studentId: widget.studentId,
        routineId: int.tryParse(widget.routineId) ?? 0,
        exerciseName: widget.exercise.name,
        exerciseDescription: widget.exercise.description,
        repsCompleted: repsController?.text.isNotEmpty == true
            ? int.tryParse(repsController!.text)
            : null,
        weightUsed: weightController?.text.isNotEmpty == true
            ? double.tryParse(weightController!.text)
            : null,
        timeSpent: timeController?.text.isNotEmpty == true
            ? ((double.tryParse(timeController!.text) ?? 0) * 60).round()
            : null,
        notes: 'Métricas guardadas',
        isCompleted: _isCompleted,
      );

      // Actualizar estado de completado
      await sessionService.updateExerciseCompletionStatus(
        studentId: widget.studentId,
        routineId: int.tryParse(widget.routineId) ?? 0,
        exerciseName: widget.exercise.name,
        isCompleted: _isCompleted,
      );

      // Recargar datos después de guardar
      await _loadExerciseStatus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Métricas de ${widget.exercise.name} guardadas'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _toggleCompletion() async {
    setState(() {
      _isCompleted = !_isCompleted;
    });

    try {
      final sessionService = sl<WorkoutSessionService>();
      await sessionService.updateExerciseCompletionStatus(
        studentId: widget.studentId,
        routineId: int.tryParse(widget.routineId) ?? 0,
        exerciseName: widget.exercise.name,
        isCompleted: _isCompleted,
      );

      // Actualizar el provider
      ref
          .read(exerciseStatusProvider.notifier)
          .updateExerciseStatus(widget.exercise.name, _isCompleted);

      // Recargar datos después de cambiar el estado
      await _loadExerciseStatus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isCompleted
              ? '${widget.exercise.name} marcado como completado'
              : '${widget.exercise.name} marcado como pendiente'),
          backgroundColor: _isCompleted ? AppColors.success : AppColors.warning,
        ),
      );
    } catch (e) {
      // Revertir el estado si hay error
      if (mounted) {
        setState(() {
          _isCompleted = !_isCompleted;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar estado: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _isCompleted
            ? AppColors.success.withOpacity(0.1)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isCompleted
              ? AppColors.success.withOpacity(0.3)
              : AppColors.divider.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          // Exercise Header
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _isCompleted
                    ? AppColors.success.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _isCompleted ? Icons.check_circle : Icons.fitness_center,
                color: _isCompleted ? AppColors.success : AppColors.primary,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.exercise.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_isCompleted)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Completado',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.exercise.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                // Información básica del ejercicio
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (widget.exercise.sets > 0)
                      _InfoChip(
                        icon: Icons.repeat,
                        label: '${widget.exercise.sets} series',
                        color: AppColors.primary,
                      ),
                    if (widget.exercise.reps > 0)
                      _InfoChip(
                        icon: Icons.fitness_center,
                        label: '${widget.exercise.reps} reps',
                        color: AppColors.secondary,
                      ),
                    if (widget.exercise.restTime > 0)
                      _InfoChip(
                        icon: Icons.timer,
                        label: '${widget.exercise.restTime}s',
                        color: AppColors.warning,
                      ),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón de completar
                IconButton(
                  icon: Icon(
                    _isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: _isCompleted
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                  onPressed: _toggleCompletion,
                  tooltip: _isCompleted
                      ? 'Marcar como pendiente'
                      : 'Marcar como completado',
                ),
                // Botón de expandir
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),

          // Exercise Details (Expandable)
          if (_isExpanded) ...[
            const Divider(color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información detallada del ejercicio
                  _buildExerciseDetails(),

                  const SizedBox(height: 16),

                  // Stats Input
                  Text(
                    'Registra tus estadísticas:',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Input fields based on exercise type
                  if (widget.exercise.reps > 0) ...[
                    _StatInput(
                      label: 'Repeticiones realizadas',
                      controller:
                          widget.controllers['${widget.exercise.name}_reps']!,
                      keyboardType: TextInputType.number,
                      suffix: 'reps',
                    ),
                    const SizedBox(height: 12),
                  ],

                  if (widget.exercise.equipment != 'None') ...[
                    _StatInput(
                      label: 'Peso usado',
                      controller:
                          widget.controllers['${widget.exercise.name}_weight']!,
                      keyboardType: TextInputType.number,
                      suffix: 'kg',
                    ),
                    const SizedBox(height: 12),
                  ],

                  _StatInput(
                    label: 'Tiempo total',
                    controller:
                        widget.controllers['${widget.exercise.name}_time']!,
                    keyboardType: TextInputType.number,
                    suffix: 'min',
                  ),
                  const SizedBox(height: 16),

                  // Botón de guardar métricas
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPressed:
                          _isSaving ? () {} : () => _saveExerciseMetrics(),
                      text: _isSaving ? 'Guardando...' : 'Guardar Métricas',
                      isLoading: _isSaving,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles del Ejercicio',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Grid de información detallada
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _DetailCard(
              icon: Icons.repeat,
              title: 'Series',
              value: '${widget.exercise.sets}',
              color: AppColors.primary,
            ),
            _DetailCard(
              icon: Icons.fitness_center,
              title: 'Repeticiones',
              value: '${widget.exercise.reps}',
              color: AppColors.secondary,
            ),
            _DetailCard(
              icon: Icons.timer,
              title: 'Descanso',
              value: '${widget.exercise.restTime}s',
              color: AppColors.warning,
            ),
            _DetailCard(
              icon: Icons.category,
              title: 'Equipamiento',
              value: widget.exercise.equipment,
              color: AppColors.primary,
            ),
            _DetailCard(
              icon: Icons.fitness_center,
              title: 'Grupo Muscular',
              value: widget.exercise.muscleGroup,
              color: AppColors.secondary,
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String suffix;

  const _StatInput({
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '0',
            suffixText: suffix,
            suffixStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.divider.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.divider.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
