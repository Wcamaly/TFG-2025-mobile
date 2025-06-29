import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserProfile>> getCurrentUserProfile() async {
    try {
      // Por ahora usamos un ID hardcodeado, en el futuro se obtendría del auth state
      // TODO: Obtener el ID del usuario autenticado
      const userId = '5'; // ID del entrenador@demo.com
      final profile = await localDataSource.getCurrentUserProfile(userId);
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'profileLoadError'));
    } catch (e) {
      return Left(ServerFailure(message: 'profileLoadError'));
    }
  }

  Future<Either<Failure, UserProfile>> getCurrentUserProfileById(
      String userId) async {
    try {
      final profile = await localDataSource.getCurrentUserProfile(userId);
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'profileLoadError'));
    } catch (e) {
      return Left(ServerFailure(message: 'profileLoadError'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile(
      UserProfile profile) async {
    try {
      final profileModel = UserProfileModel.fromUserProfile(profile);
      final updatedProfile = await localDataSource.updateProfile(profileModel);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'profileUpdateError'));
    } catch (e) {
      return Left(ServerFailure(message: 'profileUpdateError'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      // TODO: Obtener el ID del usuario autenticado
      const userId = '5';
      await localDataSource.deleteProfile(userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'profileDeleteError'));
    } catch (e) {
      return Left(ServerFailure(message: 'profileDeleteError'));
    }
  }
}
