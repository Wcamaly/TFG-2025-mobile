import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/database/seed_data_manager.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/inputs/currency_display.dart';
import '../../domain/entities/trainer_product.dart';
import '../providers/trainer_products_provider.dart';

class ProductsListPage extends ConsumerStatefulWidget {
  final int trainerId;

  const ProductsListPage({
    super.key,
    required this.trainerId,
  });

  @override
  ConsumerState<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends ConsumerState<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    // Cargar productos al inicializar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(
          '[ProductsListPage] 🔄 Iniciando carga de productos para trainer ${widget.trainerId}');
      ref.read(trainerProductsProvider.notifier).loadProducts(widget.trainerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(trainerProductsProvider);
    print('[UI] Estado de productos: $productsState');
    if (productsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (productsState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${productsState.error}',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(trainerProductsProvider.notifier).clearError();
                ref
                    .read(trainerProductsProvider.notifier)
                    .loadProducts(widget.trainerId);
              },
              child: Text('retry'.tr()),
            ),
          ],
        ),
      );
    }
    print('[UI] Renderizando productos (${productsState.products.length}):');
    for (final p in productsState.products) {
      print('[UI] Producto: $p');
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'productsAndServices'.tr(),
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.add_chart),
              onPressed: _insertSampleData,
              tooltip: 'Insert Sample Data',
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateProductDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(trainerProductsProvider.notifier)
                  .loadProducts(widget.trainerId);
            },
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: _buildBody(productsState.products),
    );
  }

  Widget _buildBody(List<TrainerProduct> products) {
    return Column(
      children: [
        // Header con estadísticas
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'totalProducts'.tr(),
                  '${products.length}',
                  Icons.inventory,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'activeProducts'.tr(),
                  '${products.where((p) => p.status == ProductStatus.active).length}',
                  Icons.check_circle,
                  AppColors.success,
                ),
              ),
            ],
          ),
        ),

        // Lista de productos
        Expanded(
          child: products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'noProductsYet'.tr(),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'addYourFirstProduct'.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(product);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(TrainerProduct product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          _getCategoryColor(product.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoryIcon(product.category),
                      color: _getCategoryColor(product.category),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.status == ProductStatus.active
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(product.status),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: product.status == ProductStatus.active
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'price'.tr(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        CurrencyDisplay(
                          currency: product.currency,
                          amount: product.price,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'duration'.tr(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${product.durationInDays} days'.tr(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (product.isPopular)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'popular'.tr(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              // Mostrar características si existen
              if (product.features.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'features'.tr(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: product.features.take(3).map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        feature,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (product.features.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '+${product.features.length - 3} more'.tr(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _editProduct(product),
                      icon: const Icon(Icons.edit, size: 16),
                      label: Text('edit'.tr()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _toggleProductStatus(product),
                      icon: Icon(
                        product.status == ProductStatus.active
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 16,
                      ),
                      label: Text(product.status == ProductStatus.active
                          ? 'pause'.tr()
                          : 'activate'.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: product.status == ProductStatus.active
                            ? AppColors.warning
                            : AppColors.success,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _deleteProduct(product),
                    icon: const Icon(Icons.delete, color: AppColors.error),
                    tooltip: 'delete'.tr(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(ProductCategory category) {
    switch (category) {
      case ProductCategory.nutrition:
        return AppColors.success;
      case ProductCategory.training:
        return AppColors.primary;
      case ProductCategory.supplements:
        return AppColors.warning;
      case ProductCategory.equipment:
        return AppColors.secondary;
      case ProductCategory.consultation:
        return AppColors.primary;
      case ProductCategory.other:
        return AppColors.textSecondary;
    }
  }

  IconData _getCategoryIcon(ProductCategory category) {
    switch (category) {
      case ProductCategory.nutrition:
        return Icons.restaurant;
      case ProductCategory.training:
        return Icons.fitness_center;
      case ProductCategory.supplements:
        return Icons.medication;
      case ProductCategory.equipment:
        return Icons.sports_gymnastics;
      case ProductCategory.consultation:
        return Icons.psychology;
      case ProductCategory.other:
        return Icons.inventory;
    }
  }

  String _getStatusText(ProductStatus status) {
    switch (status) {
      case ProductStatus.active:
        return 'active'.tr();
      case ProductStatus.inactive:
        return 'inactive'.tr();
      case ProductStatus.draft:
        return 'draft'.tr();
    }
  }

  void _showCreateProductDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final durationController = TextEditingController(text: '30');
    ProductCategory selectedCategory = ProductCategory.training;
    Currency selectedCurrency = Currency.eur;
    List<String> features = [];
    bool isPopular = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('createProduct'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'productName'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'price'.tr(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Currency>(
                      value: selectedCurrency,
                      decoration: InputDecoration(
                        labelText: 'currency'.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      items: Currency.values
                          .map((currency) => DropdownMenuItem(
                                value: currency,
                                child:
                                    Text('${currency.symbol} ${currency.code}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedCurrency = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'durationInDays'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ProductCategory>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ProductCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(_getCategoryDisplayName(category)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('popularProduct'.tr()),
                  value: isPopular,
                  onChanged: (value) {
                    setDialogState(() {
                      isPopular = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Sección de características
                Text(
                  'features'.tr(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...features.asMap().entries.map((entry) {
                  final index = entry.key;
                  final feature = entry.value;
                  final featureController =
                      TextEditingController(text: feature);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: featureController,
                            decoration: InputDecoration(
                              labelText: 'feature'.tr(),
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              features[index] = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            setDialogState(() {
                              features.removeAt(index);
                            });
                          },
                          icon:
                              const Icon(Icons.delete, color: AppColors.error),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setDialogState(() {
                      features.add('');
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: Text('addFeature'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  // Filtrar características vacías
                  final validFeatures =
                      features.where((f) => f.trim().isNotEmpty).toList();

                  final product = TrainerProduct(
                    id: 0, // Se asignará automáticamente
                    trainerId: widget.trainerId,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    currency: selectedCurrency,
                    durationInDays: int.tryParse(durationController.text) ?? 30,
                    category: selectedCategory,
                    features: validFeatures,
                    isPopular: isPopular,
                    status: ProductStatus.active,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  ref
                      .read(trainerProductsProvider.notifier)
                      .createProduct(product);
                  Navigator.pop(context);

                  print('[ProductsListPage] ✅ Producto creado exitosamente');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('productCreated'.tr())),
                  );
                }
              },
              child: Text('create'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryDisplayName(ProductCategory category) {
    switch (category) {
      case ProductCategory.training:
        return 'training'.tr();
      case ProductCategory.nutrition:
        return 'nutrition'.tr();
      case ProductCategory.supplements:
        return 'supplements'.tr();
      case ProductCategory.equipment:
        return 'equipment'.tr();
      case ProductCategory.consultation:
        return 'consultation'.tr();
      case ProductCategory.other:
        return 'other'.tr();
    }
  }

  void _editProduct(TrainerProduct product) {
    final nameController = TextEditingController(text: product.name);
    final descriptionController =
        TextEditingController(text: product.description);
    final priceController =
        TextEditingController(text: product.price.toString());
    final durationController =
        TextEditingController(text: product.durationInDays.toString());
    ProductCategory selectedCategory = product.category;
    Currency selectedCurrency = product.currency;
    List<String> features = List.from(product.features);
    bool isPopular = product.isPopular;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('editProduct'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'productName'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'price'.tr(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Currency>(
                      value: selectedCurrency,
                      decoration: InputDecoration(
                        labelText: 'currency'.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      items: Currency.values
                          .map((currency) => DropdownMenuItem(
                                value: currency,
                                child:
                                    Text('${currency.symbol} ${currency.code}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedCurrency = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'durationInDays'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ProductCategory>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ProductCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(_getCategoryDisplayName(category)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('popularProduct'.tr()),
                  value: isPopular,
                  onChanged: (value) {
                    setDialogState(() {
                      isPopular = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Sección de características
                Text(
                  'features'.tr(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...features.asMap().entries.map((entry) {
                  final index = entry.key;
                  final feature = entry.value;
                  final featureController =
                      TextEditingController(text: feature);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: featureController,
                            decoration: InputDecoration(
                              labelText: 'feature'.tr(),
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              features[index] = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            setDialogState(() {
                              features.removeAt(index);
                            });
                          },
                          icon:
                              const Icon(Icons.delete, color: AppColors.error),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setDialogState(() {
                      features.add('');
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: Text('addFeature'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  // Filtrar características vacías
                  final validFeatures =
                      features.where((f) => f.trim().isNotEmpty).toList();

                  final updatedProduct = product.copyWith(
                    name: nameController.text,
                    description: descriptionController.text,
                    price:
                        double.tryParse(priceController.text) ?? product.price,
                    currency: selectedCurrency,
                    durationInDays: int.tryParse(durationController.text) ??
                        product.durationInDays,
                    category: selectedCategory,
                    features: validFeatures,
                    isPopular: isPopular,
                    updatedAt: DateTime.now(),
                  );

                  ref
                      .read(trainerProductsProvider.notifier)
                      .updateProduct(updatedProduct);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('productUpdated'.tr())),
                  );
                }
              },
              child: Text('save'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleProductStatus(TrainerProduct product) {
    final newStatus = product.status == ProductStatus.active
        ? ProductStatus.inactive
        : ProductStatus.active;

    ref.read(trainerProductsProvider.notifier).toggleProductStatus(
          product.id,
          newStatus,
        );
  }

  void _deleteProduct(TrainerProduct product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteProduct'.tr()),
        content: Text('deleteProductConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(trainerProductsProvider.notifier)
                  .deleteProduct(product.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }

  void _insertSampleData() async {
    try {
      final seedManager = SeedDataManager(sl<AppDatabase>());
      await seedManager.insertSeedProductsForTrainer(widget.trainerId);

      // Recargar productos después de insertar datos de ejemplo
      ref.read(trainerProductsProvider.notifier).loadProducts(widget.trainerId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sample data inserted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inserting sample data: $e')),
      );
    }
  }
}
