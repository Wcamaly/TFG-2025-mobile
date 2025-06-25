import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WorkoutCalendarSelector extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WorkoutCalendarSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<WorkoutCalendarSelector> createState() =>
      _WorkoutCalendarSelectorState();
}

class _WorkoutCalendarSelectorState extends State<WorkoutCalendarSelector> {
  late DateTime _currentMonth;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentMonth =
        DateTime(widget.selectedDate.year, widget.selectedDate.month);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                onPressed: () => _previousMonth(),
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                _getMonthYearString(_currentMonth),
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => _nextMonth(),
                icon: Icon(
                  Icons.chevron_right,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Days of week header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'X', 'J', 'V', 'S', 'D']
                .map((day) => Container(
                      width: 40,
                      height: 40,
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

          const SizedBox(height: 8),

          // Calendar grid
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentMonth = DateTime(
                      _currentMonth.year, _currentMonth.month + (index - 1));
                });
              },
              itemBuilder: (context, index) {
                final month = DateTime(
                    _currentMonth.year, _currentMonth.month + (index - 1));
                return _buildCalendarGrid(month);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 42, // 6 weeks * 7 days
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
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : (isToday ? AppColors.primary.withOpacity(0.1) : null),
              borderRadius: BorderRadius.circular(8),
              border: hasWorkout && !isSelected
                  ? Border.all(color: AppColors.primary, width: 1)
                  : null,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    dayIndex.toString(),
                    style: AppTextStyles.bodyMedium.copyWith(
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
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 6,
                      height: 6,
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

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _hasWorkoutOnDate(DateTime date) {
    // Simular que hay workouts en algunos días
    return date.day % 3 == 0 || date.day % 7 == 0;
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

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
