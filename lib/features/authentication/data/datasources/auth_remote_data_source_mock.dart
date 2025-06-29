import 'dart:async';
import 'package:tfg_2025_mobile/core/database/tables/users_table.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  final StreamController<UserModel?> _authStateController =
      StreamController<UserModel?>.broadcast();

  UserModel? _currentUser;

  // Usuarios de demo
  static final List<UserModel> _demoUsers = [
    UserModel(
      id: 'user_1',
      email: 'usuario@demo.com',
      name: 'María González',
      photoUrl: null,
      isEmailVerified: true,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      role: UserRole.user,
    ),
    UserModel(
      id: 'trainer_1',
      email: 'entrenador@demo.com',
      name: 'Carlos Rodríguez',
      photoUrl: null,
      isEmailVerified: true,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      role: UserRole.trainer,
    ),
  ];

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simular delay de red

    // Validaciones básicas
    if (email.isEmpty || password.isEmpty) {
      throw BadRequestException('Email and password are required');
    }

    if (!email.contains('@')) {
      throw BadRequestException('Invalid email format');
    }

    if (password.length < 6) {
      throw BadRequestException('Password must be at least 6 characters');
    }

    // Buscar usuario de demo por email
    UserModel? demoUser;
    try {
      demoUser = _demoUsers.firstWhere(
          (user) => user.email.toLowerCase() == email.toLowerCase());
    } catch (e) {
      // Si no encuentra usuario de demo, crear uno genérico
      demoUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: 'Usuario Genérico',
        photoUrl: null,
        isEmailVerified: true,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        role: UserRole.user,
      );
    }

    // Actualizar lastLoginAt
    final user = UserModel(
      id: demoUser.id,
      email: demoUser.email,
      name: demoUser.name,
      photoUrl: demoUser.photoUrl,
      isEmailVerified: demoUser.isEmailVerified,
      createdAt: demoUser.createdAt,
      lastLoginAt: DateTime.now(),
      role: demoUser.role,
    );

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw BadRequestException('All fields are required');
    }

    if (!email.contains('@')) {
      throw BadRequestException('Invalid email format');
    }

    if (password.length < 6) {
      throw BadRequestException('Password must be at least 6 characters');
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      photoUrl: null,
      isEmailVerified: false,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      role: UserRole.user, // Por defecto nuevos usuarios son tipo user
    );

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = UserModel(
      id: 'google_user_id',
      email: 'user@gmail.com',
      name: 'Google User',
      photoUrl: 'https://example.com/photo.jpg',
      isEmailVerified: true,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      role: UserRole.user,
    );

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || !email.contains('@')) {
      throw BadRequestException('Invalid email format');
    }

    // Simular envío de email de recuperación
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _currentUser;
  }

  @override
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  void dispose() {
    _authStateController.close();
  }

  // Método helper para obtener usuarios de demo (útil para testing)
  static List<UserModel> get demoUsers => List.unmodifiable(_demoUsers);
}
