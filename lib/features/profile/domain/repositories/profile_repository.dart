import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getCurrentUserProfile();
  Future<Either<Failure, UserProfile>> updateProfile(UserProfile profile);
  Future<Either<Failure, void>> deleteProfile();
}
