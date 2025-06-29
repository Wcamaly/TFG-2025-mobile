import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/database/tables/routines_table.dart';
import '../providers/dashboard_routines_provider.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../workouts/presentation/pages/workout_detail_page.dart';
import '../../../workouts/domain/entities/workout_progress.dart';

class TodaysRoutinesCard extends ConsumerWidget {
  final VoidCallback? onNavigateToWorkouts;

  const TodaysRoutinesCard({
    super.key,
    this.onNavigateToWorkouts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(todaysRoutinesProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'todaysRoutines'.tr(),
                  style: AppTextStyles.headlineLarge,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      if (onNavigateToWorkouts != null) {
                        onNavigateToWorkouts!();
                      }
                    },
                    child: Text('viewAll'.tr()),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          routinesAsync.when(
            data: (routines) {
              if (routines.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.surfaceLight,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.fitness_center_outlined,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'noRoutinesToday'.tr(),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'enjoyYourDay'.tr(),
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
                children: routines.map((routine) {
                  return GestureDetector(
                    onTap: () => _navigateToRoutineDetail(context, routine),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.surfaceLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(routine.category),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getCategoryIcon(routine.category),
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  routine.name,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getDifficultyColor(
                                            routine.difficulty),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        _getDifficultyText(routine.difficulty),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.surfaceLight,
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stack) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'errorLoadingRoutines'.tr(),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(todaysRoutinesProvider);
                      },
                      child: Text('retry'.tr()),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToRoutineDetail(BuildContext context, DbRoutine routine) {
    // Crear un DailyGoal simple para la navegación
    final dailyGoal = DailyGoal(
      id: routine.id.toString(),
      title: routine.name,
      description: routine.description ?? 'Sin descripción',
      type: _getGoalTypeFromCategory(routine.category),
      isCompleted: false,
      order: 1,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailPage(
          goal: dailyGoal,
          customExercises: [], // Ejercicios vacíos por ahora
        ),
      ),
    );
  }

  GoalType? _getGoalTypeFromCategory(String category) {
    switch (category.toLowerCase()) {
      case 'warmup':
      case 'calentamiento':
        return GoalType.warmUp;
      case 'strength':
      case 'fuerza':
        return GoalType.strength;
      case 'cardio':
        return GoalType.cardio;
      case 'cooldown':
      case 'enfriamiento':
        return GoalType.coolDown;
      default:
        return GoalType.strength;
    }
  }

  Color _getCategoryColor(String category) {
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

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'flexibility':
        return Icons.accessibility_new;
      case 'mixed':
        return Icons.all_inclusive;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.success;
      case DifficultyLevel.intermediate:
        return AppColors.warning;
      case DifficultyLevel.advanced:
        return AppColors.error;
    }
  }

  String _getDifficultyText(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return 'beginner'.tr();
      case DifficultyLevel.intermediate:
        return 'intermediate'.tr();
      case DifficultyLevel.advanced:
        return 'advanced'.tr();
    }
  }
}
