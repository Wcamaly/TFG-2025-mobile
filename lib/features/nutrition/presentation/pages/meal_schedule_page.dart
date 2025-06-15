import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/meal_schedule_provider.dart';
import '../widgets/meal_schedule_item.dart';
import '../../domain/entities/meal.dart';

class MealSchedulePage extends ConsumerStatefulWidget {
  const MealSchedulePage({super.key});

  @override
  ConsumerState<MealSchedulePage> createState() => _MealSchedulePageState();
}

class _MealSchedulePageState extends ConsumerState<MealSchedulePage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(mealScheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/meal-search');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<MealSchedule>(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              ref.read(mealScheduleProvider.notifier).loadSchedule(selectedDay);
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                opacity: 0.5,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: scheduleState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.red,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(mealScheduleProvider.notifier)
                            .loadSchedule(_selectedDay);
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
              loaded: (mealPlan) => ReorderableListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mealPlan.meals.length,
                itemBuilder: (context, index) {
                  final meal = mealPlan.meals[index];
                  return MealScheduleItem(
                    key: ValueKey(meal.mealId),
                    meal: meal,
                    onDelete: () {
                      ref.read(mealScheduleProvider.notifier).removeMeal(
                            mealId: meal.mealId,
                            date: _selectedDay,
                            time: meal.time,
                          );
                    },
                    onTimeChanged: (newTime) {
                      ref.read(mealScheduleProvider.notifier).updateMealTime(
                            mealId: meal.mealId,
                            date: _selectedDay,
                            oldTime: meal.time,
                            newTime: newTime,
                          );
                    },
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  ref.read(mealScheduleProvider.notifier).reorderMeals(
                        oldIndex: oldIndex,
                        newIndex: newIndex,
                        date: _selectedDay,
                      );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/meal-search');
        },
        label: const Text('Add Meal'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
