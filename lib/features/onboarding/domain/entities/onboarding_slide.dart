import 'package:equatable/equatable.dart';

class OnboardingSlide extends Equatable {
  final String title;
  final String description;
  final String imageUrl;
  final int position;

  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.position,
  });

  @override
  List<Object?> get props => [title, description, imageUrl, position];
}
