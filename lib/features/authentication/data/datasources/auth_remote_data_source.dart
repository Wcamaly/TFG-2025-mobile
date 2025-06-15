import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn({
    required String email,
    required String password,
  });

  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();

  Future<User?> getCurrentUser();

  Future<void> resetPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Aquí iría la implementación con tu servicio de autenticación real
  // Por ejemplo, Firebase Auth, un servicio REST, etc.

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<User?> getCurrentUser() async {
    // Implementación real aquí
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    // Implementación real aquí
    // Aquí enviarías el correo de recuperación de contraseña
    throw UnimplementedError();
  }
}
