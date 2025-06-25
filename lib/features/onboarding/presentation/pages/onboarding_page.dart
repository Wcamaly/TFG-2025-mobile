import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_slide_widget.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingProvider.notifier).loadSlides();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final onboardingState = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: onboardingState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (slides) => SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      l10n.onboardingSkip,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return OnboardingSlideWidget(slide: slides[index]);
                  },
                ),
              ),

              // Page indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentIndex == index ? 24.0 : 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? AppColors.primary
                            : AppColors.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
              ),

              // Next/Get Started button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryButton(
                  text: _currentIndex == slides.length - 1
                      ? l10n.onboardingGetStarted
                      : l10n.onboardingNext,
                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
        ),
        completed: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $message',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Retry',
                onPressed: () {
                  ref.read(onboardingProvider.notifier).loadSlides();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
