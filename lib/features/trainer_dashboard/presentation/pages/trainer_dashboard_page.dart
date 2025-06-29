import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/metric_card.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../providers/trainer_dashboard_provider.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../../trainer_students/presentation/pages/students_list_page.dart';
import '../../../trainer_routines/presentation/pages/routines_list_page.dart';
import '../../../trainer_products/presentation/pages/products_list_page.dart';

class TrainerDashboardPage extends ConsumerStatefulWidget {
  const TrainerDashboardPage({super.key});

  @override
  ConsumerState<TrainerDashboardPage> createState() =>
      _TrainerDashboardPageState();
}

class _TrainerDashboardPageState extends ConsumerState<TrainerDashboardPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Obtener el trainerId del usuario autenticado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authProvider);
      authState.when(
        authenticated: (user) {
          _pages = [
            const _DashboardHomeTab(),
            const StudentsListPage(),
            const RoutinesListPage(),
            ProductsListPage(trainerId: int.tryParse(user.id) ?? 1),
          ];
          setState(() {});
        },
        initial: () => _pages = [
          const _DashboardHomeTab(),
          const StudentsListPage(),
          const RoutinesListPage(),
          const ProductsListPage(trainerId: 1), // Fallback
        ],
        loading: () => _pages = [
          const _DashboardHomeTab(),
          const StudentsListPage(),
          const RoutinesListPage(),
          const ProductsListPage(trainerId: 1), // Fallback
        ],
        unauthenticated: (_) => _pages = [
          const _DashboardHomeTab(),
          const StudentsListPage(),
          const RoutinesListPage(),
          const ProductsListPage(trainerId: 1), // Fallback
        ],
      );

      // Cargar datos del dashboard
      ref.read(trainerDashboardProvider.notifier).loadDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: 'dashboard'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            label: 'students'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: 'routines'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory),
            label: 'products'.tr(),
          ),
        ],
      ),
    );
  }
}

class _DashboardHomeTab extends ConsumerWidget {
  const _DashboardHomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(trainerDashboardProvider.notifier).refresh();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con perfil
                _buildHeader(context, ref),
                const SizedBox(height: 24),

                // Métricas principales
                ref.watch(trainerDashboardProvider).when(
                      data: (stats) => _buildMetricsSection(stats),
                      loading: () => _buildLoadingMetrics(),
                      error: (error, stack) => _buildErrorMetrics(error),
                    ),
                const SizedBox(height: 24),

                // Ingresos del mes
                ref.watch(trainerDashboardProvider).when(
                      data: (stats) => _buildIncomeSection(stats),
                      loading: () =>
                          _buildLoadingSection('incomeBreakdown'.tr()),
                      error: (error, stack) =>
                          _buildErrorSection('incomeBreakdown'.tr()),
                    ),
                const SizedBox(height: 24),

                // Alumnos activos
                ref.watch(trainerDashboardProvider).when(
                      data: (stats) => _buildActiveStudentsSection(stats),
                      loading: () =>
                          _buildLoadingSection('recentStudents'.tr()),
                      error: (error, stack) =>
                          _buildErrorSection('recentStudents'.tr()),
                    ),
                const SizedBox(height: 24),

                // Rutinas más asignadas
                ref.watch(trainerDashboardProvider).when(
                      data: (stats) => _buildTopRoutinesSection(stats),
                      loading: () => _buildLoadingSection('topRoutines'.tr()),
                      error: (error, stack) =>
                          _buildErrorSection('topRoutines'.tr()),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'trainerDashboard'.tr(),
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              authState.when(
                authenticated: (user) => Text(
                  'hello'.tr().replaceAll(
                      '{}', user.name.isNotEmpty ? user.name : 'Entrenador'),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                initial: () => Text(
                  'hello'.tr().replaceAll('{}', 'Entrenador'),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                loading: () => Text(
                  'Cargando...',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                unauthenticated: (_) => Text(
                  'hello'.tr().replaceAll('{}', 'Entrenador'),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'controlPanel'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Avatar del usuario
        _buildAvatar(context, ref),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.person,
          color: AppColors.primary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildMetricsSection(DashboardStats stats) {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            title: 'activeStudents'.tr(),
            value: stats.activeStudents.toString(),
            subtitle: 'of ${stats.totalStudents} total',
            icon: Icons.people,
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            title: 'monthlyIncome'.tr(),
            value: '€${stats.monthlyIncome.toStringAsFixed(0)}',
            subtitle: 'monthlyIncomeSubtitle'.tr(),
            icon: Icons.attach_money,
            iconColor: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingMetrics() {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            title: 'activeStudents'.tr(),
            value: '...',
            subtitle: 'loading'.tr(),
            icon: Icons.people,
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            title: 'monthlyIncome'.tr(),
            value: '...',
            subtitle: 'loading'.tr(),
            icon: Icons.attach_money,
            iconColor: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMetrics(Object error) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'activeStudents'.tr(),
                value: '0',
                subtitle: 'Error',
                icon: Icons.people,
                iconColor: AppColors.error,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricCard(
                title: 'monthlyIncome'.tr(),
                value: '€0',
                subtitle: 'Error',
                icon: Icons.attach_money,
                iconColor: AppColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.error.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Error: $error',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeSection(DashboardStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'incomeBreakdown'.tr(),
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: stats.incomeBreakdown
                .map((item) => _buildIncomeItem(
                    item.title, '€${item.amount.toStringAsFixed(0)}'))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeItem(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            amount,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveStudentsSection(DashboardStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'recentStudents'.tr(),
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar a lista completa de alumnos
              },
              child: Text('seeAll'.tr()),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...stats.recentStudents
            .map((student) => _buildStudentItem(student))
            .toList(),
      ],
    );
  }

  Widget _buildStudentItem(RecentStudent student) {
    final isActive = student.status == 'Activo';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Text(
              student.name.isNotEmpty ? student.name[0].toUpperCase() : 'U',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _formatLastActivity(student.lastActivity),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              student.status,
              style: AppTextStyles.bodySmall.copyWith(
                color: isActive ? AppColors.success : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastActivity(DateTime lastActivity) {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    if (difference.inDays > 0) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inHours > 0) {
      return 'Hace ${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return 'Hace ${difference.inMinutes} minutos';
    } else {
      return 'Ahora';
    }
  }

  Widget _buildTopRoutinesSection(DashboardStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'topRoutines'.tr(),
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: stats.topRoutines
                .map((routine) => _buildRoutineItem(
                      routine.name,
                      '${routine.assignedStudents} ${'students'.tr()}',
                      _getRoutineIcon(routine.category),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutineItem(String name, String students, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  students,
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

  IconData _getRoutineIcon(String category) {
    switch (category.toLowerCase()) {
      case 'fuerza':
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'yoga':
        return Icons.self_improvement;
      case 'crossfit':
        return Icons.sports_gymnastics;
      default:
        return Icons.fitness_center;
    }
  }

  Widget _buildLoadingSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Error cargando datos',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
