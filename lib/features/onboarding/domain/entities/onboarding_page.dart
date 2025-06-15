import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_page.freezed.dart';

@freezed
class OnboardingPage with _$OnboardingPage {
  const factory OnboardingPage({
    required String title,
    required String subtitle,
    required String imageUrl,
    required bool isLastPage,
    String? buttonText,
  }) = _OnboardingPage;
}
