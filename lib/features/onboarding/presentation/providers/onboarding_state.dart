import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/onboarding_slide.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;
  const factory OnboardingState.loading() = _Loading;
  const factory OnboardingState.loaded(List<OnboardingSlide> slides) = _Loaded;
  const factory OnboardingState.completed() = _Completed;
  const factory OnboardingState.error(String message) = _Error;
}
