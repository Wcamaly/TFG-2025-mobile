import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/workout_progress.dart';

class WeeklyMonitoringCard extends StatelessWidget {
  final WeeklyStats weeklyStats;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const WeeklyMonitoringCard({
    super.key,
    required this.weeklyStats,
    required this.title,
    required this.subtitle,
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
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Chart section
            Container(
              height: 200,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _WeeklyChart(
                data: weeklyStats.days,
                maxValue: _getMaxValue(weeklyStats.days),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxValue(List<DayStats> days) {
    if (days.isEmpty) return 100;
    return days.map((day) => day.progress).reduce((a, b) => a > b ? a : b);
  }
}

class _WeeklyChart extends StatelessWidget {
  final List<DayStats> data;
  final double maxValue;

  const _WeeklyChart({
    required this.data,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data.asMap().entries.map((entry) {
        final index = entry.key;
        final dayStats = entry.value;
        final isToday = index == 0; // Simulate today being Monday

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Bar
                Container(
                  width: double.infinity,
                  height: _getBarHeight(dayStats.progress),
                  decoration: BoxDecoration(
                    color: isToday
                        ? AppColors.primary
                        : AppColors.divider.withOpacity(0.6),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Day label
                Text(
                  dayStats.day,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isToday
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  double _getBarHeight(double value) {
    const maxHeight = 120.0;
    if (maxValue == 0) return 0;
    return (value / maxValue) * maxHeight;
  }
}
