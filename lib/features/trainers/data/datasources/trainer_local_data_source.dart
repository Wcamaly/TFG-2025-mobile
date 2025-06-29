import 'dart:convert';
import 'dart:math';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/users_table.dart';
import '../../../../core/database/tables/trainer_products_table.dart';
import '../../domain/entities/trainer.dart';

abstract class TrainerLocalDataSource {
  Future<List<Trainer>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  );

  Future<List<Trainer>> searchTrainers(String query);

  Future<Trainer?> getTrainerById(String id);

  Future<List<Trainer>> getRecommendedTrainers();
}

class TrainerLocalDataSourceImpl implements TrainerLocalDataSource {
  final AppDatabase database;

  TrainerLocalDataSourceImpl(this.database);

  @override
  Future<List<Trainer>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    // Obtener todos los entrenadores con ubicación
    final query = database.select(database.users)
      ..where((tbl) => tbl.role.equalsValue(UserRole.trainer))
      ..where((tbl) => tbl.latitude.isNotNull())
      ..where((tbl) => tbl.longitude.isNotNull());

    final trainers = await query.get();

    // Filtrar por distancia
    final nearbyTrainers = trainers.where((trainer) {
      if (trainer.latitude == null || trainer.longitude == null) return false;

      final distance = _calculateDistance(
        latitude,
        longitude,
        trainer.latitude!,
        trainer.longitude!,
      );

      return distance <= radiusKm;
    }).toList();

    // Convertir a entidades Trainer
    return await _convertToTrainerEntities(nearbyTrainers);
  }

  @override
  Future<List<Trainer>> searchTrainers(String query) async {
    if (query.isEmpty) {
      return getRecommendedTrainers();
    }

    // Obtener todos los entrenadores y filtrar en memoria
    final allTrainers = await (database.select(database.users)
          ..where((tbl) => tbl.role.equalsValue(UserRole.trainer)))
        .get();

    final filteredTrainers = allTrainers.where((trainer) {
      final fullName = '${trainer.firstName} ${trainer.lastName}'.toLowerCase();
      final specializations = trainer.specializations?.toLowerCase() ?? '';
      final city = trainer.city?.toLowerCase() ?? '';
      final searchQuery = query.toLowerCase();

      return fullName.contains(searchQuery) ||
          specializations.contains(searchQuery) ||
          city.contains(searchQuery);
    }).toList();

    return await _convertToTrainerEntities(filteredTrainers);
  }

  @override
  Future<Trainer?> getTrainerById(String id) async {
    final trainerId = int.tryParse(id);
    if (trainerId == null) return null;

    final trainer = await (database.select(database.users)
          ..where((tbl) => tbl.id.equals(trainerId))
          ..where((tbl) => tbl.role.equalsValue(UserRole.trainer)))
        .getSingleOrNull();

    if (trainer == null) return null;

    final trainers = await _convertToTrainerEntities([trainer]);
    return trainers.isNotEmpty ? trainers.first : null;
  }

  @override
  Future<List<Trainer>> getRecommendedTrainers() async {
    // Obtener entrenadores ordenados por experiencia
    final query = database.select(database.users)
      ..where((tbl) => tbl.role.equalsValue(UserRole.trainer))
      ..limit(10);

    final trainers = await query.get();

    // Ordenar por experiencia en memoria
    trainers.sort(
        (a, b) => (b.yearsExperience ?? 0).compareTo(a.yearsExperience ?? 0));

    return await _convertToTrainerEntities(trainers);
  }

  Future<List<Trainer>> _convertToTrainerEntities(
      List<DbUser> dbTrainers) async {
    final trainers = <Trainer>[];

    for (final dbTrainer in dbTrainers) {
      // Obtener productos del entrenador
      final products = await database.getProductsByTrainer(dbTrainer.id);

      // Convertir productos a TrainerPackage
      final packages = products
          .map((product) => TrainerPackage(
                id: product.id.toString(),
                name: product.name,
                description: product.description,
                price: product.price,
                durationInDays: product.durationInDays,
                features: _parseFeatures(product.features),
                isPopular: product.isPopular,
              ))
          .toList();

      // Si no hay productos, crear algunos por defecto
      if (packages.isEmpty) {
        packages.addAll(_createDefaultPackages(dbTrainer));
      }

      final trainer = Trainer(
        id: dbTrainer.id.toString(),
        name: '${dbTrainer.firstName} ${dbTrainer.lastName}',
        profileImageUrl: dbTrainer.profileImageUrl ?? '',
        specialization: dbTrainer.specializations ?? 'Personal Trainer',
        yearsOfExperience: dbTrainer.yearsExperience ?? 0,
        rating: 4.5, // Rating por defecto
        reviewCount: 0,
        certifications: _parseCertifications(dbTrainer.certifications),
        languages: ['EN', 'ES'], // Idiomas por defecto
        location: dbTrainer.city ?? 'Ubicación no disponible',
        latitude: dbTrainer.latitude ?? 0.0,
        longitude: dbTrainer.longitude ?? 0.0,
        isAvailable: dbTrainer.isActive,
        packages: packages,
        description: dbTrainer.bio ??
            'Entrenador personal certificado con experiencia en fitness y bienestar.',
      );

      trainers.add(trainer);
    }

    return trainers;
  }

  List<String> _parseFeatures(String featuresJson) {
    try {
      final List<dynamic> features = jsonDecode(featuresJson);
      return features.map((f) => f.toString()).toList();
    } catch (e) {
      return ['Entrenamiento personalizado', 'Seguimiento de progreso'];
    }
  }

  List<String> _parseCertifications(String? certifications) {
    if (certifications == null || certifications.isEmpty) {
      return ['Certificación Personal Trainer'];
    }
    return certifications.split(',').map((c) => c.trim()).toList();
  }

  List<TrainerPackage> _createDefaultPackages(DbUser trainer) {
    return [
      TrainerPackage(
        id: 'default_1',
        name: 'Plan Básico',
        description: 'Entrenamiento personal básico con seguimiento semanal',
        price: 80.0,
        durationInDays: 30,
        features: [
          'Entrenamiento personalizado',
          'Seguimiento semanal',
          'Plan de ejercicios',
          'Consultas por chat'
        ],
      ),
      TrainerPackage(
        id: 'default_2',
        name: 'Plan Premium',
        description:
            'Entrenamiento completo con nutrición y seguimiento diario',
        price: 150.0,
        durationInDays: 30,
        features: [
          'Entrenamiento personalizado',
          'Plan nutricional',
          'Seguimiento diario',
          'Consultas ilimitadas',
          'Análisis de progreso'
        ],
        isPopular: true,
      ),
    ];
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Radio de la Tierra en km

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        sin(_degreesToRadians(lat1)) *
            sin(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
