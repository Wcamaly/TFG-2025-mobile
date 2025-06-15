import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/onboarding_slide.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingSlide>>> getOnboardingSlides();
  Future<Either<Failure, void>> markOnboardingAsCompleted();
  Future<Either<Failure, bool>> isOnboardingCompleted();
}
