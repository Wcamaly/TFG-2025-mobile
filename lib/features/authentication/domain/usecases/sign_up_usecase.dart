import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tfg_2025_mobile/core/database/tables/users_table.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, User>> call(SignUpParams params) {
    return repository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
      role: params.role,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final UserRole role;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    this.role = UserRole.user,
  });

  @override
  List<Object?> get props => [email, password, name, role];
}
