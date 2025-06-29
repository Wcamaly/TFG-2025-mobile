import 'package:dartz/dartz.dart';
import 'package:tfg_2025_mobile/core/database/tables/users_table.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/error_translator.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import 'package:get_it/get_it.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await localDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      final translatedMessage =
          ErrorTranslator.translate(e.message ?? 'loginError');
      return Left(ServerFailure(message: translatedMessage));
    } catch (e) {
      final translatedMessage = ErrorTranslator.translate('loginError');
      return Left(UnknownFailure(message: translatedMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    UserRole role = UserRole.user,
  }) async {
    try {
      final user = await localDataSource.signUp(
        email: email,
        password: password,
        name: name,
        role: role,
      );

      // Insertar datos de prueba de estadísticas para el nuevo usuario
      try {
        final userId = int.tryParse(user.id);
        if (userId != null) {
          final database = sl<AppDatabase>();
          await database.insertSampleStats(userId);
          print('✅ Sample stats inserted for new user $userId');
        }
      } catch (e) {
        print('⚠️ Could not insert sample stats for new user: $e');
      }

      return Right(user);
    } on ServerException catch (e) {
      final translatedMessage =
          ErrorTranslator.translate(e.message ?? 'signUpError');
      return Left(ServerFailure(message: translatedMessage));
    } catch (e) {
      final translatedMessage = ErrorTranslator.translate('signUpError');
      return Left(UnknownFailure(message: translatedMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    // Para implementación local, por ahora no soportamos Google Sign In
    return Left(
        ServerFailure(message: 'Google Sign In no disponible en modo local'));
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      final translatedMessage =
          ErrorTranslator.translate(e.message ?? 'signOutError');
      return Left(ServerFailure(message: translatedMessage));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    // Para implementación local, por ahora no soportamos reset de password
    return Left(ServerFailure(
        message: 'Reset de password no disponible en modo local'));
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getCurrentUser();
      return Right(userModel?.toEntity());
    } on ServerException catch (e) {
      final translatedMessage =
          ErrorTranslator.translate(e.message ?? 'getUserError');
      return Left(ServerFailure(message: translatedMessage));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    // Para implementación local, retornamos un stream vacío por ahora
    return Stream.empty();
  }
}
