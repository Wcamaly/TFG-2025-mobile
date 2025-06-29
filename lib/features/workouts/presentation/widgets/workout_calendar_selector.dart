import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../authentication/domain/entities/user.dart';

class WorkoutCalendarSelector extends ConsumerStatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WorkoutCalendarSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  ConsumerState<WorkoutCalendarSelector> createState() =>
      _WorkoutCalendarSelectorState();
}

class _WorkoutCalendarSelectorState
    extends ConsumerState<WorkoutCalendarSelector> {
  static const int _initialPage = 120; // Centro del PageView
  late PageController _pageController;
  late DateTime _baseMonth; // Mes actual como base
  int? _studentId;
  Map<DateTime, bool> _workoutDates = {};
  int _currentPage = _initialPage;

  @override
  void initState() {
    super.initState();
    _baseMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _pageController = PageController(initialPage: _initialPage);
    _loadStudentId();
  }

  @override
  void didUpdateWidget(WorkoutCalendarSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      _loadWorkoutDates();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_studentId != null) {
      _loadWorkoutDates();
    }
  }

  Future<void> _loadStudentId() async {
    final authState = ref.read(authProvider);
    User? user;
    authState.when(
      initial: () => user = null,
      loading: () => user = null,
      authenticated: (authenticatedUser) => user = authenticatedUser,
      unauthenticated: (message) => user = null,
    );
    if (user != null) {
      final database = sl<AppDatabase>();
      final userId = int.tryParse(user!.id);
      if (userId != null) {
        final student = await (database.select(database.students)
              ..where((s) => s.userId.equals(userId)))
            .getSingleOrNull();
        if (student != null) {
          setState(() {
            _studentId = student.id;
          });
          _loadWorkoutDates();
        }
      }
    }
  }

  Future<void> _loadWorkoutDates() async {
    if (_studentId == null) return;
    try {
      final database = sl<AppDatabase>();
      final assignedRoutines = await (database.select(database.studentRoutines)
            ..where((sr) => sr.studentId.equals(_studentId!)))
          .get();
      final Map<DateTime, bool> workoutDates = {};
      for (final routine in assignedRoutines) {
        final date = routine.scheduledDate ?? routine.assignedDate;
        final dateKey = DateTime(date.year, date.month, date.day);
        workoutDates[dateKey] = true;
      }
      if (mounted) {
        setState(() {
          _workoutDates = workoutDates;
        });
      }
    } catch (e) {
      print('❌ Error loading workout dates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Header with month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
              Builder(
                builder: (context) {
                  final month = _getMonthForPage(_currentPage);
                  return Text(
                    _getMonthYearString(month),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                icon: Icon(
                  Icons.chevron_right,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Days of week header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'X', 'J', 'V', 'S', 'D']
                .map((day) => Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 4),
          // Calendar grid
          LayoutBuilder(
            builder: (context, constraints) {
              final month = _getMonthForPage(_currentPage);
              final weeks = _getWeeksInMonth(month);
              final cellHeight = (constraints.maxWidth / 7) * 0.95;
              final gridHeight = cellHeight * weeks;
              return SizedBox(
                height: gridHeight,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final month = _getMonthForPage(index);
                    return _buildCalendarGrid(month, cellHeight);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime month, double cellHeight) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;
    final weeks = _getWeeksInMonth(month);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisExtent: cellHeight,
      ),
      itemCount: weeks * 7,
      itemBuilder: (context, index) {
        final dayIndex = index - (firstDayWeekday - 1);
        if (dayIndex < 1 || dayIndex > daysInMonth) {
          return Container(); // Empty cell
        }
        final date = DateTime(month.year, month.month, dayIndex);
        final isSelected = _isSameDay(date, widget.selectedDate);
        final isToday = _isSameDay(date, DateTime.now());
        final hasWorkout = _hasWorkoutOnDate(date);
        return GestureDetector(
          onTap: () => widget.onDateSelected(date),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : (isToday ? AppColors.primary.withOpacity(0.1) : null),
              borderRadius: BorderRadius.circular(6),
              border: hasWorkout && !isSelected
                  ? Border.all(color: AppColors.primary, width: 1)
                  : null,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    dayIndex.toString(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected
                          ? Colors.white
                          : (isToday
                              ? AppColors.primary
                              : AppColors.textPrimary),
                      fontWeight: isSelected || isToday
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (hasWorkout && !isSelected)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getWeeksInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;
    final totalCells = daysInMonth + (firstDayWeekday - 1);
    return ((totalCells / 7).ceil());
  }

  DateTime _getMonthForPage(int page) {
    return DateTime(_baseMonth.year, _baseMonth.month + (page - _initialPage));
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _hasWorkoutOnDate(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    return _workoutDates[dateKey] ?? false;
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
