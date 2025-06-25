import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/charts/circular_progress.dart';
import '../../domain/entities/workout_progress.dart';

class WorkoutProgressCard extends StatelessWidget {
  final WorkoutProgress progress;
  final String title;
  final VoidCallback? onTap;

  const WorkoutProgressCard({
    super.key,
    required this.progress,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Main progress section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  // Circular progress
                  CircularProgress(
                    progress: progress.progressPercentage / 100,
                    size: 120,
                    strokeWidth: 8,
                    backgroundColor: AppColors.divider.withOpacity(0.3),
                    color: AppColors.primary,
                    label: '${progress.progressPercentage.toInt()}',
                    sublabel: 'Percent',
                  ),

                  const SizedBox(width: 24),

                  // Stats
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StatItem(
                          label: 'Total Activity',
                          value: '${progress.completedWorkouts}',
                          unit: '/ ${progress.totalWorkouts}',
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        _StatItem(
                          label: 'Calories Burned',
                          value: '${progress.caloriesBurned}',
                          unit: 'KKal',
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom metrics
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.directions_run,
                      value:
                          '${(progress.completedMinutes * 0.8).toInt()}', // Simulated distance
                      unit: '/ 60 km',
                      label: 'Calories Burned',
                      sublabel:
                          '${progress.completedMinutes ~/ 10} KKal', // Simulated calories
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.bedtime,
                      value:
                          '${(progress.completedMinutes * 0.35).toInt()}', // Simulated sleep
                      unit: '/ 25 hrs',
                      label: 'Calories Burned',
                      sublabel:
                          '${progress.completedMinutes ~/ 15} KKal', // Simulated calories
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: unit,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final String sublabel;
  final Color color;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: unit,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            sublabel,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
