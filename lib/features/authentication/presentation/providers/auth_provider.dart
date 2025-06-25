import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_data_source_mock.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceMock(),
  );
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState.initial()) {
    _checkAuthState();
  }

  void _checkAuthState() async {
    state = const AuthState.loading();
    final result = await _authRepository.getCurrentUser();
    result.fold(
      (failure) => state = AuthState.unauthenticated(failure.message),
      (user) => state = user != null
          ? AuthState.authenticated(user)
          : const AuthState.unauthenticated('No user found'),
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => state = AuthState.unauthenticated(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AuthState.loading();
    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => state = AuthState.unauthenticated(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    final result = await _authRepository.signInWithGoogle();
    result.fold(
      (failure) => state = AuthState.unauthenticated(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await _authRepository.signOut();
    state = const AuthState.unauthenticated('Signed out');
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<void> resetPassword(String email) async {
    final result = await _authRepository.resetPassword(email);
    // Handle reset password result if needed
  }
}

class AuthState {
  const AuthState();

  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated(String message) = _Unauthenticated;

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(User user) authenticated,
    required T Function(String message) unauthenticated,
  }) {
    if (this is _Initial) return initial();
    if (this is _Loading) return loading();
    if (this is _Authenticated)
      return authenticated((this as _Authenticated).user);
    if (this is _Unauthenticated)
      return unauthenticated((this as _Unauthenticated).message);
    throw Exception('Unknown state');
  }
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Authenticated extends AuthState {
  final User user;
  const _Authenticated(this.user);
}

class _Unauthenticated extends AuthState {
  final String message;
  const _Unauthenticated(this.message);
}
