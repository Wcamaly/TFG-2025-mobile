import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/database/tables/users_table.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_login_button.dart';
import '../../domain/entities/user.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          final route = user.role == UserRole.trainer
              ? '/trainer-dashboard'
              : '/dashboard';
          Navigator.pushReplacementNamed(context, route);
        },
        unauthenticated: (message) {
          if (message != 'No user found') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
      );
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo
                SvgPicture.asset(
                  'assets/images/splash/logo.svg',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),

                // App Name
                Text(
                  'GYMNESTIC',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 6),

                // Subtitle
                Text(
                  'beAnInspiration'.tr(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hint: 'email'.tr(),
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enterEmail'.tr();
                    }
                    if (!value.contains('@')) {
                      return 'validEmail'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  hint: 'password'.tr(),
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enterPassword'.tr();
                    }
                    if (value.length < 6) {
                      return 'passwordLength'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Login Button
                PrimaryButton(
                  text: 'login'.tr(),
                  isLoading: authState.when(
                    initial: () => false,
                    loading: () => true,
                    authenticated: (_) => false,
                    unauthenticated: (_) => false,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authProvider.notifier)
                          .signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          );
                    }
                  },
                ),

                const Spacer(),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    'forgotPassword'.tr(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Reset Database Button (Temporal para debugging)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await ref.read(authProvider.notifier).resetDatabase();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('databaseReset'.tr()),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: Text(
                        'resetDB'.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref.read(authProvider.notifier).listAllUsers();
                      },
                      child: Text(
                        'listUsers'.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'noAccount'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'signUp'.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: Implementar Google SSO en el futuro
// Código comentado para futura implementación:
/*
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'orContinueWith'.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                // Google Login
                SocialButton(
                  type: SocialButtonType.google,
                  onPressed: () {
                    ref.read(authProvider.notifier).signInWithGoogle();
                  },
                ),
*/
