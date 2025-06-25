import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Aquí iría la implementación con tu servicio de autenticación real
  // Por ejemplo, Firebase Auth, un servicio REST, etc.

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) async {
    // Implementación real aquí
    // Aquí enviarías el correo de recuperación de contraseña
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Stream<UserModel?> get authStateChanges => throw UnimplementedError();
}
