import 'package:drift/drift.dart';
import 'users_table.dart';
import 'students_table.dart';

enum RoutineStatus {
  active,
  completed,
  paused,
  cancelled;

  static RoutineStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return RoutineStatus.active;
      case 'completed':
        return RoutineStatus.completed;
      case 'paused':
        return RoutineStatus.paused;
      case 'cancelled':
        return RoutineStatus.cancelled;
      default:
        return RoutineStatus.active;
    }
  }
}

enum DifficultyLevel {
  beginner,
  intermediate,
  advanced;

  static DifficultyLevel fromString(String value) {
    switch (value.toLowerCase()) {
      case 'beginner':
        return DifficultyLevel.beginner;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      default:
        return DifficultyLevel.beginner;
    }
  }
}

@DataClassName('DbRoutine')
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  IntColumn get durationMinutes => integer()();
  TextColumn get difficulty => textEnum<DifficultyLevel>()();
  IntColumn get exerciseCount => integer().withDefault(const Constant(0))();
  IntColumn get createdBy => integer().references(Users, #id)();
  TextColumn get status => textEnum<RoutineStatus>()();
  TextColumn get exercisesJson => text()(); // JSON con los ejercicios
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('DbStudentRoutine')
class StudentRoutines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get routineId => integer().references(Routines, #id)();
  IntColumn get trainerId => integer().references(Users, #id)();
  DateTimeColumn get assignedDate => dateTime()();
  DateTimeColumn get scheduledDate => dateTime()(); // Día específico programado
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get completedDate => dateTime().nullable()();
  TextColumn get status => textEnum<RoutineStatus>()();
  RealColumn get progressPercentage =>
      real().withDefault(const Constant(0.0))();
  IntColumn get completedSessions => integer().withDefault(const Constant(0))();
  IntColumn get totalSessions => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
