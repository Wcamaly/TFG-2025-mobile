import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/exercise_types.dart';
import '../pages/exercise_detail_page.dart';

class ExerciseDemoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Exercise> exercises;

  const ExerciseDemoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Exercise examples
          ...exercises
              .map((exercise) => _ExerciseExampleTile(exercise: exercise)),
        ],
      ),
    );
  }
}

class _ExerciseExampleTile extends StatelessWidget {
  final Exercise exercise;

  const _ExerciseExampleTile({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailPage(exercise: exercise),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.divider.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getCategoryColor(exercise.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getCategoryIcon(exercise.category),
                color: _getCategoryColor(exercise.category),
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            // Exercise info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getExerciseDescription(exercise),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Type chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getWorkoutTypeLabel(exercise.workoutType),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Flecha indicadora
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  String _getExerciseDescription(Exercise exercise) {
    switch (exercise.workoutType) {
      case WorkoutType.traditional:
        return '${exercise.sets}x${exercise.reps} • ${exercise.restTimeSeconds}s rest';
      case WorkoutType.amrap:
        return 'AMRAP ${exercise.durationMinutes} min';
      case WorkoutType.emom:
        return 'EMOM ${exercise.durationMinutes} min';
      case WorkoutType.forTime:
        return 'For Time • ${exercise.rounds} rounds';
      case WorkoutType.maxWeight:
        return 'Find your 1RM';
      default:
        return exercise.description;
    }
  }

  String _getWorkoutTypeLabel(WorkoutType type) {
    switch (type) {
      case WorkoutType.traditional:
        return 'SETS';
      case WorkoutType.amrap:
        return 'AMRAP';
      case WorkoutType.emom:
        return 'EMOM';
      case WorkoutType.tabata:
        return 'TABATA';
      case WorkoutType.forTime:
        return 'FOR TIME';
      case WorkoutType.maxReps:
        return 'MAX REPS';
      case WorkoutType.maxWeight:
        return '1RM';
      case WorkoutType.timeChallenge:
        return 'TIME';
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
}
