import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/trainer_products_table.dart';
import '../../domain/entities/trainer_product.dart' as domain;

abstract class TrainerProductsLocalDataSource {
  Future<List<domain.TrainerProduct>> getProductsByTrainer(int trainerId);

  Future<domain.TrainerProduct?> getProductById(int productId);

  Future<domain.TrainerProduct> createProduct(domain.TrainerProduct product);

  Future<domain.TrainerProduct> updateProduct(domain.TrainerProduct product);

  Future<void> deleteProduct(int productId);

  Future<void> toggleProductStatus(int productId, domain.ProductStatus status);

  Future<List<domain.TrainerProduct>> searchProducts(
      int trainerId, String query);
}

class TrainerProductsLocalDataSourceImpl
    implements TrainerProductsLocalDataSource {
  final AppDatabase database;

  TrainerProductsLocalDataSourceImpl(this.database);

  // Métodos de mapeo
  ProductCategory _mapToDbCategory(domain.ProductCategory category) {
    switch (category) {
      case domain.ProductCategory.training:
        return ProductCategory.training;
      case domain.ProductCategory.nutrition:
        return ProductCategory.nutrition;
      case domain.ProductCategory.supplements:
        return ProductCategory.supplements;
      case domain.ProductCategory.equipment:
        return ProductCategory.equipment;
      case domain.ProductCategory.consultation:
        return ProductCategory.consultation;
      case domain.ProductCategory.other:
        return ProductCategory.other;
    }
  }

  domain.ProductCategory _mapToDomainCategory(ProductCategory category) {
    switch (category) {
      case ProductCategory.training:
        return domain.ProductCategory.training;
      case ProductCategory.nutrition:
        return domain.ProductCategory.nutrition;
      case ProductCategory.supplements:
        return domain.ProductCategory.supplements;
      case ProductCategory.equipment:
        return domain.ProductCategory.equipment;
      case ProductCategory.consultation:
        return domain.ProductCategory.consultation;
      case ProductCategory.other:
        return domain.ProductCategory.other;
    }
  }

  ProductStatus _mapToDbStatus(domain.ProductStatus status) {
    switch (status) {
      case domain.ProductStatus.active:
        return ProductStatus.active;
      case domain.ProductStatus.inactive:
        return ProductStatus.inactive;
      case domain.ProductStatus.draft:
        return ProductStatus.draft;
    }
  }

  domain.ProductStatus _mapToDomainStatus(ProductStatus status) {
    switch (status) {
      case ProductStatus.active:
        return domain.ProductStatus.active;
      case ProductStatus.inactive:
        return domain.ProductStatus.inactive;
      case ProductStatus.draft:
        return domain.ProductStatus.draft;
    }
  }

  Currency _mapToDbCurrency(domain.Currency currency) {
    switch (currency) {
      case domain.Currency.eur:
        return Currency.eur;
      case domain.Currency.usd:
        return Currency.usd;
      case domain.Currency.gbp:
        return Currency.gbp;
      case domain.Currency.jpy:
        return Currency.jpy;
      case domain.Currency.cad:
        return Currency.cad;
      case domain.Currency.aud:
        return Currency.aud;
      case domain.Currency.chf:
        return Currency.chf;
      case domain.Currency.cny:
        return Currency.cny;
    }
  }

  domain.Currency _mapToDomainCurrency(Currency? currency) {
    if (currency == null) return domain.Currency.eur;
    switch (currency) {
      case Currency.eur:
        return domain.Currency.eur;
      case Currency.usd:
        return domain.Currency.usd;
      case Currency.gbp:
        return domain.Currency.gbp;
      case Currency.jpy:
        return domain.Currency.jpy;
      case Currency.cad:
        return domain.Currency.cad;
      case Currency.aud:
        return domain.Currency.aud;
      case Currency.chf:
        return domain.Currency.chf;
      case Currency.cny:
        return domain.Currency.cny;
    }
  }

  List<String> _parseFeatures(String featuresJson) {
    try {
      final List<dynamic> features = jsonDecode(featuresJson);
      return features.map((f) => f.toString()).toList();
    } catch (e) {
      return ['Característica por defecto'];
    }
  }

  domain.TrainerProduct _mapToEntity(DbTrainerProduct dbProduct) {
    print('[Datasource] Mapeando producto: $dbProduct');
    print('[Datasource] Currency en DB: [33m${dbProduct.currency}[0m');
    final mappedCurrency = _mapToDomainCurrency(dbProduct.currency);
    print('[Datasource] Currency mapeada: [32m$mappedCurrency[0m');
    return domain.TrainerProduct(
      id: dbProduct.id,
      trainerId: dbProduct.trainerId,
      name: dbProduct.name,
      description: dbProduct.description,
      price: dbProduct.price,
      currency: mappedCurrency,
      durationInDays: dbProduct.durationInDays,
      category: _mapToDomainCategory(dbProduct.category),
      features: _parseFeatures(dbProduct.features),
      isPopular: dbProduct.isPopular,
      status: _mapToDomainStatus(dbProduct.status),
      imageUrl: dbProduct.imageUrl,
      createdAt: dbProduct.createdAt,
      updatedAt: dbProduct.updatedAt,
    );
  }

  // Implementación de métodos
  @override
  Future<List<domain.TrainerProduct>> getProductsByTrainer(
      int trainerId) async {
    print('[Datasource] getProductsByTrainer: trainerId=$trainerId');
    final products = await database.getProductsByTrainer(trainerId);
    print('[Datasource] Productos crudos de DB:');
    for (final p in products) {
      print(p);
    }
    final mapped = products.map(_mapToEntity).toList();
    print('[Datasource] Productos mapeados:');
    for (final m in mapped) {
      print(m);
    }
    return mapped;
  }

  @override
  Future<domain.TrainerProduct?> getProductById(int productId) async {
    final product = await database.getProductById(productId);
    return product != null ? _mapToEntity(product) : null;
  }

  @override
  Future<domain.TrainerProduct> createProduct(
      domain.TrainerProduct product) async {
    print('[Datasource] 🔄 Creating product: ${product.name}');
    print('[Datasource] 👤 TrainerId: ${product.trainerId}');
    print('[Datasource] 💰 Price: ${product.price} ${product.currency}');
    print('[Datasource] 📝 Status: ${product.status}');

    final productCompanion = TrainerProductsCompanion.insert(
      trainerId: product.trainerId,
      name: product.name,
      description: product.description,
      price: product.price,
      currency: Value(_mapToDbCurrency(product.currency)),
      durationInDays: Value(product.durationInDays),
      category: _mapToDbCategory(product.category),
      features: jsonEncode(product.features),
      isPopular: Value(product.isPopular),
      status: _mapToDbStatus(product.status),
      imageUrl: Value(product.imageUrl),
    );

    print('[Datasource] 📦 ProductCompanion created successfully');
    final productId = await database.insertTrainerProduct(productCompanion);
    print('[Datasource] ✅ Product inserted with ID: $productId');

    // Verificar que se insertó correctamente
    final insertedProduct = await database.getProductById(productId);
    if (insertedProduct != null) {
      print('[Datasource] ✅ Product verified in DB: ${insertedProduct.name}');
    } else {
      print('[Datasource] ❌ Product NOT found in DB after insertion!');
    }

    return product.copyWith(id: productId);
  }

  @override
  Future<domain.TrainerProduct> updateProduct(
      domain.TrainerProduct product) async {
    print('[Datasource] Updating product: ${product.id} - ${product.name}');
    print('[Datasource] Product trainerId: ${product.trainerId}');

    final updateCompanion = TrainerProductsCompanion(
      id: Value(product.id),
      name: Value(product.name),
      description: Value(product.description),
      price: Value(product.price),
      currency: Value(_mapToDbCurrency(product.currency)),
      category: Value(_mapToDbCategory(product.category)),
      features: Value(jsonEncode(product.features)),
      isPopular: Value(product.isPopular),
      status: Value(_mapToDbStatus(product.status)),
      imageUrl: Value(product.imageUrl),
      updatedAt: Value(DateTime.now()),
    );

    print('[Datasource] UpdateCompanion created successfully');
    await database.updateTrainerProduct(updateCompanion);
    print('[Datasource] Product updated successfully');
    return product.copyWith(updatedAt: DateTime.now());
  }

  @override
  Future<void> deleteProduct(int productId) async {
    await database.deleteTrainerProduct(productId);
  }

  @override
  Future<void> toggleProductStatus(
      int productId, domain.ProductStatus status) async {
    final product = await database.getProductById(productId);
    if (product != null) {
      final productCompanion = TrainerProductsCompanion(
        id: Value(productId),
        status: Value(_mapToDbStatus(status)),
        updatedAt: Value(DateTime.now()),
      );
      await database.updateTrainerProduct(productCompanion);
    }
  }

  @override
  Future<List<domain.TrainerProduct>> searchProducts(
      int trainerId, String query) async {
    final allProducts = await database.getProductsByTrainer(trainerId);

    if (query.isEmpty) {
      return allProducts.map(_mapToEntity).toList();
    }

    final filteredProducts = allProducts.where((product) {
      final name = product.name.toLowerCase();
      final description = product.description.toLowerCase();
      final searchQuery = query.toLowerCase();

      return name.contains(searchQuery) || description.contains(searchQuery);
    }).toList();

    return filteredProducts.map(_mapToEntity).toList();
  }
}
