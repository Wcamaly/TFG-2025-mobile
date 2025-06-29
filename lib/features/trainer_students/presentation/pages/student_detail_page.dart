import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/students_provider.dart';
import '../../../trainer_dashboard/domain/entities/student.dart';
import '../providers/student_routines_provider.dart';
import '../../../trainer_routines/domain/entities/routine.dart';
import '../../../trainer_routines/presentation/pages/routine_detail_page.dart';
import '../../../trainer_routines/presentation/providers/routines_provider.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import 'select_routine_page.dart';

class StudentDetailPage extends ConsumerStatefulWidget {
  final Student student;

  const StudentDetailPage({
    super.key,
    required this.student,
  });

  @override
  ConsumerState<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends ConsumerState<StudentDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Cargar rutinas asignadas cuando se abre la pestaña de rutinas
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        // Index 1 es la pestaña de rutinas
        _loadStudentRoutines();
      }
    });

    // Cargar rutinas asignadas inmediatamente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudentRoutines();
    });
  }

  void _loadStudentRoutines() {
    final studentId = int.tryParse(widget.student.id);
    if (studentId != null) {
      ref
          .read(studentRoutinesProvider.notifier)
          .loadRoutinesForStudent(studentId);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.student.name,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        CircleAvatar(
                          radius: 40,
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
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.student.status)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            widget.student.statusDisplayName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'suspend':
                        _showSuspendDialog();
                        break;
                      case 'reactivate':
                        _showSuspendDialog();
                        break;
                      case 'delete':
                        _showDeleteDialog();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: widget.student.status == StudentStatus.active
                          ? 'suspend'
                          : 'reactivate',
                      child: Row(
                        children: [
                          Icon(
                            widget.student.status == StudentStatus.active
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(widget.student.status == StudentStatus.active
                              ? 'suspendStudent'.tr()
                              : 'reactivateStudent'.tr()),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, size: 20, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            'deleteStudent'.tr(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  tabs: [
                    Tab(text: 'info'.tr()),
                    Tab(text: 'routines'.tr()),
                    Tab(text: 'payments'.tr()),
                    Tab(text: 'progress'.tr()),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildInfoTab(),
            _buildRoutinesTab(),
            _buildPaymentsTab(),
            _buildProgressTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Información de suscripción
          _buildInfoCard(
            title: 'subscriptionInfo'.tr(),
            icon: Icons.card_membership,
            children: [
              _buildInfoRow(
                  'subscription'.tr(), widget.student.subscriptionDisplayName),
              _buildInfoRow('monthlyFee'.tr(),
                  '€${widget.student.monthlyFee.toStringAsFixed(0)}'),
              _buildInfoRow('remainingClasses'.tr(),
                  '${widget.student.remainingClasses}/${widget.student.totalClasses}'),
            ],
          ),

          const SizedBox(height: 16),

          // Información de clases
          _buildInfoCard(
            title: 'classInfo'.tr(),
            icon: Icons.fitness_center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'progress'.tr(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: widget.student.progressPercentage / 100,
                          backgroundColor:
                              AppColors.textSecondary.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getProgressColor(
                                widget.student.progressPercentage),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.student.progressPercentage.toStringAsFixed(0)}%',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notas del entrenador
          Consumer(
            builder: (context, ref, child) {
              // Buscar el estudiante actualizado en el estado del provider
              final studentsState = ref.watch(studentsProvider);
              final currentStudent = studentsState.students.firstWhere(
                (s) => s.id == widget.student.id,
                orElse: () => widget.student,
              );

              return _buildInfoCard(
                title: 'trainerNotes'.tr(),
                icon: Icons.note_alt,
                children: [
                  if (currentStudent.notes == null ||
                      currentStudent.notes!.isEmpty) ...[
                    Text(
                      'noNotesYet'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _showAddNoteDialog,
                        icon: const Icon(Icons.add),
                        label: Text('addNote'.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currentStudent.notes!,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _showEditNoteDialog(currentStudent.notes),
                            icon: const Icon(Icons.edit, size: 18),
                            label: Text('edit'.tr()),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showAddNoteDialog,
                            icon: const Icon(Icons.add, size: 18),
                            label: Text('addNote'.tr()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoutinesTab() {
    return Consumer(
      builder: (context, ref, child) {
        final routinesState = ref.watch(studentRoutinesProvider);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con botón de asignar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      'assignedRoutines'.tr(),
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showCreateRoutineDialog,
                            icon: const Icon(Icons.add, size: 14),
                            label: Text(
                              'create'.tr(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _navigateToSelectRoutine,
                            icon: const Icon(Icons.assignment, size: 14),
                            label: Text(
                              'assign'.tr(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Mostrar contenido basado en el estado
              if (routinesState.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (routinesState.error != null)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
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
                        onPressed: _loadStudentRoutines,
                        child: Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              else if (routinesState.routines.isEmpty)
                // Estado vacío
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Icon(
                        Icons.fitness_center,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'noRoutinesAssigned'.tr(),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                // Mostrar rutinas asignadas
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routinesState.routines.length,
                  itemBuilder: (context, index) {
                    final routine = routinesState.routines[index];
                    return _buildRoutineCard(routine);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoutineCard(Routine routine) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
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
            Text(
              routine.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
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
                const SizedBox(width: 4),
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
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color:
                _getRoutineDifficultyColor(routine.difficulty).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            routine.difficultyDisplayName,
            style: AppTextStyles.bodySmall.copyWith(
              color: _getRoutineDifficultyColor(routine.difficulty),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineDetailPage(routine: routine),
            ),
          );
        },
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

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'paymentHistory'.tr(),
            style: AppTextStyles.headlineLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Resumen
          Row(
            children: [
              Expanded(
                child: _buildPaymentSummaryCard(
                  'totalPaid'.tr(),
                  '€0', // Valor estático
                  Icons.payments,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPaymentSummaryCard(
                  'pending'.tr(),
                  '€0', // Valor estático
                  Icons.schedule,
                  AppColors.warning,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Estado vacío
          Center(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Icon(
                  Icons.payment,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  'noPaymentsYet'.tr(),
                  style: AppTextStyles.bodyLarge.copyWith(
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

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progreso general
          _buildInfoCard(
            title: 'overallProgress'.tr(),
            icon: Icons.trending_up,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'completedClasses'.tr(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${widget.student.totalClasses - widget.student.remainingClasses}/${widget.student.totalClasses}',
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'progressPercentage'.tr(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${widget.student.progressPercentage.toStringAsFixed(0)}%',
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getProgressColor(
                                widget.student.progressPercentage),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Estadísticas
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'weeklyAverage'.tr(),
                  'weeklyAverageValue'.tr(),
                  Icons.calendar_today,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'streak'.tr(),
                  'streakValue'.tr(),
                  Icons.local_fire_department,
                  AppColors.warning,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'totalWorkouts'.tr(),
                  '${widget.student.totalClasses - widget.student.remainingClasses}',
                  Icons.fitness_center,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'avgDuration'.tr(),
                  'avgDurationValue'.tr(),
                  Icons.timer,
                  AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuspendDialog() {
    final bool isSuspending = widget.student.status == StudentStatus.active;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            isSuspending ? 'suspendStudent'.tr() : 'reactivateStudent'.tr()),
        content: Text(isSuspending
            ? 'suspendStudentConfirmation'.tr()
            : 'reactivateStudentConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _updateStudentStatus(isSuspending
                  ? StudentStatus.suspended
                  : StudentStatus.active);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isSuspending ? AppColors.warning : AppColors.success,
            ),
            child: Text(isSuspending ? 'suspend'.tr() : 'reactivate'.tr()),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteStudent'.tr()),
        content: Text('deleteStudentConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
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

  void _navigateToSelectRoutine() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRoutinePage(student: widget.student),
      ),
    );
  }

  void _showCreateRoutineDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final durationController = TextEditingController();
    String selectedCategory = 'strength';
    String selectedDifficulty = 'beginner';
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('createNewRoutine'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Información del estudiante
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'creatingForStudent'
                              .tr(namedArgs: {'name': widget.student.name}),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Nombre de la rutina
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'routineName'.tr(),
                    hintText: 'enterRoutineName'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Descripción
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    hintText: 'enterDescription'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Duración
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '${'duration'.tr()} (min)',
                    hintText: 'enterDuration'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Categoría
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
                    setDialogState(() {
                      selectedCategory = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Dificultad
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
                    setDialogState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Selector de fecha
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setDialogState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textSecondary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          '${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
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
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    durationController.text.isNotEmpty) {
                  await _createAndAssignRoutine(
                    name: nameController.text,
                    description: descriptionController.text,
                    duration: int.tryParse(durationController.text) ?? 30,
                    category: selectedCategory,
                    difficulty: selectedDifficulty,
                    scheduledDate: selectedDate,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text('createAndAssign'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createAndAssignRoutine({
    required String name,
    required String description,
    required int duration,
    required String category,
    required String difficulty,
    required DateTime scheduledDate,
  }) async {
    try {
      // Obtener el ID del entrenador
      final authState = ref.read(authProvider);
      final trainerId = authState.when(
        initial: () => 1,
        loading: () => 1,
        authenticated: (user) => int.tryParse(user.id) ?? 1,
        unauthenticated: (_) => 1,
      );

      final studentId = int.tryParse(widget.student.id);
      if (studentId == null) {
        throw Exception('Invalid student ID');
      }

      // Crear la rutina
      final newRoutine = Routine(
        id: 0, // Will be assigned by database
        name: name,
        description: description,
        category: category,
        duration: duration,
        difficulty: _parseDifficulty(difficulty),
        exercises: const [],
        createdBy: trainerId,
        status: RoutineStatus.active,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Crear la rutina usando el use case directamente
      final createRoutineUseCase = ref.read(createRoutineUseCaseProvider);
      final createdRoutine = await createRoutineUseCase.call(newRoutine);

      // Asignar la rutina al estudiante
      await ref.read(routinesProvider.notifier).assignRoutineToStudents(
            routineId: createdRoutine.id,
            studentIds: [studentId],
            scheduledDate: scheduledDate,
          );

      // Recargar las rutinas del estudiante
      ref
          .read(studentRoutinesProvider.notifier)
          .loadRoutinesForStudent(studentId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('routineCreatedAndAssigned'.tr()),
            backgroundColor: AppColors.success,
          ),
        );
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

  void _showAddNoteDialog() {
    _noteController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('addNote'.tr()),
        content: TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'enterNote'.tr(),
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_noteController.text.isNotEmpty) {
                Navigator.pop(context);
                await _saveStudentNote(_noteController.text);
              }
            },
            child: Text('add'.tr()),
          ),
        ],
      ),
    );
  }

  void _showEditNoteDialog([String? existingNote]) {
    _noteController.text = existingNote ?? widget.student.notes ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('editNote'.tr()),
        content: TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'enterNote'.tr(),
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _saveStudentNote(_noteController.text);
            },
            child: Text('update'.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _saveStudentNote(String note) async {
    try {
      await ref.read(studentsProvider.notifier).updateStudentNotes(
            widget.student.id,
            note,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('noteAdded'.tr())),
        );

        // Recargar estudiantes para actualizar la UI
        ref.read(studentsProvider.notifier).refreshStudents();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar nota: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _updateStudentStatus(StudentStatus newStatus) {
    ref
        .read(studentsProvider.notifier)
        .updateStudentStatus(widget.student.id, newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('studentStatusUpdated'.tr())),
    );
  }

  Color _getStatusColor(StudentStatus status) {
    switch (status) {
      case StudentStatus.active:
        return AppColors.success;
      case StudentStatus.inactive:
        return AppColors.warning;
      case StudentStatus.suspended:
        return AppColors.error;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 80) return AppColors.success;
    if (progress >= 50) return AppColors.warning;
    return AppColors.error;
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.background,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
