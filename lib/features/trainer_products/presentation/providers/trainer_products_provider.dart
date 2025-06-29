import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/trainer_product.dart';
import '../../domain/usecases/get_trainer_products_usecase.dart';
import '../../domain/usecases/create_trainer_product_usecase.dart';
import '../../domain/usecases/update_trainer_product_usecase.dart';
import '../../domain/usecases/delete_trainer_product_usecase.dart';
import '../../domain/usecases/toggle_product_status_usecase.dart';

class TrainerProductsNotifier extends StateNotifier<TrainerProductsState> {
  final GetTrainerProductsUseCase getProductsUseCase;
  final CreateTrainerProductUseCase createProductUseCase;
  final UpdateTrainerProductUseCase updateProductUseCase;
  final DeleteTrainerProductUseCase deleteProductUseCase;
  final ToggleProductStatusUseCase toggleStatusUseCase;

  TrainerProductsNotifier({
    required this.getProductsUseCase,
    required this.createProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.toggleStatusUseCase,
  }) : super(const TrainerProductsState());

  Future<void> loadProducts(int trainerId) async {
    print('[Provider] 🔄 Loading products for trainer $trainerId');
    state = state.copyWith(isLoading: true, error: null);

    final result = await getProductsUseCase(trainerId);

    result.fold(
      (failure) {
        print('[Provider] ❌ Error loading products: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (products) {
        print(
            '[Provider] ✅ Products loaded successfully: ${products.length} products');
        print(
            '[Provider] 🔄 Previous state had: ${state.products.length} products');

        for (final product in products) {
          print(
              '[Provider] 📦 Product: ${product.name} (ID: ${product.id}, Status: ${product.status})');
        }

        // Verificar duplicaciones por ID
        final productIds = products.map((p) => p.id).toList();
        final uniqueIds = productIds.toSet();
        if (productIds.length != uniqueIds.length) {
          print('[Provider] ⚠️ DUPLICATED PRODUCTS DETECTED in loaded data!');
        }

        state = state.copyWith(
          isLoading: false,
          products: products,
          error: null,
        );
      },
    );
  }

  Future<void> createProduct(TrainerProduct product) async {
    print(
        '[Provider] 🔄 Creating product: ${product.name} for trainer ${product.trainerId}');
    state = state.copyWith(isLoading: true, error: null);

    final result = await createProductUseCase(product);

    result.fold(
      (failure) {
        print('[Provider] ❌ Error creating product: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (createdProduct) {
        print(
            '[Provider] ✅ Product created successfully: ${createdProduct.name} (ID: ${createdProduct.id})');

        // Verificar que no existe ya en la lista (prevenir duplicación)
        final existingProductIndex =
            state.products.indexWhere((p) => p.id == createdProduct.id);
        List<TrainerProduct> updatedProducts;

        if (existingProductIndex != -1) {
          print(
              '[Provider] ⚠️ Product already exists, updating instead of adding');
          updatedProducts = state.products
              .map((p) => p.id == createdProduct.id ? createdProduct : p)
              .toList();
        } else {
          print('[Provider] ➕ Adding new product to list');
          updatedProducts = [...state.products, createdProduct];
        }

        print(
            '[Provider] 📋 Total products after creation: ${updatedProducts.length}');
        state = state.copyWith(
          isLoading: false,
          products: updatedProducts,
          error: null,
        );
      },
    );
  }

  Future<void> updateProduct(TrainerProduct product) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await updateProductUseCase(product);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (updatedProduct) {
        final updatedProducts = state.products.map((p) {
          return p.id == updatedProduct.id ? updatedProduct : p;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          products: updatedProducts,
          error: null,
        );
      },
    );
  }

  Future<void> deleteProduct(int productId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await deleteProductUseCase(productId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) {
        final updatedProducts =
            state.products.where((p) => p.id != productId).toList();
        state = state.copyWith(
          isLoading: false,
          products: updatedProducts,
          error: null,
        );
      },
    );
  }

  Future<void> toggleProductStatus(int productId, ProductStatus status) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await toggleStatusUseCase(ToggleProductStatusParams(
      productId: productId,
      status: status,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) {
        final updatedProducts = state.products.map((p) {
          if (p.id == productId) {
            return p.copyWith(status: status);
          }
          return p;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          products: updatedProducts,
          error: null,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Método para refrescar productos solo si es necesario
  Future<void> refreshProductsIfNeeded(int trainerId) async {
    print(
        '[Provider] 🔍 Checking if products refresh is needed for trainer $trainerId');

    // Solo refrescar si el estado actual está vacío o hay errores
    if (state.products.isEmpty || state.error != null) {
      print('[Provider] 🔄 Refreshing products due to empty state or errors');
      await loadProducts(trainerId);
    } else {
      print('[Provider] ✅ Products state is healthy, no refresh needed');
    }
  }
}

class TrainerProductsState {
  final List<TrainerProduct> products;
  final bool isLoading;
  final String? error;

  const TrainerProductsState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  TrainerProductsState copyWith({
    List<TrainerProduct>? products,
    bool? isLoading,
    String? error,
  }) {
    return TrainerProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Providers
final trainerProductsProvider =
    StateNotifierProvider<TrainerProductsNotifier, TrainerProductsState>((ref) {
  return TrainerProductsNotifier(
    getProductsUseCase: sl<GetTrainerProductsUseCase>(),
    createProductUseCase: sl<CreateTrainerProductUseCase>(),
    updateProductUseCase: sl<UpdateTrainerProductUseCase>(),
    deleteProductUseCase: sl<DeleteTrainerProductUseCase>(),
    toggleStatusUseCase: sl<ToggleProductStatusUseCase>(),
  );
});
