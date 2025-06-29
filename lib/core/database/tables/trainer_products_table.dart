import 'package:drift/drift.dart';
import 'users_table.dart';

enum Currency {
  eur,
  usd,
  gbp,
  jpy,
  cad,
  aud,
  chf,
  cny;

  static Currency fromString(String value) {
    switch (value.toLowerCase()) {
      case 'eur':
        return Currency.eur;
      case 'usd':
        return Currency.usd;
      case 'gbp':
        return Currency.gbp;
      case 'jpy':
        return Currency.jpy;
      case 'cad':
        return Currency.cad;
      case 'aud':
        return Currency.aud;
      case 'chf':
        return Currency.chf;
      case 'cny':
        return Currency.cny;
      default:
        return Currency.eur;
    }
  }
}

enum ProductStatus {
  active,
  inactive,
  draft;

  static ProductStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return ProductStatus.active;
      case 'inactive':
        return ProductStatus.inactive;
      case 'draft':
        return ProductStatus.draft;
      default:
        return ProductStatus.draft;
    }
  }
}

enum ProductCategory {
  training,
  nutrition,
  supplements,
  equipment,
  consultation,
  other;

  static ProductCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'training':
        return ProductCategory.training;
      case 'nutrition':
        return ProductCategory.nutrition;
      case 'supplements':
        return ProductCategory.supplements;
      case 'equipment':
        return ProductCategory.equipment;
      case 'consultation':
        return ProductCategory.consultation;
      case 'other':
        return ProductCategory.other;
      default:
        return ProductCategory.other;
    }
  }
}

@DataClassName('DbTrainerProduct')
class TrainerProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trainerId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get currency =>
      textEnum<Currency>().withDefault(const Constant('eur'))();
  IntColumn get durationInDays => integer().withDefault(const Constant(30))();
  TextColumn get category => textEnum<ProductCategory>()();
  TextColumn get features => text()(); // JSON array de características
  BoolColumn get isPopular => boolean().withDefault(const Constant(false))();
  TextColumn get status => textEnum<ProductStatus>()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
