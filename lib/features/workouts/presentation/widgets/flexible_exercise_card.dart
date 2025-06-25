import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/exercise_types.dart';

class FlexibleExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final ExerciseStats? currentStats;
  final Function(ExerciseStats) onStatsUpdated;

  const FlexibleExerciseCard({
    super.key,
    required this.exercise,
    this.currentStats,
    required this.onStatsUpdated,
  });

  @override
  State<FlexibleExerciseCard> createState() => _FlexibleExerciseCardState();
}

class _FlexibleExerciseCardState extends State<FlexibleExerciseCard> {
  bool _isExpanded = false;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Controladores básicos
    _controllers['weight'] = TextEditingController();
    _controllers['reps'] = TextEditingController();
    _controllers['time'] = TextEditingController();
    _controllers['rounds'] = TextEditingController();
    _controllers['notes'] = TextEditingController();
    _controllers['difficulty'] = TextEditingController();
    _controllers['energy'] = TextEditingController();

    // Controladores para sub-ejercicios si es compuesto
    if (widget.exercise.subExercises != null) {
      for (var subEx in widget.exercise.subExercises!) {
        _controllers['${subEx.name}_reps'] = TextEditingController();
        _controllers['${subEx.name}_weight'] = TextEditingController();
      }
    }

    // Cargar datos existentes si hay stats
    if (widget.currentStats != null) {
      _loadExistingStats();
    }
  }

  void _loadExistingStats() {
    final stats = widget.currentStats!;
    _controllers['weight']?.text = stats.weightUsed?.toString() ?? '';
    _controllers['reps']?.text = stats.completedReps?.toString() ?? '';
    _controllers['time']?.text = stats.timeSeconds?.toString() ?? '';
    _controllers['rounds']?.text = stats.rounds?.toString() ?? '';
    _controllers['notes']?.text = stats.notes ?? '';
    _controllers['difficulty']?.text = stats.difficultyRating?.toString() ?? '';
    _controllers['energy']?.text = stats.energyLevel?.toString() ?? '';
  }

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
          // Header del ejercicio
          _buildExerciseHeader(),

          // Detalles expandibles
          if (_isExpanded) ...[
            const Divider(color: AppColors.divider),
            _buildExerciseDetails(),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseHeader() {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _getCategoryColor(widget.exercise.category).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          _getCategoryIcon(widget.exercise.category),
          color: _getCategoryColor(widget.exercise.category),
        ),
      ),
      title: Text(
        widget.exercise.name,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
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
          Row(
            children: [
              _WorkoutTypeChip(type: widget.exercise.workoutType),
              const SizedBox(width: 8),
              _CategoryChip(category: widget.exercise.category),
            ],
          ),
        ],
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
    );
  }

  Widget _buildExerciseDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Información del ejercicio
          _buildExerciseInfo(),

          const SizedBox(height: 16),

          // Campos de estadísticas según el tipo
          _buildStatsInputs(),

          const SizedBox(height: 16),

          // Botón para guardar stats
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildExerciseInfo() {
    List<Widget> infoChips = [];

    switch (widget.exercise.workoutType) {
      case WorkoutType.traditional:
        if (widget.exercise.sets != null) {
          infoChips.add(_InfoChip(
            icon: Icons.repeat,
            label: '${widget.exercise.sets} sets',
          ));
        }
        if (widget.exercise.reps != null) {
          infoChips.add(_InfoChip(
            icon: Icons.fitness_center,
            label: '${widget.exercise.reps} reps',
          ));
        }
        break;

      case WorkoutType.amrap:
        infoChips.add(_InfoChip(
          icon: Icons.timer,
          label: '${widget.exercise.durationMinutes} min AMRAP',
        ));
        break;

      case WorkoutType.emom:
        infoChips.add(_InfoChip(
          icon: Icons.schedule,
          label: '${widget.exercise.durationMinutes} min EMOM',
        ));
        break;

      case WorkoutType.forTime:
        infoChips.add(_InfoChip(
          icon: Icons.speed,
          label: 'For Time',
        ));
        if (widget.exercise.rounds != null) {
          infoChips.add(_InfoChip(
            icon: Icons.repeat,
            label: '${widget.exercise.rounds} rounds',
          ));
        }
        break;

      default:
        break;
    }

    if (widget.exercise.restTimeSeconds != null) {
      infoChips.add(_InfoChip(
        icon: Icons.pause,
        label: '${widget.exercise.restTimeSeconds}s rest',
      ));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: infoChips,
    );
  }

  Widget _buildStatsInputs() {
    List<Widget> inputs = [];

    // Título
    inputs.add(
      Text(
        'Registra tus estadísticas:',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    inputs.add(const SizedBox(height: 12));

    // Campos según el tipo de workout
    switch (widget.exercise.workoutType) {
      case WorkoutType.traditional:
        inputs.addAll(_buildTraditionalInputs());
        break;
      case WorkoutType.amrap:
        inputs.addAll(_buildAmrapInputs());
        break;
      case WorkoutType.emom:
        inputs.addAll(_buildEmomInputs());
        break;
      case WorkoutType.forTime:
        inputs.addAll(_buildForTimeInputs());
        break;
      case WorkoutType.maxWeight:
        inputs.addAll(_buildMaxWeightInputs());
        break;
      default:
        inputs.addAll(_buildGenericInputs());
    }

    // Ejercicios compuestos
    if (widget.exercise.subExercises != null) {
      inputs.addAll(_buildCompoundInputs());
    }

    // Campos comunes
    inputs.addAll(_buildCommonInputs());

    return Column(children: inputs);
  }

  List<Widget> _buildTraditionalInputs() {
    return [
      Row(
        children: [
          Expanded(
            child: _StatInput(
              label: 'Repeticiones',
              controller: _controllers['reps']!,
              keyboardType: TextInputType.number,
              suffix: 'reps',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatInput(
              label: 'Peso',
              controller: _controllers['weight']!,
              keyboardType: TextInputType.number,
              suffix: 'kg',
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildAmrapInputs() {
    return [
      _StatInput(
        label: 'Rondas completadas',
        controller: _controllers['rounds']!,
        keyboardType: TextInputType.number,
        suffix: 'rounds',
      ),
      const SizedBox(height: 12),
      _StatInput(
        label: 'Repeticiones adicionales',
        controller: _controllers['reps']!,
        keyboardType: TextInputType.number,
        suffix: 'reps',
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildEmomInputs() {
    return [
      _StatInput(
        label: 'Minutos completados',
        controller: _controllers['rounds']!,
        keyboardType: TextInputType.number,
        suffix: 'min',
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _StatInput(
              label: 'Peso usado',
              controller: _controllers['weight']!,
              keyboardType: TextInputType.number,
              suffix: 'kg',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatInput(
              label: 'Reps por minuto',
              controller: _controllers['reps']!,
              keyboardType: TextInputType.number,
              suffix: 'reps',
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildForTimeInputs() {
    return [
      _StatInput(
        label: 'Tiempo total',
        controller: _controllers['time']!,
        keyboardType: TextInputType.number,
        suffix: 'segundos',
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildMaxWeightInputs() {
    return [
      _StatInput(
        label: 'Peso máximo',
        controller: _controllers['weight']!,
        keyboardType: TextInputType.number,
        suffix: 'kg',
      ),
      const SizedBox(height: 12),
      _StatInput(
        label: 'Repeticiones',
        controller: _controllers['reps']!,
        keyboardType: TextInputType.number,
        suffix: 'reps',
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildGenericInputs() {
    return [
      Row(
        children: [
          Expanded(
            child: _StatInput(
              label: 'Tiempo',
              controller: _controllers['time']!,
              keyboardType: TextInputType.number,
              suffix: 'seg',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatInput(
              label: 'Repeticiones',
              controller: _controllers['reps']!,
              keyboardType: TextInputType.number,
              suffix: 'reps',
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildCompoundInputs() {
    List<Widget> inputs = [
      Text(
        'Ejercicios del complejo:',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8),
    ];

    for (var subEx in widget.exercise.subExercises!) {
      inputs.add(
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${subEx.name} (${subEx.reps} reps)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _StatInput(
                      label: 'Reps realizadas',
                      controller: _controllers['${subEx.name}_reps']!,
                      keyboardType: TextInputType.number,
                      suffix: 'reps',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatInput(
                      label: 'Peso',
                      controller: _controllers['${subEx.name}_weight']!,
                      keyboardType: TextInputType.number,
                      suffix: 'kg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return inputs;
  }

  List<Widget> _buildCommonInputs() {
    return [
      Row(
        children: [
          Expanded(
            child: _StatInput(
              label: 'Dificultad (1-10)',
              controller: _controllers['difficulty']!,
              keyboardType: TextInputType.number,
              suffix: '/10',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatInput(
              label: 'Energía (1-10)',
              controller: _controllers['energy']!,
              keyboardType: TextInputType.number,
              suffix: '/10',
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      _StatInput(
        label: 'Notas adicionales',
        controller: _controllers['notes']!,
        keyboardType: TextInputType.text,
        suffix: '',
        maxLines: 3,
      ),
    ];
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveStats,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Guardar Estadísticas',
          style: AppTextStyles.buttonMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _saveStats() {
    // Crear ExerciseStats basado en los datos ingresados
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

    widget.onStatsUpdated(stats);

    // Mostrar confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Estadísticas guardadas para ${widget.exercise.name}'),
        backgroundColor: AppColors.success,
      ),
    );
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

class _WorkoutTypeChip extends StatelessWidget {
  final WorkoutType type;

  const _WorkoutTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getTypeLabel(type),
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getTypeLabel(WorkoutType type) {
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
}

class _CategoryChip extends StatelessWidget {
  final ExerciseCategory category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getCategoryLabel(category),
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
  final int maxLines;

  const _StatInput({
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.suffix,
    this.maxLines = 1,
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
}
