import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAssign;

  const RoutineCard({
    super.key,
    required this.routine,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onAssign,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con título y menú
              Row(
                children: [
                  Expanded(
                    child: Text(
                      routine.name,
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'assign':
                          onAssign?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            const Icon(Icons.edit, size: 20),
                            const SizedBox(width: 8),
                            Text('edit'.tr()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'assign',
                        child: Row(
                          children: [
                            const Icon(Icons.assignment, size: 20),
                            const SizedBox(width: 8),
                            Text('assign'.tr()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete,
                                size: 20, color: Colors.red),
                            const SizedBox(width: 8),
                            Text('delete'.tr(),
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Descripción
              Text(
                routine.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Información de la rutina
              Row(
                children: [
                  _buildInfoChip(
                    Icons.timer,
                    '${routine.duration} min',
                    AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.category,
                    routine.category.tr(),
                    AppColors.secondary,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.trending_up,
                    routine.difficulty.name.tr(),
                    _getDifficultyColor(routine.difficulty),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Estadísticas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'assignedStudents'.tr()}: ${routine.assignedStudents}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(routine.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      routine.status.name.tr(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: _getStatusColor(routine.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(RoutineDifficulty difficulty) {
    switch (difficulty) {
      case RoutineDifficulty.beginner:
        return AppColors.success;
      case RoutineDifficulty.intermediate:
        return AppColors.warning;
      case RoutineDifficulty.advanced:
        return AppColors.error;
    }
  }

  Color _getStatusColor(RoutineStatus status) {
    switch (status) {
      case RoutineStatus.active:
        return AppColors.success;
      case RoutineStatus.paused:
        return AppColors.warning;
      case RoutineStatus.completed:
        return AppColors.primary;
    }
  }
}
