import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/exercise_types.dart';

class AdvancedStatsCard extends StatelessWidget {
  final List<PersonalRecord> personalRecords;
  final List<WorkoutSession> recentSessions;
  final String title;

  const AdvancedStatsCard({
    super.key,
    required this.personalRecords,
    required this.recentSessions,
    required this.title,
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
            child: Text(
              title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Personal Records Section
          if (personalRecords.isNotEmpty) ...[
            _buildSectionTitle('Personal Records 🏆'),
            _buildPRsList(),
          ],

          // Recent Sessions Section
          if (recentSessions.isNotEmpty) ...[
            _buildSectionTitle('Sesiones Recientes'),
            _buildRecentSessionsList(),
          ],

          // Performance Metrics
          _buildSectionTitle('Métricas de Rendimiento'),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPRsList() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: personalRecords.length,
        itemBuilder: (context, index) {
          final pr = personalRecords[index];
          return _PRCard(pr: pr);
        },
      ),
    );
  }

  Widget _buildRecentSessionsList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: recentSessions.length,
        itemBuilder: (context, index) {
          final session = recentSessions[index];
          return _SessionCard(session: session);
        },
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  title: 'Volumen Total',
                  value: _calculateTotalVolume(),
                  unit: 'kg',
                  icon: Icons.fitness_center,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricTile(
                  title: 'Tiempo Total',
                  value: _calculateTotalTime(),
                  unit: 'min',
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  title: 'WODs Completados',
                  value: _countCompletedWODs().toString(),
                  unit: '',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricTile(
                  title: 'Mejor Tiempo',
                  value: _getBestTime(),
                  unit: '',
                  icon: Icons.speed,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTotalVolume() {
    double total = 0;
    for (var session in recentSessions) {
      for (var stat in session.stats) {
        if (stat.weightUsed != null && stat.completedReps != null) {
          total += stat.weightUsed! * stat.completedReps!;
        }
      }
    }
    return total > 1000
        ? '${(total / 1000).toStringAsFixed(1)}k'
        : total.toStringAsFixed(0);
  }

  String _calculateTotalTime() {
    int total =
        recentSessions.fold(0, (sum, session) => sum + session.durationMinutes);
    return total > 60
        ? '${(total / 60).toStringAsFixed(1)}h'
        : total.toString();
  }

  int _countCompletedWODs() {
    return recentSessions.length;
  }

  String _getBestTime() {
    if (recentSessions.isEmpty) return '--';

    int bestTime = recentSessions
        .map((s) => s.durationMinutes)
        .reduce((a, b) => a < b ? a : b);

    return '${bestTime}min';
  }
}

class _PRCard extends StatelessWidget {
  final PersonalRecord pr;

  const _PRCard({required this.pr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.primary.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getPRIcon(pr.type),
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                _getPRTypeLabel(pr.type),
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pr.exerciseName,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            '${pr.value.toStringAsFixed(pr.type == PRType.bestTime ? 0 : 1)}${_getPRUnit(pr.type)}',
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPRIcon(PRType type) {
    switch (type) {
      case PRType.oneRM:
      case PRType.threeRM:
      case PRType.fiveRM:
        return Icons.fitness_center;
      case PRType.maxReps:
        return Icons.repeat;
      case PRType.bestTime:
        return Icons.timer;
      case PRType.maxRounds:
        return Icons.refresh;
    }
  }

  String _getPRTypeLabel(PRType type) {
    switch (type) {
      case PRType.oneRM:
        return '1RM';
      case PRType.threeRM:
        return '3RM';
      case PRType.fiveRM:
        return '5RM';
      case PRType.maxReps:
        return 'Max Reps';
      case PRType.bestTime:
        return 'Best Time';
      case PRType.maxRounds:
        return 'Max Rounds';
    }
  }

  String _getPRUnit(PRType type) {
    switch (type) {
      case PRType.oneRM:
      case PRType.threeRM:
      case PRType.fiveRM:
        return 'kg';
      case PRType.maxReps:
        return ' reps';
      case PRType.bestTime:
        return 's';
      case PRType.maxRounds:
        return ' rounds';
    }
  }
}

class _SessionCard extends StatelessWidget {
  final WorkoutSession session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.name,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            _formatDate(session.date),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${session.durationMinutes}min',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              if (session.overallRating != null)
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber,
                    ),
                    Text(
                      session.overallRating!.toStringAsFixed(1),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Ayer';
    if (difference < 7) return '${difference}d ago';

    return '${date.day}/${date.month}';
  }
}

class _MetricTile extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _MetricTile({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
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
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: color,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
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
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
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
  }
}
