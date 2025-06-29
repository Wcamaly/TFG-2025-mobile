import 'package:drift/drift.dart';

enum UserRole {
  user,
  trainer;

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'user':
        return UserRole.user;
      case 'trainer':
        return UserRole.trainer;
      default:
        return UserRole.user;
    }
  }
}

@DataClassName('DbUser')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get country => text().withDefault(const Constant('España'))();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get profileImageUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable()(); // 'male', 'female', 'other'
  RealColumn get height => real().nullable()(); // en cm
  RealColumn get weight => real().nullable()(); // en kg
  TextColumn get fitnessLevel =>
      text().nullable()(); // 'beginner', 'intermediate', 'advanced'
  TextColumn get specializations =>
      text().nullable()(); // Para entrenadores, separado por comas
  RealColumn get hourlyRate => real().nullable()(); // Para entrenadores
  TextColumn get certifications => text().nullable()(); // Para entrenadores
  IntColumn get yearsExperience => integer().nullable()(); // Para entrenadores
  TextColumn get role => textEnum<UserRole>()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
