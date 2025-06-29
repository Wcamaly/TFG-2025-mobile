import 'package:equatable/equatable.dart';

enum Currency {
  eur('€', 'EUR', 'Euro'),
  usd('\$', 'USD', 'US Dollar'),
  gbp('£', 'GBP', 'British Pound'),
  jpy('¥', 'JPY', 'Japanese Yen'),
  cad('C\$', 'CAD', 'Canadian Dollar'),
  aud('A\$', 'AUD', 'Australian Dollar'),
  chf('CHF', 'CHF', 'Swiss Franc'),
  cny('¥', 'CNY', 'Chinese Yuan');

  final String symbol;
  final String code;
  final String name;

  const Currency(this.symbol, this.code, this.name);

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

class TrainerProduct extends Equatable {
  final int id;
  final int trainerId;
  final String name;
  final String description;
  final double price;
  final Currency currency;
  final int durationInDays;
  final ProductCategory category;
  final List<String> features;
  final bool isPopular;
  final ProductStatus status;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TrainerProduct({
    required this.id,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.durationInDays,
    required this.category,
    required this.features,
    required this.isPopular,
    required this.status,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        trainerId,
        name,
        description,
        price,
        currency,
        durationInDays,
        category,
        features,
        isPopular,
        status,
        imageUrl,
        createdAt,
        updatedAt,
      ];

  TrainerProduct copyWith({
    int? id,
    int? trainerId,
    String? name,
    String? description,
    double? price,
    Currency? currency,
    int? durationInDays,
    ProductCategory? category,
    List<String>? features,
    bool? isPopular,
    ProductStatus? status,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TrainerProduct(
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      durationInDays: durationInDays ?? this.durationInDays,
      category: category ?? this.category,
      features: features ?? this.features,
      isPopular: isPopular ?? this.isPopular,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
