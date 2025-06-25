import 'dart:async';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  final StreamController<UserModel?> _authStateController =
      StreamController<UserModel?>.broadcast();

  UserModel? _currentUser;

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

    // Simular usuario mock
    final user = UserModel(
      id: '1',
      email: email,
      name: 'John Doe',
      photoUrl: null,
      isEmailVerified: true,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
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
}
