import 'package:drift/drift.dart';
import 'users_table.dart';
import 'students_table.dart';

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded;

  static PaymentStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'completed':
        return PaymentStatus.completed;
      case 'failed':
        return PaymentStatus.failed;
      case 'refunded':
        return PaymentStatus.refunded;
      default:
        return PaymentStatus.pending;
    }
  }
}

enum PaymentMethod {
  cash,
  card,
  transfer,
  paypal;

  static PaymentMethod fromString(String value) {
    switch (value.toLowerCase()) {
      case 'cash':
        return PaymentMethod.cash;
      case 'card':
        return PaymentMethod.card;
      case 'transfer':
        return PaymentMethod.transfer;
      case 'paypal':
        return PaymentMethod.paypal;
      default:
        return PaymentMethod.cash;
    }
  }
}

@DataClassName('DbPayment')
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get trainerId => integer().references(Users, #id)();
  RealColumn get amount => real()();
  TextColumn get status => textEnum<PaymentStatus>()();
  TextColumn get paymentMethod => textEnum<PaymentMethod>()();
  TextColumn get description => text()();
  DateTimeColumn get paymentDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
