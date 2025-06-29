import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../trainer_dashboard/domain/entities/student.dart';
import '../../../trainer_routines/domain/entities/routine.dart';
import '../../../trainer_routines/presentation/providers/routines_provider.dart';
import '../providers/student_routines_provider.dart';

class SelectRoutinePage extends ConsumerStatefulWidget {
  final Student student;

  const SelectRoutinePage({
    super.key,
    required this.student,
  });

  @override
  ConsumerState<SelectRoutinePage> createState() => _SelectRoutinePageState();
}

class _SelectRoutinePageState extends ConsumerState<SelectRoutinePage> {
  DateTime _selectedDate = DateTime.now();
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar rutinas del entrenador
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routinesProvider.notifier).loadRoutines();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routinesState = ref.watch(routinesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('selectRoutineToAssign'.tr()),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header con información del estudiante y fecha
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Información del estudiante
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: widget.student.photoUrl != null
                          ? NetworkImage(widget.student.photoUrl!)
                          : null,
                      child: widget.student.photoUrl == null
                          ? Text(
                              widget.student.name
                                  .split(' ')
                                  .map((n) => n[0])
                                  .take(2)
                                  .join(),
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'assigningTo'.tr(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            widget.student.name,
                            style: AppTextStyles.headlineMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Selector de fecha
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'scheduledDate'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'searchRoutines'.tr(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                          ref
                              .read(routinesProvider.notifier)
                              .searchRoutines('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                ref.read(routinesProvider.notifier).searchRoutines(value);
              },
            ),
          ),

          // Lista de rutinas
          Expanded(
            child: _buildRoutinesList(routinesState),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutinesList(RoutinesState routinesState) {
    if (routinesState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (routinesState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${routinesState.error}',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(routinesProvider.notifier).loadRoutines();
              },
              child: Text('retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (routinesState.routines.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'noRoutinesFound'.tr()
                  : 'noRoutinesYet'.tr(),
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: routinesState.routines.length,
      itemBuilder: (context, index) {
        final routine = routinesState.routines[index];
        return _buildRoutineCard(routine);
      },
    );
  }

  Widget _buildRoutineCard(Routine routine) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getRoutineCategoryColor(routine.category),
          child: Icon(
            _getRoutineCategoryIcon(routine.category),
            color: Colors.white,
            size: 20,
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
            const SizedBox(height: 4),
            Text(
              routine.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          '${routine.duration}min',
                          style: AppTextStyles.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          '${routine.exercises.length} ej.',
                          style: AppTextStyles.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getRoutineDifficultyColor(routine.difficulty)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    routine.difficultyDisplayName,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: _getRoutineDifficultyColor(routine.difficulty),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _assignRoutine(routine),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'assign'.tr(),
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoutineCategoryColor(String category) {
    switch (category.toLowerCase()) {
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

  IconData _getRoutineCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'flexibility':
        return Icons.self_improvement;
      case 'mixed':
        return Icons.blender;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getRoutineDifficultyColor(RoutineDifficulty difficulty) {
    switch (difficulty) {
      case RoutineDifficulty.beginner:
        return AppColors.success;
      case RoutineDifficulty.intermediate:
        return AppColors.warning;
      case RoutineDifficulty.advanced:
        return AppColors.error;
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _assignRoutine(Routine routine) async {
    try {
      final studentId = int.tryParse(widget.student.id);
      if (studentId == null) {
        throw Exception('Invalid student ID');
      }

      await ref.read(routinesProvider.notifier).assignRoutineToStudents(
            routineId: routine.id,
            studentIds: [studentId],
            scheduledDate: _selectedDate,
          );

      // Mostrar confirmación
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('routineAssignedSuccessfully'.tr()),
            backgroundColor: AppColors.success,
          ),
        );

        // Recargar las rutinas del estudiante
        ref
            .read(studentRoutinesProvider.notifier)
            .loadRoutinesForStudent(studentId);

        // Volver a la página anterior
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
