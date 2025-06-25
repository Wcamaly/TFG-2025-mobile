import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum SocialButtonType {
  facebook,
  google,
  twitter,
}

class SocialButton extends StatelessWidget {
  final SocialButtonType type;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: _buildIcon(),
                ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (type) {
      case SocialButtonType.facebook:
        return const Icon(
          Icons.facebook,
          color: Color(0xFF1877F2),
          size: 24,
        );
      case SocialButtonType.google:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            Icons.g_mobiledata,
            color: Color(0xFF4285F4),
            size: 20,
          ),
        );
      case SocialButtonType.twitter:
        return const Icon(
          Icons.flutter_dash,
          color: Color(0xFF1DA1F2),
          size: 24,
        );
    }
  }
}
