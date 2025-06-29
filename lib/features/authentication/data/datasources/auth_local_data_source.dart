import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/users_table.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppDatabase _database;

  AuthLocalDataSourceImpl(this._database);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    print('🔐 AuthLocalDataSource: Starting sign in for email: $email');

    try {
      final hashedPassword = _hashPassword(password);
      print('🔐 AuthLocalDataSource: Password hashed, searching for user...');

      final user = await (_database.select(_database.users)
            ..where((tbl) => tbl.email.equals(email))
            ..where((tbl) => tbl.password.equals(hashedPassword)))
          .getSingleOrNull();

      if (user == null) {
        print('❌ AuthLocalDataSource: No user found with email: $email');
        throw ServerException('invalidCredentials');
      }

      print('✅ AuthLocalDataSource: User found!');
      print('   User ID: ${user.id}');
      print('   User Email: ${user.email}');
      print('   User Name: ${user.firstName} ${user.lastName}');
      print('   User Role: ${user.role}');

      final userModel = UserModel.fromDbUser(user);
      print('✅ AuthLocalDataSource: UserModel created');
      print('   UserModel ID: ${userModel.id}');
      print('   UserModel Email: ${userModel.email}');
      print('   UserModel Name: ${userModel.name}');

      return userModel;
    } catch (e) {
      if (e is ServerException) rethrow;
      print('❌ AuthLocalDataSource: Error during sign in: $e');
      throw ServerException('loginError');
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      // Verificar si el email ya existe
      final existingUser = await (_database.select(_database.users)
            ..where((tbl) => tbl.email.equals(email)))
          .getSingleOrNull();

      if (existingUser != null) {
        throw ServerException('emailAlreadyExists');
      }

      final hashedPassword = _hashPassword(password);

      // Separar nombre en firstName y lastName
      final nameParts = name.trim().split(' ');
      final firstName = nameParts.first;
      final lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final companion = UsersCompanion.insert(
        email: email,
        password: hashedPassword,
        firstName: firstName,
        lastName: lastName,
        role: role,
      );

      final userId = await _database.users.insertOne(companion);

      final newUser = await (_database.select(_database.users)
            ..where((tbl) => tbl.id.equals(userId)))
          .getSingle();

      return UserModel.fromDbUser(newUser);
    } on DriftWrappedException catch (e) {
      // Error específico de base de datos
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw ServerException('emailAlreadyExists');
      }
      throw ServerException('databaseError');
    } catch (e) {
      if (e is ServerException) rethrow;
      print('SignUp Error: $e'); // Para debugging
      throw ServerException('signUpError');
    }
  }

  @override
  Future<void> signOut() async {
    // Para implementación local, simplemente limpiamos cualquier sesión guardada
    // En el futuro se podría integrar con SharedPreferences
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Para implementación local, esto se manejaría con SharedPreferences
    // Por ahora retornamos null
    return null;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
