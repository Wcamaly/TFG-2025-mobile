import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class GetCurrentProfileUseCase {
  final ProfileRepository repository;

  GetCurrentProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    return await repository.getCurrentUserProfile();
  }
}
