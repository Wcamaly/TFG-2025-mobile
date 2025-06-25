import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../domain/entities/exercise_types.dart';
import '../providers/advanced_workout_provider.dart';

class ExerciseDetailPage extends ConsumerStatefulWidget {
  final Exercise exercise;

  const ExerciseDetailPage({
    super.key,
    required this.exercise,
  });

  @override
  ConsumerState<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends ConsumerState<ExerciseDetailPage> {
  final Map<String, TextEditingController> _controllers = {};
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers['weight'] = TextEditingController();
    _controllers['reps'] = TextEditingController();
    _controllers['time'] = TextEditingController();
    _controllers['rounds'] = TextEditingController();
    _controllers['notes'] = TextEditingController();
    _controllers['difficulty'] = TextEditingController();
    _controllers['energy'] = TextEditingController();

    // Controladores para ejercicios compuestos
    if (widget.exercise.subExercises != null) {
      for (var subEx in widget.exercise.subExercises!) {
        _controllers['${subEx.name}_reps'] = TextEditingController();
        _controllers['${subEx.name}_weight'] = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.exercise.name,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color:
                  _getCategoryColor(widget.exercise.category).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(widget.exercise.category),
                  size: 16,
                  color: _getCategoryColor(widget.exercise.category),
                ),
                const SizedBox(width: 4),
                Text(
                  _getCategoryLabel(widget.exercise.category),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: _getCategoryColor(widget.exercise.category),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseHeader(),
            const SizedBox(height: 24),
            _buildExerciseInstructions(),
            const SizedBox(height: 24),
            _buildStatsInput(),
            const SizedBox(height: 32),
            _buildCompleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCategoryColor(widget.exercise.category).withOpacity(0.1),
            _getCategoryColor(widget.exercise.category).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getCategoryColor(widget.exercise.category).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getCategoryColor(widget.exercise.category)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(widget.exercise.category),
                  color: _getCategoryColor(widget.exercise.category),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.name,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getWorkoutTypeLabel(widget.exercise.workoutType),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.exercise.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _buildExerciseSpecs(),
        ],
      ),
    );
  }

  Widget _buildExerciseSpecs() {
    List<Widget> specs = [];

    switch (widget.exercise.workoutType) {
      case WorkoutType.traditional:
        if (widget.exercise.sets != null) {
          specs.add(_SpecChip(
            icon: Icons.repeat,
            label: '${widget.exercise.sets} sets',
          ));
        }
        if (widget.exercise.reps != null) {
          specs.add(_SpecChip(
            icon: Icons.fitness_center,
            label: '${widget.exercise.reps} reps',
          ));
        }
        if (widget.exercise.restTimeSeconds != null) {
          specs.add(_SpecChip(
            icon: Icons.pause,
            label: '${widget.exercise.restTimeSeconds}s rest',
          ));
        }
        break;

      case WorkoutType.amrap:
        specs.add(_SpecChip(
          icon: Icons.timer,
          label: '${widget.exercise.durationMinutes} min AMRAP',
        ));
        break;

      case WorkoutType.emom:
        specs.add(_SpecChip(
          icon: Icons.schedule,
          label: '${widget.exercise.durationMinutes} min EMOM',
        ));
        if (widget.exercise.reps != null) {
          specs.add(_SpecChip(
            icon: Icons.fitness_center,
            label: '${widget.exercise.reps} reps/min',
          ));
        }
        break;

      case WorkoutType.forTime:
        specs.add(_SpecChip(
          icon: Icons.speed,
          label: 'For Time',
        ));
        if (widget.exercise.rounds != null) {
          specs.add(_SpecChip(
            icon: Icons.repeat,
            label: '${widget.exercise.rounds} rounds',
          ));
        }
        break;

      default:
        break;
    }

    // Músculos trabajados
    if (widget.exercise.muscleGroups.isNotEmpty) {
      specs.add(_SpecChip(
        icon: Icons.accessibility_new,
        label: widget.exercise.muscleGroups.join(', '),
        isWide: true,
      ));
    }

    // Equipamiento
    if (widget.exercise.equipment.isNotEmpty) {
      specs.add(_SpecChip(
        icon: Icons.fitness_center,
        label: widget.exercise.equipment.join(', '),
        isWide: true,
      ));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: specs,
    );
  }

  Widget _buildExerciseInstructions() {
    if (widget.exercise.subExercises == null ||
        widget.exercise.subExercises!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Ejercicios del complejo',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.exercise.subExercises!.asMap().entries.map((entry) {
            final index = entry.key;
            final subEx = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subEx.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${subEx.reps} repeticiones',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatsInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Registra tu rendimiento',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._buildInputFields(),
        ],
      ),
    );
  }

  List<Widget> _buildInputFields() {
    List<Widget> fields = [];

    switch (widget.exercise.workoutType) {
      case WorkoutType.traditional:
        fields.addAll([
          Row(
            children: [
              Expanded(
                child: _buildInputField('Repeticiones', 'reps', 'reps'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField('Peso', 'weight', 'kg'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ]);
        break;

      case WorkoutType.amrap:
        fields.addAll([
          _buildInputField('Rondas completadas', 'rounds', 'rounds'),
          const SizedBox(height: 12),
          _buildInputField('Repeticiones adicionales', 'reps', 'reps'),
          const SizedBox(height: 12),
        ]);
        break;

      case WorkoutType.emom:
        fields.addAll([
          _buildInputField('Minutos completados', 'rounds', 'min'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInputField('Peso usado', 'weight', 'kg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField('Reps por minuto', 'reps', 'reps'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ]);
        break;

      case WorkoutType.forTime:
        fields.addAll([
          _buildInputField('Tiempo total', 'time', 'segundos'),
          const SizedBox(height: 12),
        ]);
        break;

      case WorkoutType.maxWeight:
        fields.addAll([
          Row(
            children: [
              Expanded(
                child: _buildInputField('Peso máximo', 'weight', 'kg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField('Repeticiones', 'reps', 'reps'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ]);
        break;

      default:
        fields.addAll([
          Row(
            children: [
              Expanded(
                child: _buildInputField('Tiempo', 'time', 'seg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField('Repeticiones', 'reps', 'reps'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ]);
    }

    // Sub-ejercicios si es compuesto
    if (widget.exercise.subExercises != null) {
      fields.add(
        Text(
          'Rendimiento por ejercicio:',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      fields.add(const SizedBox(height: 12));

      for (var subEx in widget.exercise.subExercises!) {
        fields.addAll([
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subEx.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                          'Reps', '${subEx.name}_reps', 'reps'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                          'Peso', '${subEx.name}_weight', 'kg'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ]);
      }
    }

    // Campos comunes
    fields.addAll([
      Row(
        children: [
          Expanded(
            child: _buildInputField('Dificultad (1-10)', 'difficulty', '/10'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildInputField('Energía (1-10)', 'energy', '/10'),
          ),
        ],
      ),
      const SizedBox(height: 12),
      _buildInputField('Notas', 'notes', '', maxLines: 3),
    ]);

    return fields;
  }

  Widget _buildInputField(String label, String key, String suffix,
      {int maxLines = 1}) {
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
          controller: _controllers[key],
          keyboardType:
              maxLines > 1 ? TextInputType.text : TextInputType.number,
          maxLines: maxLines,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: maxLines > 1 ? 'Escribe aquí...' : '0',
            suffixText: suffix.isNotEmpty ? suffix : null,
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

  Widget _buildCompleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isCompleted ? null : _completeExercise,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isCompleted ? AppColors.success : AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _isCompleted ? 'Ejercicio Completado ✓' : 'Completar Ejercicio',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _completeExercise() {
    // Crear ExerciseStats
    final stats = ExerciseStats(
      exerciseId: widget.exercise.id,
      date: DateTime.now(),
      workoutType: widget.exercise.workoutType,
      completedReps: int.tryParse(_controllers['reps']?.text ?? ''),
      weightUsed: double.tryParse(_controllers['weight']?.text ?? ''),
      timeSeconds: int.tryParse(_controllers['time']?.text ?? ''),
      rounds: int.tryParse(_controllers['rounds']?.text ?? ''),
      notes: _controllers['notes']?.text,
      difficultyRating: int.tryParse(_controllers['difficulty']?.text ?? ''),
      energyLevel: int.tryParse(_controllers['energy']?.text ?? ''),
      subExerciseStats: _buildSubExerciseStats(),
    );

    // Actualizar provider
    ref
        .read(advancedWorkoutProvider.notifier)
        .updateExerciseStats(widget.exercise.id, stats);

    setState(() {
      _isCompleted = true;
    });

    // Mostrar confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Ejercicio completado! ${widget.exercise.name}'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'Ver Stats',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Navegar a stats detalladas
          },
        ),
      ),
    );

    // Regresar después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context, true);
      }
    });
  }

  List<SubExerciseStats>? _buildSubExerciseStats() {
    if (widget.exercise.subExercises == null) return null;

    return widget.exercise.subExercises!.map((subEx) {
      return SubExerciseStats(
        name: subEx.name,
        completedReps:
            int.tryParse(_controllers['${subEx.name}_reps']?.text ?? '') ?? 0,
        weight:
            double.tryParse(_controllers['${subEx.name}_weight']?.text ?? ''),
      );
    }).toList();
  }

  String _getWorkoutTypeLabel(WorkoutType type) {
    switch (type) {
      case WorkoutType.traditional:
        return 'Sets x Reps';
      case WorkoutType.amrap:
        return 'AMRAP';
      case WorkoutType.emom:
        return 'EMOM';
      case WorkoutType.tabata:
        return 'Tabata';
      case WorkoutType.forTime:
        return 'For Time';
      case WorkoutType.maxReps:
        return 'Max Reps';
      case WorkoutType.maxWeight:
        return 'Max Weight';
      case WorkoutType.timeChallenge:
        return 'Time Challenge';
    }
  }

  String _getCategoryLabel(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.strength:
        return 'Fuerza';
      case ExerciseCategory.cardio:
        return 'Cardio';
      case ExerciseCategory.crossfit:
        return 'CrossFit';
      case ExerciseCategory.compound:
        return 'Compuesto';
      case ExerciseCategory.isolation:
        return 'Aislamiento';
      case ExerciseCategory.mobility:
        return 'Movilidad';
    }
  }

  Color _getCategoryColor(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.strength:
        return Colors.red;
      case ExerciseCategory.cardio:
        return Colors.blue;
      case ExerciseCategory.crossfit:
        return Colors.orange;
      case ExerciseCategory.compound:
        return Colors.purple;
      case ExerciseCategory.isolation:
        return Colors.green;
      case ExerciseCategory.mobility:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.strength:
        return Icons.fitness_center;
      case ExerciseCategory.cardio:
        return Icons.directions_run;
      case ExerciseCategory.crossfit:
        return Icons.whatshot;
      case ExerciseCategory.compound:
        return Icons.group_work;
      case ExerciseCategory.isolation:
        return Icons.my_library_books;
      case ExerciseCategory.mobility:
        return Icons.self_improvement;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isWide;

  const _SpecChip({
    required this.icon,
    required this.label,
    this.isWide = false,
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
        mainAxisSize: isWide ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: 4),
          if (isWide)
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          else
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
