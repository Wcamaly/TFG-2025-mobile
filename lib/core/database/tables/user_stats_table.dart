import 'package:drift/drift.dart';
import 'users_table.dart';

class UserStats extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get calories => integer().withDefault(const Constant(0))();
  IntColumn get heartRate => integer().withDefault(const Constant(0))();
  RealColumn get weight => real().withDefault(const Constant(0.0))();
  IntColumn get workoutMinutes => integer().withDefault(const Constant(0))();
  IntColumn get workoutsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get steps => integer().withDefault(const Constant(0))();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class DailyProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get calories => integer().withDefault(const Constant(0))();
  IntColumn get steps => integer().withDefault(const Constant(0))();
  RealColumn get weight => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
