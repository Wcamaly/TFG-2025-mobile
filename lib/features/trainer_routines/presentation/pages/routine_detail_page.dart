import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/routine.dart';
import '../providers/routines_provider.dart';
import '../../../trainer_students/presentation/providers/students_provider.dart';
import '../../../trainer_dashboard/domain/entities/student.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import 'assign_routine_page.dart';

class RoutineDetailPage extends ConsumerStatefulWidget {
  final Routine routine;

  const RoutineDetailPage({
    super.key,
    required this.routine,
  });

  @override
  ConsumerState<RoutineDetailPage> createState() => _RoutineDetailPageState();
}

class _RoutineDetailPageState extends ConsumerState<RoutineDetailPage> {
  late Routine _currentRoutine;

  @override
  void initState() {
    super.initState();
    _currentRoutine = widget.routine;

    // Cargar estudiantes
    Future.microtask(() {
      ref.read(studentsProvider.notifier).loadStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _currentRoutine.name,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditRoutineDialog(),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    const Icon(Icons.copy),
                    const SizedBox(width: 8),
                    Text('duplicate'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete, color: Colors.red),
                    const SizedBox(width: 8),
                    Text('delete'.tr(),
                        style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) => _handleMenuAction(value as String),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información básica
            _buildBasicInfo(),
            const SizedBox(height: 24),

            // Descripción
            _buildDescription(),
            const SizedBox(height: 24),

            // Ejercicios
            _buildExercisesSection(),
            const SizedBox(height: 24),

            // Botón de asignación
            _buildAssignButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getCategoryColor(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentRoutine.category.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: _getCategoryColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _currentRoutine.difficulty.name.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _currentRoutine.status.name.tr(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoItem(
                  Icons.access_time,
                  '${_currentRoutine.duration} ${'mins'.tr()}',
                  'duration'.tr(),
                ),
                const SizedBox(width: 24),
                _buildInfoItem(
                  Icons.people,
                  '${_currentRoutine.assignedStudents}',
                  'assignedStudents'.tr(),
                ),
                const SizedBox(width: 24),
                _buildInfoItem(
                  Icons.star,
                  _currentRoutine.avgRating.toStringAsFixed(1),
                  'rating'.tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'description'.tr(),
              style: AppTextStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentRoutine.description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'exercises'.tr(),
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddExerciseDialog(),
                  icon: const Icon(Icons.add),
                  label: Text('addExercise'.tr()),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _currentRoutine.exercises.isEmpty
                ? _buildEmptyExercises()
                : _buildExercisesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyExercises() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.fitness_center,
            size: 48,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          Text(
            'noExercisesYet'.tr(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _showAddExerciseDialog(),
            icon: const Icon(Icons.add),
            label: Text('addFirstExercise'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    return Column(
      children: _currentRoutine.exercises.asMap().entries.map((entry) {
        final index = entry.key;
        final exercise = entry.value;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                '${index + 1}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              exercise.name,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(exercise.description),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      const SizedBox(width: 8),
                      Text('edit'.tr()),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      const SizedBox(width: 8),
                      Text('delete'.tr(),
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) =>
                  _handleExerciseAction(value as String, exercise, index),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'exerciseDetails'.tr(),
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExerciseDetailRow(
                      'series'.tr(),
                      '${exercise.sets}',
                      Icons.repeat,
                    ),
                    _buildExerciseDetailRow(
                      'repetitions'.tr(),
                      '${exercise.reps}',
                      Icons.fitness_center,
                    ),
                    _buildExerciseDetailRow(
                      'rest'.tr(),
                      '${exercise.restTime} ${'sec'.tr()}',
                      Icons.timer,
                    ),
                    if (exercise.weight != null)
                      _buildExerciseDetailRow(
                        'weight'.tr(),
                        '${exercise.weight!} ${'kg'.tr()}',
                        Icons.monitor_weight,
                      ),
                    if (exercise.percentage != null)
                      _buildExerciseDetailRow(
                        'percentageRM'.tr(),
                        '${exercise.percentage!}%',
                        Icons.percent,
                      ),
                    if (exercise.duration != null)
                      _buildExerciseDetailRow(
                        'duration'.tr(),
                        '${exercise.duration!} ${'sec'.tr()}',
                        Icons.access_time,
                      ),
                    if (exercise.notes != null && exercise.notes!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'exerciseNotes'.tr(),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exercise.notes!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExerciseDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: () => _navigateToAssignRoutine(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.people, size: 20),
        label: Text(
          'assignToMultipleStudents'.tr(),
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Dialog para editar rutina
  void _showEditRoutineDialog() {
    final nameController = TextEditingController(text: _currentRoutine.name);
    final descriptionController =
        TextEditingController(text: _currentRoutine.description);
    final durationController =
        TextEditingController(text: _currentRoutine.duration.toString());
    String selectedCategory = _currentRoutine.category;
    String selectedDifficulty = _currentRoutine.difficulty.name;
    String selectedStatus = _currentRoutine.status.name;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('editRoutineConfiguration'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: nameController,
                  label: 'routineName'.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'exerciseRequired'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: descriptionController,
                  label: 'description'.tr(),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: durationController,
                  label: 'duration'.tr() + ' (${'minutes'.tr()})',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'setsRequired'.tr();
                    }
                    if (int.tryParse(value) == null) {
                      return 'validNumber'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['strength', 'cardio', 'flexibility', 'mixed']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.tr()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedDifficulty,
                  decoration: InputDecoration(
                    labelText: 'difficulty'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['beginner', 'intermediate', 'advanced']
                      .map((difficulty) => DropdownMenuItem(
                            value: difficulty,
                            child: Text(difficulty.tr()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: InputDecoration(
                    labelText: 'status'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['active', 'paused', 'completed']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.tr()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    durationController.text.isNotEmpty &&
                    int.tryParse(durationController.text) != null) {
                  final updatedRoutine = _currentRoutine.copyWith(
                    name: nameController.text,
                    description: descriptionController.text,
                    duration: int.parse(durationController.text),
                    category: selectedCategory,
                    difficulty: _parseDifficulty(selectedDifficulty),
                    status: _parseStatus(selectedStatus),
                    updatedAt: DateTime.now(),
                  );

                  ref
                      .read(routinesProvider.notifier)
                      .updateRoutine(updatedRoutine);

                  setState(() {
                    _currentRoutine = updatedRoutine;
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('routineUpdated'.tr())),
                  );
                }
              },
              child: Text('update'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog para agregar ejercicio
  void _showAddExerciseDialog() {
    _showExerciseDialog();
  }

  // Dialog para editar ejercicio
  void _showEditExerciseDialog(Exercise exercise, int index) {
    _showExerciseDialog(exercise: exercise, index: index);
  }

  void _showExerciseDialog({Exercise? exercise, int? index}) {
    final nameController = TextEditingController(text: exercise?.name ?? '');
    final descriptionController =
        TextEditingController(text: exercise?.description ?? '');
    final setsController =
        TextEditingController(text: exercise?.sets.toString() ?? '');
    final repsController =
        TextEditingController(text: exercise?.reps.toString() ?? '');
    final restTimeController =
        TextEditingController(text: exercise?.restTime.toString() ?? '60');
    final weightController =
        TextEditingController(text: exercise?.weight?.toString() ?? '');
    final percentageController =
        TextEditingController(text: exercise?.percentage?.toString() ?? '');
    final durationController =
        TextEditingController(text: exercise?.duration?.toString() ?? '');
    final notesController = TextEditingController(text: exercise?.notes ?? '');

    final formKey = GlobalKey<FormState>();
    final isEditing = exercise != null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'editExercise'.tr() : 'addNewExercise'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: nameController,
                  label: 'exerciseName'.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'exerciseRequired'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: descriptionController,
                  label: 'exerciseDescription'.tr(),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: setsController,
                        label: 'series'.tr(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'setsRequired'.tr();
                          }
                          if (int.tryParse(value) == null) {
                            return 'validNumber'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: repsController,
                        label: 'repetitions'.tr(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'repsRequired'.tr();
                          }
                          if (int.tryParse(value) == null) {
                            return 'validNumber'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: restTimeController,
                  label: 'restTimeSeconds'.tr(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        int.tryParse(value) == null) {
                      return 'validNumber'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: weightController,
                        label: 'weightKg'.tr() + ' (${'optional'.tr()})',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              double.tryParse(value) == null) {
                            return 'validNumber'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: percentageController,
                        label: 'percentageRM'.tr() + ' (${'optional'.tr()})',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              int.tryParse(value) == null) {
                            return 'validNumber'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: durationController,
                  label: 'durationSeconds'.tr() + ' (${'optional'.tr()})',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        int.tryParse(value) == null) {
                      return 'validNumber'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: notesController,
                  label: 'exerciseNotes'.tr() + ' (${'optional'.tr()})',
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                final newExercise = Exercise(
                  id: exercise?.id ?? DateTime.now().millisecondsSinceEpoch,
                  name: nameController.text,
                  description: descriptionController.text,
                  sets: int.parse(setsController.text),
                  reps: int.parse(repsController.text),
                  restTime: int.tryParse(restTimeController.text) ?? 60,
                  weight: weightController.text.isNotEmpty
                      ? double.tryParse(weightController.text)
                      : null,
                  percentage: percentageController.text.isNotEmpty
                      ? int.tryParse(percentageController.text)
                      : null,
                  duration: durationController.text.isNotEmpty
                      ? int.tryParse(durationController.text)
                      : null,
                  notes: notesController.text.isNotEmpty
                      ? notesController.text
                      : null,
                );

                List<Exercise> updatedExercises =
                    List.from(_currentRoutine.exercises);

                if (isEditing && index != null) {
                  updatedExercises[index] = newExercise;
                } else {
                  updatedExercises.add(newExercise);
                }

                final updatedRoutine = _currentRoutine.copyWith(
                  exercises: updatedExercises,
                  updatedAt: DateTime.now(),
                );

                ref
                    .read(routinesProvider.notifier)
                    .updateRoutine(updatedRoutine);

                setState(() {
                  _currentRoutine = updatedRoutine;
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isEditing
                        ? 'exerciseUpdated'.tr()
                        : 'exerciseAdded'.tr()),
                  ),
                );
              }
            },
            child: Text(isEditing ? 'update'.tr() : 'add'.tr()),
          ),
        ],
      ),
    );
  }

  // Dialog para asignar a múltiples estudiantes
  void _showAssignToStudentsDialog() {
    final studentsState = ref.read(studentsProvider);

    if (studentsState.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('loading'.tr())),
      );
      return;
    }

    if (studentsState.students.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('noStudentsYet'.tr())),
      );
      return;
    }

    List<Student> selectedStudents = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('assignRoutineToStudents'.tr()),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                Text(
                  'selectStudentsToAssign'.tr(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: studentsState.students.length,
                    itemBuilder: (context, index) {
                      final student = studentsState.students[index];
                      final isSelected = selectedStudents.contains(student);

                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              selectedStudents.add(student);
                            } else {
                              selectedStudents.remove(student);
                            }
                          });
                        },
                        title: Text(student.name),
                        subtitle: Text(student.email),
                        secondary: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Text(
                            student.name
                                .split(' ')
                                .map((n) => n[0])
                                .take(2)
                                .join()
                                .toUpperCase(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        activeColor: AppColors.primary,
                      );
                    },
                  ),
                ),
                if (selectedStudents.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'selectedStudents'.tr(namedArgs: {
                        'count': selectedStudents.length.toString()
                      }),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: selectedStudents.isEmpty
                  ? null
                  : () {
                      Navigator.pop(context);
                      _assignRoutineToStudents(selectedStudents);
                    },
              child: Text('assignSelected'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  // Navegar a la página de asignación de rutina
  void _navigateToAssignRoutine() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => AssignRoutinePage(routine: _currentRoutine),
      ),
    );

    // Si la asignación fue exitosa, puedes actualizar algo aquí si es necesario
    if (result == true && mounted) {
      // Opcional: recargar datos o mostrar mensaje de confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('routineAssignedSuccess'.tr())),
      );
    }
  }

  void _assignRoutineToStudents(List<Student> students) {
    // Aquí implementarías la lógica para asignar la rutina a los estudiantes seleccionados
    // Por ahora, solo mostramos un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'routineAssignedSuccess'.tr(namedArgs: {
            'routine': _currentRoutine.name,
            'count': students.length.toString(),
          }),
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (_currentRoutine.category) {
      case 'strength':
        return AppColors.primary;
      case 'cardio':
        return AppColors.error;
      case 'flexibility':
        return AppColors.success;
      case 'mixed':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon() {
    switch (_currentRoutine.category) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'flexibility':
        return Icons.self_improvement;
      case 'mixed':
        return Icons.apps;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getStatusColor() {
    switch (_currentRoutine.status) {
      case RoutineStatus.active:
        return AppColors.success;
      case RoutineStatus.paused:
        return AppColors.warning;
      case RoutineStatus.completed:
        return AppColors.primary;
      default:
        return AppColors.textSecondary;
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'duplicate':
        _duplicateRoutine();
        break;
      case 'delete':
        _deleteRoutine();
        break;
    }
  }

  void _duplicateRoutine() {
    final duplicatedRoutine = _currentRoutine.copyWith(
      id: 0, // Will be assigned by database
      name: '${_currentRoutine.name} (Copy)',
      status: RoutineStatus.active,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    ref.read(routinesProvider.notifier).createRoutine(duplicatedRoutine);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('routineDuplicated'.tr())),
    );
  }

  void _deleteRoutine() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteRoutine'.tr()),
        content: Text('deleteRoutineConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(routinesProvider.notifier)
                  .deleteRoutine(_currentRoutine.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('routineDeleted'.tr())),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }

  void _handleExerciseAction(String action, Exercise exercise, int index) {
    switch (action) {
      case 'edit':
        _showEditExerciseDialog(exercise, index);
        break;
      case 'delete':
        _deleteExercise(index);
        break;
    }
  }

  void _deleteExercise(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteExercise'.tr()),
        content: Text('deleteExerciseConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              List<Exercise> updatedExercises =
                  List.from(_currentRoutine.exercises);
              updatedExercises.removeAt(index);

              final updatedRoutine = _currentRoutine.copyWith(
                exercises: updatedExercises,
                updatedAt: DateTime.now(),
              );

              ref.read(routinesProvider.notifier).updateRoutine(updatedRoutine);

              setState(() {
                _currentRoutine = updatedRoutine;
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('exerciseDeleted'.tr())),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }

  RoutineDifficulty _parseDifficulty(String difficultyName) {
    switch (difficultyName) {
      case 'beginner':
        return RoutineDifficulty.beginner;
      case 'intermediate':
        return RoutineDifficulty.intermediate;
      case 'advanced':
        return RoutineDifficulty.advanced;
      default:
        return RoutineDifficulty.beginner;
    }
  }

  RoutineStatus _parseStatus(String statusName) {
    switch (statusName) {
      case 'active':
        return RoutineStatus.active;
      case 'paused':
        return RoutineStatus.paused;
      case 'completed':
        return RoutineStatus.completed;
      default:
        return RoutineStatus.active;
    }
  }
}
