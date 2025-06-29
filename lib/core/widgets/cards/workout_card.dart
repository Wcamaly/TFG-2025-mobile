import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final int rating;
  final VoidCallback? onTap;
  final double? progress;

  const WorkoutCard({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.rating = 0,
    this.onTap,
    this.progress,
  }) : assert(rating >= 0 && rating <= 5);

  @override
  Widget build(BuildContext context) {
    print('💪 WorkoutCard: Building workout card');
    print('   Title: $title');
    print('   Subtitle: $subtitle');
    print('   Image URL: $imageUrl');
    print('   Rating: $rating');
    print('   Progress: $progress');
    print('   Has onTap: ${onTap != null}');

    return GestureDetector(
      onTap: () {
        print('💪 WorkoutCard: Card tapped - "$title"');
        onTap?.call();
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.headlineMedium.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
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
                const Spacer(),
                if (progress != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                      minHeight: 4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
