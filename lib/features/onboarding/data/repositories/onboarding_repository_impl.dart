import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/onboarding_slide.dart';
import '../../domain/repositories/onboarding_repository.dart';
import 'package:flutter/painting.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  @override
  Future<Either<Failure, List<OnboardingSlide>>> getOnboardingSlides() async {
    try {
      final slides = [
        const OnboardingSlide(
          title: 'Get Stronger',
          description:
              'Build muscle and strength with our expert-designed workout plans.',
          imageUrl: 'assets/images/onboarding/get_stronger.png',
          position: 0,
        ),
        const OnboardingSlide(
          title: 'Build Mind & Body',
          description:
              'Transform your body and mind with personalized fitness routines.',
          imageUrl: 'assets/images/onboarding/build_mind_body.png',
          position: 1,
        ),
        const OnboardingSlide(
          title: 'Running Dream',
          description:
              'Achieve your running goals with guided training programs.',
          imageUrl: 'assets/images/onboarding/running_dream.png',
          position: 2,
        ),
      ];
      return Right(slides);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return Right(prefs.getBool(_onboardingCompletedKey) ?? false);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markOnboardingAsCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompletedKey, true);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
