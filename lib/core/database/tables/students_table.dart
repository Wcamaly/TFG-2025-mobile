import 'package:drift/drift.dart';
import 'users_table.dart';

enum StudentStatus {
  active,
  inactive,
  suspended;

  static StudentStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return StudentStatus.active;
      case 'inactive':
        return StudentStatus.inactive;
      case 'suspended':
        return StudentStatus.suspended;
      default:
        return StudentStatus.active;
    }
  }
}

enum SubscriptionType {
  basic,
  premium,
  vip;

  static SubscriptionType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'basic':
        return SubscriptionType.basic;
      case 'premium':
        return SubscriptionType.premium;
      case 'vip':
        return SubscriptionType.vip;
      default:
        return SubscriptionType.basic;
    }
  }
}

@DataClassName('DbStudent')
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get trainerId => integer().references(Users, #id)();
  TextColumn get status => textEnum<StudentStatus>()();
  TextColumn get subscriptionType => textEnum<SubscriptionType>()();
  DateTimeColumn get subscriptionStartDate => dateTime()();
  DateTimeColumn get subscriptionEndDate => dateTime()();
  IntColumn get remainingClasses => integer().withDefault(const Constant(0))();
  IntColumn get totalClasses => integer().withDefault(const Constant(0))();
  RealColumn get monthlyFee => real()();
  DateTimeColumn get lastPaymentDate => dateTime().nullable()();
  DateTimeColumn get nextPaymentDate => dateTime()();
  RealColumn get progressPercentage =>
      real().withDefault(const Constant(0.0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
