import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/onboarding_slide.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingSlidesUseCase {
  final OnboardingRepository repository;

  GetOnboardingSlidesUseCase(this.repository);

  Future<Either<Failure, List<OnboardingSlide>>> call() {
    return repository.getOnboardingSlides();
  }
}
