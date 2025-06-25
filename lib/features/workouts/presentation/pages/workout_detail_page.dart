import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_progress.dart';

class WorkoutDetailPage extends ConsumerStatefulWidget {
  final DailyGoal goal;

  const WorkoutDetailPage({
    super.key,
    required this.goal,
  });

  @override
  ConsumerState<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends ConsumerState<WorkoutDetailPage> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _exerciseStats = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
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

  List<WorkoutExercise> _getExercisesForGoal(DailyGoal goal) {
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
      body: CustomScrollView(
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
                            onStatsChanged: (stats) {
                              setState(() {
                                _exerciseStats[exercise.name] = stats;
                              });
                            },
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
        ],
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

  void _completeWorkout() {
    // Aquí procesaríamos las estadísticas ingresadas
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Workout Completado',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          '¡Excelente trabajo! Has completado este ejercicio.',
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
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _ExerciseCard extends StatefulWidget {
  final WorkoutExercise exercise;
  final Map<String, TextEditingController> controllers;
  final Function(String) onStatsChanged;

  const _ExerciseCard({
    required this.exercise,
    required this.controllers,
    required this.onStatsChanged,
  });

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.3),
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
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.fitness_center,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              widget.exercise.name,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.exercise.description,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: IconButton(
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
          ),

          // Exercise Details (Expandable)
          if (_isExpanded) ...[
            const Divider(color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise Info
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.repeat,
                        label: widget.exercise.sets > 0
                            ? '${widget.exercise.sets} sets'
                            : 'Tiempo',
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.fitness_center,
                        label: widget.exercise.reps > 0
                            ? '${widget.exercise.reps} reps'
                            : 'Continuo',
                      ),
                      const SizedBox(width: 8),
                      if (widget.exercise.restTime > 0)
                        _InfoChip(
                          icon: Icons.timer,
                          label: '${widget.exercise.restTime}s rest',
                        ),
                    ],
                  ),

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
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
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
