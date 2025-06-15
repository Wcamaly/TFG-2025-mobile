import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import 'repository_providers.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    signInUseCase: ref.watch(signInUseCaseProvider),
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    resetPasswordUseCase: ref.watch(resetPasswordUseCaseProvider),
  );
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthNotifier({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthState.initial());

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AuthState.loading();

    final result = await signInUseCase(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) {
        state = AuthState.authenticated(user);
        Navigator.pushReplacementNamed(context, '/dashboard');
      },
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AuthState.loading();

    final result = await signUpUseCase(
      SignUpParams(
        name: name,
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) {
        state = AuthState.registrationSuccess();
        Navigator.pop(context); // Volver a la pantalla de login
      },
    );
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    state = const AuthState.loading();

    final result = await resetPasswordUseCase(
      ResetPasswordParams(email: email),
    );

    state = result.fold(
      (failure) => AuthState.error(failure.message),
      (_) => const AuthState.passwordResetEmailSent(),
    );
  }

  void signOut(BuildContext context) {
    state = const AuthState.unauthenticated();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
