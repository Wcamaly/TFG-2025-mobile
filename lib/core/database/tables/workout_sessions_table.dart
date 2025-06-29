import 'package:drift/drift.dart';
import 'users_table.dart';
import 'students_table.dart';
import 'routines_table.dart';

@DataClassName('DbWorkoutSession')
class WorkoutSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get routineId => integer().references(Routines, #id)();
  DateTimeColumn get sessionDate => dateTime()();
  IntColumn get durationMinutes => integer()();
  RealColumn get caloriesBurned => real().withDefault(const Constant(0.0))();
  RealColumn get overallRating => real().withDefault(const Constant(0.0))();
  TextColumn get notes => text().nullable()();
  TextColumn get status => textEnum<WorkoutSessionStatus>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('DbExerciseSession')
class ExerciseSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutSessionId =>
      integer().references(WorkoutSessions, #id)();
  TextColumn get exerciseName => text()();
  TextColumn get exerciseDescription => text()();
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();
  IntColumn get restTimeSeconds => integer()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get percentage => integer().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('DbExerciseSet')
class ExerciseSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseSessionId =>
      integer().references(ExerciseSessions, #id)();
  IntColumn get setNumber => integer()();
  IntColumn get reps => integer()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get percentage => integer().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  RealColumn get restTimeSeconds => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

enum WorkoutSessionStatus {
  inProgress,
  completed,
  skipped,
  cancelled;

  static WorkoutSessionStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'in_progress':
        return WorkoutSessionStatus.inProgress;
      case 'completed':
        return WorkoutSessionStatus.completed;
      case 'skipped':
        return WorkoutSessionStatus.skipped;
      case 'cancelled':
        return WorkoutSessionStatus.cancelled;
      default:
        return WorkoutSessionStatus.inProgress;
    }
  }
}
