import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/onboarding_page.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../../domain/usecases/get_onboarding_slides_usecase.dart';
import 'onboarding_state.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl();
});

final getOnboardingSlidesUseCaseProvider =
    Provider<GetOnboardingSlidesUseCase>((ref) {
  return GetOnboardingSlidesUseCase(ref.watch(onboardingRepositoryProvider));
});

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(
    getOnboardingSlidesUseCase: ref.watch(getOnboardingSlidesUseCaseProvider),
    repository: ref.watch(onboardingRepositoryProvider),
  );
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final GetOnboardingSlidesUseCase getOnboardingSlidesUseCase;
  final OnboardingRepository repository;

  OnboardingNotifier({
    required this.getOnboardingSlidesUseCase,
    required this.repository,
  }) : super(const OnboardingState.initial());

  Future<void> loadSlides() async {
    state = const OnboardingState.loading();
    final result = await getOnboardingSlidesUseCase();
    result.fold(
      (failure) => state = OnboardingState.error(failure.message),
      (slides) => state = OnboardingState.loaded(slides),
    );
  }

  Future<void> completeOnboarding() async {
    final result = await repository.markOnboardingAsCompleted();
    result.fold(
      (failure) => state = OnboardingState.error(failure.message),
      (_) => state = const OnboardingState.completed(),
    );
  }

  Future<bool> isOnboardingCompleted() async {
    final result = await repository.isOnboardingCompleted();
    return result.fold(
      (failure) => false,
      (isCompleted) => isCompleted,
    );
  }
}
