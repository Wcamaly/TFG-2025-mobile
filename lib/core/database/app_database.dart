import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'tables/users_table.dart';
import 'tables/students_table.dart';
import 'tables/payments_table.dart';
import 'tables/routines_table.dart';
import 'tables/user_stats_table.dart';
import 'tables/workout_sessions_table.dart';
import 'tables/trainer_products_table.dart';
import 'seed_data_manager.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Users,
  Students,
  Payments,
  Routines,
  StudentRoutines,
  UserStats,
  DailyProgress,
  WorkoutSessions,
  ExerciseSessions,
  ExerciseSets,
  TrainerProducts,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Instancia del manager de seed data
  late final SeedDataManager _seedDataManager = SeedDataManager(this);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Solo insertar un usuario básico para poder hacer login
          await _seedDataManager.insertBasicUser();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.drop(users);
            await m.createTable(users);
            // Solo insertar un usuario básico para poder hacer login
            await _seedDataManager.insertBasicUser();
          }
          if (from < 3) {
            await m.createTable(students);
            await m.createTable(payments);
            await m.createTable(routines);
            await m.createTable(studentRoutines);
          }
          if (from < 4) {
            // Migración para asegurar que la tabla student_routines tenga todas las columnas necesarias
            await _migrateStudentRoutinesTable(m);
          }
          if (from < 5) {
            // Agregar tablas de estadísticas del usuario
            await m.createTable(userStats);
            await m.createTable(dailyProgress);
          }
          if (from < 6) {
            // Agregar tablas de sesiones de entrenamiento
            await m.createTable(workoutSessions);
            await m.createTable(exerciseSessions);
            await m.createTable(exerciseSets);
          }
          if (from < 7) {
            // Agregar tabla de productos de entrenadores
            await m.createTable(trainerProducts);
          }
        },
      );

  // Método auxiliar para migrar la tabla student_routines
  Future<void> _migrateStudentRoutinesTable(Migrator m) async {
    try {
      // Verificar si la columna scheduled_date existe
      final existingColumns = await customSelect(
        'PRAGMA table_info(student_routines)',
      ).get();

      final hasScheduledDate = existingColumns.any(
        (row) => row.data['name'] == 'scheduled_date',
      );

      if (!hasScheduledDate) {
        // Recrear la tabla con la estructura completa
        await customStatement('DROP TABLE IF EXISTS student_routines_old');
        await customStatement(
            'ALTER TABLE student_routines RENAME TO student_routines_old');

        // Crear la nueva tabla con la estructura completa
        await m.createTable(studentRoutines);

        // Migrar datos existentes (si los hay) con valores por defecto para scheduled_date
        await customStatement('''
          INSERT INTO student_routines (
            id, student_id, routine_id, trainer_id, assigned_date, scheduled_date,
            start_date, completed_date, status, progress_percentage,
            completed_sessions, total_sessions, notes, created_at, updated_at
          )
          SELECT 
            id, student_id, routine_id, trainer_id, assigned_date, assigned_date as scheduled_date,
            start_date, completed_date, status, progress_percentage,
            completed_sessions, total_sessions, notes, created_at, updated_at
          FROM student_routines_old
        ''');

        // Eliminar la tabla temporal
        await customStatement('DROP TABLE student_routines_old');

        print(
            '✅ Migrated student_routines table to include scheduled_date column');
      } else {
        print('✅ student_routines table already has scheduled_date column');
      }
    } catch (e) {
      print('❌ Error migrating student_routines table: $e');
      // Si falla, recrear la tabla completa
      await customStatement('DROP TABLE IF EXISTS student_routines');
      await m.createTable(studentRoutines);
      print('✅ Recreated student_routines table');
    }
  }

  // Métodos de seed data delegados al SeedDataManager
  Future<void> resetDatabase() async {
    print('🔄 Resetting database...');
    await customStatement('DELETE FROM student_routines');
    await customStatement('DELETE FROM routines');
    await customStatement('DELETE FROM payments');
    await customStatement('DELETE FROM students');
    await customStatement('DELETE FROM users');
    print('🗑️ All tables cleared');

    await _seedDataManager.insertBasicUser();
    print('✅ Database reset complete');
  }

  Future<void> resetDatabaseForTrainer(int trainerId) async {
    await _seedDataManager.resetDatabaseForTrainer(trainerId);
  }

  Future<void> ensureSeedData() async {
    await _seedDataManager.insertBasicUser();
  }

  Future<void> insertSeedRoutinesForTrainer(int trainerId) async {
    await _seedDataManager.insertSeedRoutinesForTrainer(trainerId);
  }

  Future<void> insertSeedStudentsForTrainer(int trainerId) async {
    await _seedDataManager.insertSeedStudentsForTrainer(trainerId);
  }

  Future<void> insertSeedProductsForTrainer(int trainerId) async {
    await _seedDataManager.insertSeedProductsForTrainer(trainerId);
  }

  Future<void> insertSampleUsers() async {
    await _seedDataManager.insertSampleUsers();
  }

  // Métodos de base de datos básicos
  Future<List<DbUser>> getAllUsers() => select(users).get();

  Future<DbUser?> getUserByEmail(String email) {
    return (select(users)..where((tbl) => tbl.email.equals(email)))
        .getSingleOrNull();
  }

  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<bool> updateUser(UsersCompanion user) => update(users).replace(user);

  Future<int> deleteUser(int id) =>
      (delete(users)..where((tbl) => tbl.id.equals(id))).go();

  // Métodos para estudiantes
  Future<List<DbStudent>> getAllStudents() => select(students).get();

  Future<List<DbStudent>> getStudentsByTrainer(int trainerId) {
    return (select(students)..where((tbl) => tbl.trainerId.equals(trainerId)))
        .get();
  }

  Future<int> insertStudent(StudentsCompanion student) =>
      into(students).insert(student);

  // Métodos para pagos
  Future<List<DbPayment>> getPaymentsByStudent(int studentId) {
    return (select(payments)..where((tbl) => tbl.studentId.equals(studentId)))
        .get();
  }

  Future<int> insertPayment(PaymentsCompanion payment) =>
      into(payments).insert(payment);

  // Métodos para rutinas
  Future<List<DbRoutine>> getAllRoutines() => select(routines).get();

  Future<List<DbRoutine>> getRoutinesByCreator(int creatorId) {
    return (select(routines)..where((tbl) => tbl.createdBy.equals(creatorId)))
        .get();
  }

  Future<int> insertRoutine(RoutinesCompanion routine) =>
      into(routines).insert(routine);

  // Métodos para rutinas de estudiantes
  Future<List<DbStudentRoutine>> getStudentRoutines(int studentId) {
    return (select(studentRoutines)
          ..where((tbl) => tbl.studentId.equals(studentId)))
        .get();
  }

  Future<int> insertStudentRoutine(StudentRoutinesCompanion studentRoutine) =>
      into(studentRoutines).insert(studentRoutine);

  // Métodos para estadísticas del usuario
  Future<UserStat?> getCurrentUserStats(int userId) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(userStats)
          ..where((tbl) => tbl.userId.equals(userId))
          ..where((tbl) => tbl.date.isBiggerOrEqualValue(startOfDay))
          ..where((tbl) => tbl.date.isSmallerThanValue(endOfDay)))
        .getSingleOrNull();
  }

  Future<List<DailyProgressData>> getWeeklyProgress(int userId) {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final startOfWeekDay =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endOfWeek = startOfWeekDay.add(const Duration(days: 7));

    return (select(dailyProgress)
          ..where((tbl) => tbl.userId.equals(userId))
          ..where((tbl) => tbl.date.isBiggerOrEqualValue(startOfWeekDay))
          ..where((tbl) => tbl.date.isSmallerThanValue(endOfWeek))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.date)]))
        .get();
  }

  Future<int> insertUserStats(UserStatsCompanion stats) =>
      into(userStats).insert(stats);

  Future<bool> updateUserStats(UserStatsCompanion stats) =>
      update(userStats).replace(stats);

  Future<int> insertDailyProgress(DailyProgressCompanion progress) =>
      into(dailyProgress).insert(progress);

  Future<bool> updateDailyProgress(DailyProgressCompanion progress) =>
      update(dailyProgress).replace(progress);

  Future<void> upsertUserStats(
    int userId, {
    int? calories,
    int? heartRate,
    double? weight,
    int? workoutMinutes,
    int? workoutsCompleted,
    int? steps,
  }) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final existingStats = await getCurrentUserStats(userId);

    if (existingStats != null) {
      // Actualizar estadísticas existentes
      final updatedStats = UserStatsCompanion(
        id: Value(existingStats.id),
        calories: Value(calories ?? existingStats.calories),
        heartRate: Value(heartRate ?? existingStats.heartRate),
        weight: Value(weight ?? existingStats.weight),
        workoutMinutes: Value(workoutMinutes ?? existingStats.workoutMinutes),
        workoutsCompleted:
            Value(workoutsCompleted ?? existingStats.workoutsCompleted),
        steps: Value(steps ?? existingStats.steps),
        updatedAt: Value(DateTime.now()),
      );
      await updateUserStats(updatedStats);
    } else {
      // Crear nuevas estadísticas
      final newStats = UserStatsCompanion.insert(
        userId: userId,
        calories: Value(calories ?? 0),
        heartRate: Value(heartRate ?? 0),
        weight: Value(weight ?? 0.0),
        workoutMinutes: Value(workoutMinutes ?? 0),
        workoutsCompleted: Value(workoutsCompleted ?? 0),
        steps: Value(steps ?? 0),
        date: startOfDay,
      );
      await insertUserStats(newStats);
    }
  }

  // Método para insertar datos de prueba de estadísticas
  Future<void> insertSampleStats(int userId) async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);

      // Insertar estadísticas de hoy
      final todayStats = UserStatsCompanion.insert(
        userId: userId,
        calories: Value(1850),
        heartRate: Value(72),
        weight: Value(70.5),
        workoutMinutes: Value(45),
        workoutsCompleted: Value(2),
        steps: Value(8234),
        date: startOfDay,
      );
      await insertUserStats(todayStats);

      // Insertar progreso semanal
      for (int i = 0; i < 7; i++) {
        final date = startOfDay.subtract(Duration(days: i));
        final progress = DailyProgressCompanion.insert(
          userId: userId,
          date: date,
          calories: Value(1800 + (i * 50)),
          steps: Value(8000 + (i * 200)),
          weight: Value(70.5 - (i * 0.1)),
        );
        await insertDailyProgress(progress);
      }

      print('✅ Sample stats inserted for user $userId');
    } catch (e) {
      print('❌ Error inserting sample stats: $e');
    }
  }

  // Métodos para productos de entrenadores
  Future<List<DbTrainerProduct>> getProductsByTrainer(int trainerId) {
    return (select(trainerProducts)
          ..where((tbl) => tbl.trainerId.equals(trainerId)))
        .get();
  }

  Future<List<DbTrainerProduct>> getAllActiveProducts() {
    return (select(trainerProducts)
          ..where((tbl) => tbl.status.equalsValue(ProductStatus.active)))
        .get();
  }

  Future<DbTrainerProduct?> getProductById(int productId) {
    return (select(trainerProducts)..where((tbl) => tbl.id.equals(productId)))
        .getSingleOrNull();
  }

  Future<int> insertTrainerProduct(TrainerProductsCompanion product) =>
      into(trainerProducts).insert(product);

  Future<bool> updateTrainerProduct(TrainerProductsCompanion product) async {
    final result = await (update(trainerProducts)
          ..where((tbl) => tbl.id.equals(product.id.value)))
        .write(product);
    return result > 0;
  }

  Future<int> deleteTrainerProduct(int productId) =>
      (delete(trainerProducts)..where((tbl) => tbl.id.equals(productId))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app_database.db'));
      return NativeDatabase(file);
    } catch (e) {
      print('Error accessing documents directory: $e');
      return NativeDatabase.memory();
    }
  });
}
