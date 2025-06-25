import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class TrainerCard extends StatelessWidget {
  final String name;
  final String description;
  final String? imageUrl;
  final List<String> specialties;
  final List<String> languages;
  final String location;
  final int rating;
  final VoidCallback? onTap;

  const TrainerCard({
    super.key,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.specialties,
    required this.languages,
    required this.location,
    this.rating = 0,
    this.onTap,
  }) : assert(rating >= 0 && rating <= 5);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Image
              CircleAvatar(
                radius: 32,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                backgroundColor: AppColors.surfaceLight,
                child: imageUrl == null
                    ? const Icon(Icons.person,
                        size: 32, color: AppColors.textSecondary)
                    : null,
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyles.headlineMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating ? Icons.star : Icons.star_border,
                              color: AppColors.primary,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Description
                    Text(
                      description,
                      style: AppTextStyles.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Specialties and Languages
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...specialties.map((specialty) => _buildChip(
                              specialty,
                              Icons.fitness_center,
                              AppColors.primary.withOpacity(0.1),
                            )),
                        ...languages.map((language) => _buildChip(
                              language,
                              Icons.language,
                              AppColors.secondary.withOpacity(0.1),
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: AppTextStyles.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
