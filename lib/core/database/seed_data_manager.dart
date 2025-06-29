import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'app_database.dart';
import 'tables/users_table.dart';
import 'tables/students_table.dart';
import 'tables/routines_table.dart';
import 'tables/trainer_products_table.dart';

class SeedDataManager {
  final AppDatabase _database;
  Map<int, int> _userIdMapping = {}; // JSON ID -> Real DB ID

  SeedDataManager(this._database);

  /// Método principal para resetear y cargar datos completos
  Future<void> resetDatabaseForTrainer(int? requestedTrainerId) async {
    print('🔄 Resetting database...');

    // 1. Limpiar todas las tablas
    await _clearAllTables();

    // 2. Resetear auto-increment counters
    await _resetAutoIncrementCounters();

    // 3. Insertar usuarios y obtener el ID real del entrenador
    final realTrainerId = await _insertUsersAndGetTrainerId();
    print('👨‍💼 Real trainer ID after insertion: $realTrainerId');

    // 4. Insertar rutinas para el entrenador
    await insertSeedRoutinesForTrainer(realTrainerId);

    // 5. Insertar estudiantes para el entrenador
    await insertSeedStudentsForTrainer(realTrainerId);

    // 6. Insertar productos para el entrenador
    await insertSeedProductsForTrainer(realTrainerId);

    print('✅ Database reset complete for trainer $realTrainerId');
  }

  /// Borrar archivo físico de la base de datos
  Future<void> _deleteDatabaseFile() async {
    try {
      print('🔍 Attempting to delete database file...');
      final dbFolder = await getApplicationDocumentsDirectory();
      print('📁 Database folder: ${dbFolder.path}');

      // Intentar varios nombres posibles del archivo de base de datos
      final possibleNames = [
        'app_database.db',
        'app_database.sqlite',
        'tfg_2025_mobile.sqlite',
        'database.sqlite',
        'app.db',
        'database.db'
      ];

      bool deleted = false;
      for (final name in possibleNames) {
        final dbFile = File(path.join(dbFolder.path, name));
        if (await dbFile.exists()) {
          await dbFile.delete();
          print('🗑️ Database file deleted: $name');
          deleted = true;
        }
      }

      if (!deleted) {
        print('⚠️ No database file found to delete');
        // Listar archivos en el directorio para ver qué hay
        final files = await dbFolder.list().toList();
        print('📋 Files in documents directory:');
        for (final file in files) {
          print('   - ${path.basename(file.path)}');
        }
      }
    } catch (e) {
      print('⚠️ Could not delete database file: $e');
    }
  }

  /// Limpiar todas las tablas
  Future<void> _clearAllTables() async {
    await _database.customStatement('DELETE FROM student_routines');
    await _database.customStatement('DELETE FROM routines');
    await _database.customStatement('DELETE FROM payments');
    await _database.customStatement('DELETE FROM students');
    await _database.customStatement('DELETE FROM trainer_products');
    await _database.customStatement('DELETE FROM users');
    print('🗑️ All tables cleared');
  }

  /// Resetear contadores auto-increment
  Future<void> _resetAutoIncrementCounters() async {
    await _database.customStatement(
        "DELETE FROM sqlite_sequence WHERE name IN ('users', 'students', 'routines', 'payments', 'student_routines', 'trainer_products')");
    print('🔄 Auto-increment counters reset');
  }

  /// Insertar solo un usuario básico para login
  Future<void> insertBasicUser() async {
    final userCount = await (_database.selectOnly(_database.users)
          ..addColumns([_database.users.id.count()]))
        .getSingle();

    if (userCount.read(_database.users.id.count()) == 0) {
      await _insertBasicTrainer();
    }
  }

  /// Insertar usuario básico de entrenador
  Future<void> _insertBasicTrainer() async {
    final basicUser = UsersCompanion.insert(
      email: 'entrenador@demo.com',
      password: _hashPassword('123456'),
      firstName: 'Carlos',
      lastName: 'Mendoza Silva',
      role: UserRole.trainer,
    );
    await _database.into(_database.users).insert(basicUser);
    print('👨‍💼 Basic trainer created');
  }

  /// Insertar usuarios desde JSON y devolver ID del entrenador
  Future<int> _insertUsersAndGetTrainerId() async {
    try {
      final seedData = await _loadSeedData();
      int? trainerId;
      _userIdMapping.clear();

      if (seedData['users'] != null) {
        int jsonUserId = 1;
        for (final userData in seedData['users']) {
          final user = UsersCompanion.insert(
            email: userData['email'],
            password: _hashPassword(userData['password']),
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            phone: Value(userData['phone']),
            address: Value(userData['address']),
            city: Value(userData['city']),
            latitude: Value(userData['latitude']?.toDouble()),
            longitude: Value(userData['longitude']?.toDouble()),
            age: Value(userData['age']),
            gender: Value(userData['gender']),
            height: Value(userData['height']?.toDouble()),
            weight: Value(userData['weight']?.toDouble()),
            specializations: Value(userData['specializations']),
            hourlyRate: Value(userData['hourlyRate']?.toDouble()),
            certifications: Value(userData['certifications']),
            yearsExperience: Value(userData['yearsExperience']),
            fitnessLevel: Value(userData['fitnessLevel']),
            bio: Value(userData['bio']),
            role: userData['role'] == 'trainer'
                ? UserRole.trainer
                : UserRole.user,
          );

          final insertedId = await _database.into(_database.users).insert(user);
          _userIdMapping[jsonUserId] = insertedId;

          print(
              '👤 User: ${userData['firstName']} ${userData['lastName']} - JSON ID: $jsonUserId → Real ID: $insertedId');

          if (userData['role'] == 'trainer') {
            trainerId = insertedId;
            print('👨‍💼 Trainer ID captured: $trainerId');
          }

          jsonUserId++;
        }
      }

      if (trainerId == null) {
        throw Exception('No trainer found in seed data');
      }

      print('✅ Users loaded successfully. Trainer ID: $trainerId');
      print('📋 User ID mapping: $_userIdMapping');
      return trainerId;
    } catch (e) {
      print('❌ Error loading users: $e');
      return await _insertBasicTrainerAndGetId();
    }
  }

  /// Fallback para insertar entrenador básico
  Future<int> _insertBasicTrainerAndGetId() async {
    final basicUser = UsersCompanion.insert(
      email: 'entrenador@demo.com',
      password: _hashPassword('123456'),
      firstName: 'Carlos',
      lastName: 'Mendoza Silva',
      role: UserRole.trainer,
    );
    final trainerId = await _database.into(_database.users).insert(basicUser);
    print('👨‍💼 Basic trainer created with ID: $trainerId');
    return trainerId;
  }

  /// Insertar rutinas para un entrenador específico
  Future<void> insertSeedRoutinesForTrainer(int trainerId) async {
    print('📝 Inserting seed routines for trainer $trainerId');

    // Verificar si ya existen rutinas
    final existingRoutines = await _database.getRoutinesByCreator(trainerId);
    if (existingRoutines.isNotEmpty) {
      print('✅ Trainer already has ${existingRoutines.length} routines');
      return;
    }

    try {
      final seedData = await _loadSeedData();
      final List<dynamic> routinesData = seedData['routines'] ?? [];
      print('📋 Found ${routinesData.length} routines in seed data');

      for (final routineData in routinesData) {
        final routine = RoutinesCompanion.insert(
          name: routineData['name'] as String,
          description: routineData['description'] as String,
          category: routineData['category'] as String,
          durationMinutes: routineData['duration'] as int,
          difficulty: DifficultyLevel.values.firstWhere(
            (e) => e.name == routineData['difficulty'],
            orElse: () => DifficultyLevel.beginner,
          ),
          exercisesJson: routineData['exercises'] as String,
          createdBy: trainerId, // ✅ Usar el ID dinámico del entrenador
          status: RoutineStatus.active,
        );
        await _database.insertRoutine(routine);
      }

      print(
          '✅ Inserted ${routinesData.length} seed routines for trainer $trainerId');
    } catch (e) {
      print('❌ Error inserting seed routines: $e');
      rethrow;
    }
  }

  /// Insertar estudiantes para un entrenador específico
  Future<void> insertSeedStudentsForTrainer(int trainerId) async {
    print('📝 Inserting seed students for trainer $trainerId');

    // Verificar si ya existen estudiantes
    final existingStudents = await _database.getStudentsByTrainer(trainerId);
    if (existingStudents.isNotEmpty) {
      print('✅ Trainer already has ${existingStudents.length} students');
      return;
    }

    try {
      final seedData = await _loadSeedData();
      final List<dynamic> studentsData = seedData['students'] ?? [];
      final List<dynamic> usersData = seedData['users'] ?? [];

      print('📋 Found ${studentsData.length} students in seed data');
      print('📋 Using user ID mapping: $_userIdMapping');

      int createdCount = 0;
      for (final studentData in studentsData) {
        // Usar userIndex en lugar de userId hardcodeado
        final userIndex = studentData['userIndex'] as int;
        final studentName =
            '${studentData['firstName']} ${studentData['lastName']}';

        print('🔍 Processing student: $studentName (userIndex: $userIndex)');

        // El userIndex se refiere al índice en el array de usuarios (base 0)
        // Pero nuestro mapeo usa IDs desde 1, así que sumamos 1
        final jsonUserId = userIndex + 1;
        final realUserId = _userIdMapping[jsonUserId];

        print(
            '🔍 userIndex: $userIndex → jsonUserId: $jsonUserId → realUserId: $realUserId');

        if (realUserId == null) {
          print(
              '⚠️ No mapping found for user index $userIndex (JSON ID $jsonUserId), skipping student $studentName');
          continue;
        }

        // Verificar que el usuario existe
        final existingUser = await (_database.select(_database.users)
              ..where((u) => u.id.equals(realUserId)))
            .getSingleOrNull();

        if (existingUser == null) {
          print(
              '⚠️ User with real ID $realUserId not found, skipping student $studentName');
          continue;
        }

        print(
            '✅ Found user: ${existingUser.firstName} ${existingUser.lastName} (ID: ${existingUser.id})');

        // Crear estudiante usando IDs dinámicos
        final now = DateTime.now();
        final totalClasses = studentData['totalClasses'] as int;
        final completedClasses = studentData['completedClasses'] as int? ?? 0;
        final remainingClasses = totalClasses - completedClasses;

        final student = StudentsCompanion.insert(
          userId: realUserId,
          trainerId: trainerId,
          status: StudentStatus.active,
          subscriptionType: SubscriptionType.premium,
          subscriptionStartDate: now,
          subscriptionEndDate: now.add(const Duration(days: 30)),
          remainingClasses: Value(remainingClasses),
          totalClasses: Value(totalClasses),
          monthlyFee: (studentData['monthlyFee'] as num).toDouble(),
          lastPaymentDate: Value(now.subtract(const Duration(days: 7))),
          nextPaymentDate: now.add(const Duration(days: 23)),
          progressPercentage:
              Value((studentData['progressPercentage'] as num).toDouble()),
          notes: Value(studentData['notes'] as String?),
        );

        final studentId = await _database.insertStudent(student);
        createdCount++;

        print(
            '✅ Created student $studentId for user $realUserId ($studentName)');
      }

      print(
          '✅ Successfully created $createdCount students for trainer $trainerId');

      // Crear rutinas del JSON y asignarlas a los estudiantes
      await _createRoutinesFromJsonAndAssignments(trainerId);
    } catch (e) {
      print('❌ Error inserting seed students: $e');
      rethrow;
    }
  }

  Future<void> _createRoutinesFromJsonAndAssignments(int trainerId) async {
    print(
        '📝 Creating routines from JSON and assignments for trainer $trainerId');

    try {
      final seedData = await _loadSeedData();
      final List<dynamic> routinesData = seedData['routines'] ?? [];
      final List<dynamic> studentRoutinesData =
          seedData['studentRoutines'] ?? [];

      // Crear rutinas del JSON
      final createdRoutines = <int>[];
      for (final routineData in routinesData) {
        final routine = RoutinesCompanion.insert(
          name: routineData['name'] as String,
          description: routineData['description'] as String,
          category: routineData['category'] as String,
          durationMinutes: routineData['duration'] as int,
          difficulty:
              _mapDifficultyFromString(routineData['difficulty'] as String),
          exerciseCount: const Value(3), // Basado en los ejercicios del JSON
          createdBy: trainerId,
          status: RoutineStatus.active,
          exercisesJson: routineData['exercises'] as String,
        );

        final routineId = await _database.insertRoutine(routine);
        createdRoutines.add(routineId);
        print('✅ Created routine $routineId: ${routineData['name']}');
      }

      // Obtener estudiantes del entrenador
      final students = await _database.getStudentsByTrainer(trainerId);
      if (students.isEmpty) {
        print('⚠️ No students found for trainer $trainerId');
        return;
      }

      // Asignar rutinas basadas en el JSON
      for (final studentRoutineData in studentRoutinesData) {
        final studentIndex = studentRoutineData['studentIndex'] as int;
        final routineIndex = studentRoutineData['routineIndex'] as int;

        // Verificar que los índices son válidos
        if (studentIndex >= students.length ||
            routineIndex >= createdRoutines.length) {
          print(
              '⚠️ Invalid index: studentIndex=$studentIndex, routineIndex=$routineIndex');
          continue;
        }

        final student = students[studentIndex];
        final routineId = createdRoutines[routineIndex];

        // Parsear fecha de asignación original
        final assignedAt =
            DateTime.parse(studentRoutineData['assignedAt'] as String);
        final today = DateTime.now();

        // Asignar rutinas para hoy y próximos días
        // Para el primer estudiante: rutina para hoy
        // Para el segundo estudiante: rutina para mañana
        // Para el tercer estudiante: rutina para pasado mañana
        final scheduledDate = today.add(Duration(days: studentIndex % 3));

        final assignment = StudentRoutinesCompanion.insert(
          studentId: student.id,
          routineId: routineId,
          trainerId: trainerId,
          assignedDate: today, // Fecha de asignación real
          scheduledDate: scheduledDate,
          status: _mapStatusFromString(studentRoutineData['status'] as String),
          progressPercentage:
              Value((studentRoutineData['progress'] as num).toDouble()),
          completedSessions: Value(0),
          totalSessions: const Value(1),
          notes: Value(studentRoutineData['notes'] as String?),
        );

        await _database.insertStudentRoutine(assignment);
        print(
            '✅ Assigned routine $routineId to student ${student.id} for ${scheduledDate.toIso8601String().split('T')[0]}');
      }

      // Asignar rutinas adicionales para hoy para asegurar que haya contenido
      final today = DateTime.now();
      for (int i = 0; i < students.length && i < createdRoutines.length; i++) {
        final student = students[i];
        final routineId = createdRoutines[i];

        // Asignar una rutina adicional para hoy
        final additionalAssignment = StudentRoutinesCompanion.insert(
          studentId: student.id,
          routineId: routineId,
          trainerId: trainerId,
          assignedDate: today,
          scheduledDate: today,
          status: RoutineStatus.active,
          progressPercentage: const Value(0.0),
          completedSessions: const Value(0),
          totalSessions: const Value(1),
          notes: const Value('Rutina asignada para hoy'),
        );

        await _database.insertStudentRoutine(additionalAssignment);
        print(
            '✅ Additional routine $routineId assigned to student ${student.id} for today');
      }

      print(
          '✅ Successfully created and assigned routines from JSON for trainer $trainerId');
    } catch (e) {
      print('❌ Error creating routines from JSON: $e');
      rethrow;
    }
  }

  DifficultyLevel _mapDifficultyFromString(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return DifficultyLevel.beginner;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      default:
        return DifficultyLevel.beginner;
    }
  }

  RoutineStatus _mapStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return RoutineStatus.active;
      case 'completed':
        return RoutineStatus.completed;
      case 'paused':
        return RoutineStatus.paused;
      case 'cancelled':
        return RoutineStatus.cancelled;
      default:
        return RoutineStatus.active;
    }
  }

  /// Método para insertar datos de prueba de estadísticas para un usuario
  Future<void> insertSampleStatsForUser(int userId) async {
    try {
      await _database.insertSampleStats(userId);
      print('✅ Sample stats inserted for user $userId');
    } catch (e) {
      print('❌ Error inserting sample stats for user $userId: $e');
    }
  }

  /// Cargar datos desde JSON
  Future<Map<String, dynamic>> _loadSeedData() async {
    final String jsonString =
        await rootBundle.loadString('assets/seed_data.json');
    return json.decode(jsonString);
  }

  /// Hash de contraseña
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Insertar productos de ejemplo para un entrenador específico
  Future<void> insertSeedProductsForTrainer(int trainerId) async {
    print('📝 Inserting seed products for trainer $trainerId');

    // Verificar si ya existen productos
    final existingProducts = await _database.getProductsByTrainer(trainerId);
    if (existingProducts.isNotEmpty) {
      print('✅ Trainer already has ${existingProducts.length} products');
      return;
    }

    try {
      final seedData = await _loadSeedData();
      final trainerProducts = seedData['trainerProducts'] as List<dynamic>?;

      if (trainerProducts == null) {
        print('⚠️ No trainer products found in seed data');
        return;
      }

      // Filtrar productos para este entrenador específico
      final productsForTrainer = trainerProducts
          .where((product) => product['trainerId'] == trainerId)
          .toList();

      if (productsForTrainer.isEmpty) {
        print('⚠️ No products found for trainer $trainerId in seed data');
        return;
      }

      int createdCount = 0;
      for (final productData in productsForTrainer) {
        final product = TrainerProductsCompanion.insert(
          trainerId: trainerId,
          name: productData['name'] as String,
          description: productData['description'] as String,
          price: (productData['price'] as num).toDouble(),
          currency: Value(
              _parseCurrencyFromString(productData['currency'] as String)),
          durationInDays: Value(productData['durationInDays'] as int),
          category: _parseCategoryFromString(productData['category'] as String),
          features: jsonEncode(productData['features'] as List<dynamic>),
          isPopular: Value(productData['isPopular'] as bool),
          status: _parseStatusFromString(productData['status'] as String),
          imageUrl: const Value(null),
        );
        final productId = await _database.insertTrainerProduct(product);
        print('✅ Producto insertado: ${productData['name']} (ID: $productId)');
        createdCount++;
      }
      final count = (await _database.getProductsByTrainer(trainerId)).length;
      print('🔎 Total productos en DB para trainer $trainerId: $count');
    } catch (e) {
      print('❌ Error inserting seed products: $e');
      rethrow;
    }
  }

  /// Parsear Currency desde string
  Currency _parseCurrencyFromString(String currencyStr) {
    switch (currencyStr.toLowerCase()) {
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

  /// Parsear ProductCategory desde string
  ProductCategory _parseCategoryFromString(String categoryStr) {
    switch (categoryStr.toLowerCase()) {
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

  /// Parsear ProductStatus desde string
  ProductStatus _parseStatusFromString(String statusStr) {
    switch (statusStr.toLowerCase()) {
      case 'active':
        return ProductStatus.active;
      case 'inactive':
        return ProductStatus.inactive;
      case 'draft':
        return ProductStatus.draft;
      default:
        return ProductStatus.active;
    }
  }

  /// Insertar usuarios de ejemplo (entrenadores y estudiantes)
  Future<void> insertSampleUsers() async {
    print('👥 Inserting sample users (trainers and students)...');

    // Verificar si ya existen usuarios
    final existingUsers = await _database.getAllUsers();
    if (existingUsers.length > 6) {
      // Más de 6 usuarios (1 básico + 5 entrenadores + estudiantes)
      print('✅ Already have ${existingUsers.length} users');
      return;
    }

    try {
      // ========== ENTRENADORES ==========
      final trainers = [
        {
          'email': 'carlos.mendoza@demo.com',
          'password': '123456',
          'firstName': 'Carlos',
          'lastName': 'Mendoza Silva',
          'phone': '+34 600 123 456',
          'address': 'Calle Gran Vía 28',
          'city': 'Madrid',
          'latitude': 40.4168,
          'longitude': -3.7038,
          'age': 32,
          'gender': 'male',
          'height': 175.0,
          'weight': 75.0,
          'specializations': 'CrossFit, HIIT, Fuerza',
          'hourlyRate': 50.0,
          'certifications': 'CrossFit Level 2, NASM CPT, FMS Level 1',
          'yearsExperience': 8,
          'fitnessLevel': 'advanced',
          'bio':
              'Entrenador personal certificado especializado en CrossFit y entrenamiento funcional. Más de 8 años de experiencia ayudando a personas a alcanzar sus objetivos fitness.',
          'role': 'trainer',
        },
        {
          'email': 'ana.garcia@demo.com',
          'password': '123456',
          'firstName': 'Ana',
          'lastName': 'García López',
          'phone': '+34 600 234 567',
          'address': 'Calle Princesa 15',
          'city': 'Madrid',
          'latitude': 40.4258,
          'longitude': -3.7148,
          'age': 28,
          'gender': 'female',
          'height': 165.0,
          'weight': 58.0,
          'specializations': 'Yoga, Pilates, Mindfulness',
          'hourlyRate': 45.0,
          'certifications': 'RYT-500, Pilates Mat, Mindfulness Teacher',
          'yearsExperience': 6,
          'fitnessLevel': 'intermediate',
          'bio':
              'Instructora de yoga y pilates certificada. Especializada en yoga vinyasa y mindfulness. Ayudo a mis clientes a encontrar equilibrio físico y mental.',
          'role': 'trainer',
        },
        {
          'email': 'miguel.rodriguez@demo.com',
          'password': '123456',
          'firstName': 'Miguel',
          'lastName': 'Rodríguez Torres',
          'phone': '+34 600 345 678',
          'address': 'Calle Alcalá 120',
          'city': 'Madrid',
          'latitude': 40.4158,
          'longitude': -3.6938,
          'age': 35,
          'gender': 'male',
          'height': 180.0,
          'weight': 80.0,
          'specializations': 'Culturismo, Powerlifting, Nutrición',
          'hourlyRate': 60.0,
          'certifications':
              'ACE Personal Trainer, Precision Nutrition, Powerlifting Coach',
          'yearsExperience': 10,
          'fitnessLevel': 'advanced',
          'bio':
              'Entrenador especializado en culturismo y powerlifting. Más de 10 años de experiencia en el mundo del fitness. También asesoro en nutrición deportiva.',
          'role': 'trainer',
        },
        {
          'email': 'lucia.martinez@demo.com',
          'password': '123456',
          'firstName': 'Lucía',
          'lastName': 'Martínez Vega',
          'phone': '+34 600 456 789',
          'address': 'Calle Serrano 45',
          'city': 'Madrid',
          'latitude': 40.4358,
          'longitude': -3.6838,
          'age': 26,
          'gender': 'female',
          'height': 168.0,
          'weight': 62.0,
          'specializations': 'Danza Fitness, Zumba, Cardio',
          'hourlyRate': 40.0,
          'certifications':
              'Zumba Instructor, Dance Fitness, Cardio Kickboxing',
          'yearsExperience': 4,
          'fitnessLevel': 'intermediate',
          'bio':
              'Instructora de danza fitness y zumba. Me apasiona hacer que el ejercicio sea divertido y energético. Especializada en clases grupales dinámicas.',
          'role': 'trainer',
        },
        {
          'email': 'david.sanchez@demo.com',
          'password': '123456',
          'firstName': 'David',
          'lastName': 'Sánchez Ruiz',
          'phone': '+34 600 567 890',
          'address': 'Calle Mayor 80',
          'city': 'Madrid',
          'latitude': 40.4058,
          'longitude': -3.7138,
          'age': 30,
          'gender': 'male',
          'height': 178.0,
          'weight': 78.0,
          'specializations': 'Funcional, Calistenia, Movilidad',
          'hourlyRate': 55.0,
          'certifications':
              'Functional Training Specialist, Calisthenics Coach, Mobility Expert',
          'yearsExperience': 7,
          'fitnessLevel': 'advanced',
          'bio':
              'Entrenador funcional especializado en calistenia y movilidad. Ayudo a mis clientes a desarrollar fuerza funcional y movilidad natural.',
          'role': 'trainer',
        },
      ];

      // ========== ESTUDIANTES ==========
      final students = [
        {
          'email': 'maria.lopez@demo.com',
          'password': '123456',
          'firstName': 'María',
          'lastName': 'López García',
          'phone': '+34 600 111 111',
          'address': 'Calle de la Princesa 25',
          'city': 'Madrid',
          'latitude': 40.4268,
          'longitude': -3.7048,
          'age': 25,
          'gender': 'female',
          'height': 165.0,
          'weight': 60.0,
          'fitnessLevel': 'beginner',
          'bio':
              'Estudiante de marketing que quiere ponerse en forma. Me gusta el yoga y el entrenamiento funcional.',
          'role': 'user',
        },
        {
          'email': 'juan.perez@demo.com',
          'password': '123456',
          'firstName': 'Juan',
          'lastName': 'Pérez Martínez',
          'phone': '+34 600 222 222',
          'address': 'Calle Alcalá 150',
          'city': 'Madrid',
          'latitude': 40.4168,
          'longitude': -3.6948,
          'age': 28,
          'gender': 'male',
          'height': 175.0,
          'weight': 70.0,
          'fitnessLevel': 'intermediate',
          'bio':
              'Desarrollador de software que busca mejorar su condición física. Interesado en CrossFit y entrenamiento de fuerza.',
          'role': 'user',
        },
        {
          'email': 'carmen.ruiz@demo.com',
          'password': '123456',
          'firstName': 'Carmen',
          'lastName': 'Ruiz Fernández',
          'phone': '+34 600 333 333',
          'address': 'Calle Serrano 60',
          'city': 'Madrid',
          'latitude': 40.4368,
          'longitude': -3.6848,
          'age': 35,
          'gender': 'female',
          'height': 160.0,
          'weight': 55.0,
          'fitnessLevel': 'advanced',
          'bio':
              'Profesora de educación física que mantiene su forma con entrenamiento regular. Me gusta el pilates y el yoga.',
          'role': 'user',
        },
        {
          'email': 'pedro.gomez@demo.com',
          'password': '123456',
          'firstName': 'Pedro',
          'lastName': 'Gómez Sánchez',
          'phone': '+34 600 444 444',
          'address': 'Calle Mayor 100',
          'city': 'Madrid',
          'latitude': 40.4068,
          'longitude': -3.7148,
          'age': 42,
          'gender': 'male',
          'height': 180.0,
          'weight': 85.0,
          'fitnessLevel': 'beginner',
          'bio':
              'Abogado que quiere perder peso y mejorar su salud. Busco un entrenamiento personalizado y motivador.',
          'role': 'user',
        },
        {
          'email': 'laura.moreno@demo.com',
          'password': '123456',
          'firstName': 'Laura',
          'lastName': 'Moreno Jiménez',
          'phone': '+34 600 555 555',
          'address': 'Calle Gran Vía 50',
          'city': 'Madrid',
          'latitude': 40.4178,
          'longitude': -3.7048,
          'age': 29,
          'gender': 'female',
          'height': 168.0,
          'weight': 58.0,
          'fitnessLevel': 'intermediate',
          'bio':
              'Diseñadora gráfica que busca tonificar y mejorar su resistencia. Me interesa el entrenamiento funcional y el cardio.',
          'role': 'user',
        },
      ];

      // Crear entrenadores
      final trainerIds = <int>[];
      for (final trainerData in trainers) {
        final trainer = UsersCompanion.insert(
          email: trainerData['email'] as String,
          password: _hashPassword(trainerData['password'] as String),
          firstName: trainerData['firstName'] as String,
          lastName: trainerData['lastName'] as String,
          phone: Value(trainerData['phone'] as String),
          address: Value(trainerData['address'] as String),
          city: Value(trainerData['city'] as String),
          latitude: Value((trainerData['latitude'] as num).toDouble()),
          longitude: Value((trainerData['longitude'] as num).toDouble()),
          age: Value(trainerData['age'] as int),
          gender: Value(trainerData['gender'] as String),
          height: Value((trainerData['height'] as num).toDouble()),
          weight: Value((trainerData['weight'] as num).toDouble()),
          specializations: Value(trainerData['specializations'] as String),
          hourlyRate: Value((trainerData['hourlyRate'] as num).toDouble()),
          certifications: Value(trainerData['certifications'] as String),
          yearsExperience: Value(trainerData['yearsExperience'] as int),
          fitnessLevel: Value(trainerData['fitnessLevel'] as String),
          bio: Value(trainerData['bio'] as String),
          role: UserRole.trainer,
        );

        final trainerId = await _database.insertUser(trainer);
        trainerIds.add(trainerId);
        print(
            '✅ Created trainer $trainerId: ${trainerData['firstName']} ${trainerData['lastName']}');

        // Insertar productos para este entrenador
        await insertSeedProductsForTrainer(trainerId);
      }

      // Crear estudiantes
      for (int i = 0; i < students.length; i++) {
        final studentData = students[i];
        final student = UsersCompanion.insert(
          email: studentData['email'] as String,
          password: _hashPassword(studentData['password'] as String),
          firstName: studentData['firstName'] as String,
          lastName: studentData['lastName'] as String,
          phone: Value(studentData['phone'] as String),
          address: Value(studentData['address'] as String),
          city: Value(studentData['city'] as String),
          latitude: Value((studentData['latitude'] as num).toDouble()),
          longitude: Value((studentData['longitude'] as num).toDouble()),
          age: Value(studentData['age'] as int),
          gender: Value(studentData['gender'] as String),
          height: Value((studentData['height'] as num).toDouble()),
          weight: Value((studentData['weight'] as num).toDouble()),
          fitnessLevel: Value(studentData['fitnessLevel'] as String),
          bio: Value(studentData['bio'] as String),
          role: UserRole.user,
        );

        final studentId = await _database.insertUser(student);
        print(
            '✅ Created student $studentId: ${studentData['firstName']} ${studentData['lastName']}');

        // Asignar estudiante a un entrenador (rotando entre los entrenadores disponibles)
        final trainerId = trainerIds[i % trainerIds.length];
        final now = DateTime.now();

        final studentRecord = StudentsCompanion.insert(
          userId: studentId,
          trainerId: trainerId,
          status: StudentStatus.active,
          subscriptionType: SubscriptionType.premium,
          subscriptionStartDate: now,
          subscriptionEndDate: now.add(const Duration(days: 30)),
          remainingClasses: const Value(10),
          totalClasses: const Value(12),
          monthlyFee: 80.0,
          lastPaymentDate: Value(now.subtract(const Duration(days: 7))),
          nextPaymentDate: now.add(const Duration(days: 23)),
          progressPercentage: const Value(0.0),
          notes: const Value('Estudiante de ejemplo'),
        );

        final studentRecordId = await _database.insertStudent(studentRecord);
        print(
            '✅ Created student record $studentRecordId for student $studentId assigned to trainer $trainerId');
      }

      print(
          '✅ Successfully created ${trainers.length} trainers and ${students.length} students');
    } catch (e) {
      print('❌ Error inserting sample users: $e');
      rethrow;
    }
  }

  /// Método para forzar recreación completa de la base de datos (solo usar en casos extremos)
  Future<void> forceRecreateDatabase() async {
    print('🔄 Force recreating database...');

    try {
      await _database.close();
      print('🔒 Database connection closed');
    } catch (e) {
      print('⚠️ Error closing database: $e');
    }

    await _deleteDatabaseFile();
    print('⚠️ Database file deleted. App needs restart to recreate database.');
  }
}
