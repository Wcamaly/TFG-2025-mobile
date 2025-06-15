import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/onboarding_slide.dart';
import '../../domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  bool _onboardingCompleted = false;

  @override
  Future<Either<Failure, List<OnboardingSlide>>> getOnboardingSlides() async {
    try {
      return Right([
        const OnboardingSlide(
          title: 'Build Your Mind and Body',
          description: 'Start your journey to a healthier lifestyle today',
          imageUrl: 'assets/images/onboarding1.jpg',
          position: 0,
        ),
        const OnboardingSlide(
          title: 'Expert Trainers',
          description: 'Get personalized training from certified professionals',
          imageUrl: 'assets/images/onboarding2.jpg',
          position: 1,
        ),
        const OnboardingSlide(
          title: 'Track Your Progress',
          description: 'Monitor your achievements and stay motivated',
          imageUrl: 'assets/images/onboarding3.jpg',
          position: 2,
        ),
      ]);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markOnboardingAsCompleted() async {
    try {
      _onboardingCompleted = true;
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      return Right(_onboardingCompleted);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
