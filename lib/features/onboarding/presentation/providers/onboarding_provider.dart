import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/onboarding_page.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, List<OnboardingPage>>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<List<OnboardingPage>> {
  OnboardingNotifier()
      : super([
          const OnboardingPage(
            title: 'Build Your Mind\nand Body',
            subtitle: 'Be an Inspiration',
            imageUrl: 'assets/images/onboarding/build_mind_body.jpg',
            isLastPage: false,
            buttonText: 'Next',
          ),
          const OnboardingPage(
            title: 'Get Stronger for\nPreparation',
            subtitle: 'Be an Inspiration',
            imageUrl: 'assets/images/onboarding/get_stronger.jpg',
            isLastPage: false,
            buttonText: 'Next',
          ),
          const OnboardingPage(
            title: 'GYMNASTIC',
            subtitle: '',
            imageUrl: 'assets/images/onboarding/logo.jpg',
            isLastPage: false,
            buttonText: 'Next',
          ),
          const OnboardingPage(
            title: 'Running to Your\nDream',
            subtitle: 'Be an Inspiration',
            imageUrl: 'assets/images/onboarding/running_dream.jpg',
            isLastPage: true,
            buttonText: 'Get Started',
          ),
        ]);
}
