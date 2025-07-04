import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tfg_2025_mobile/core/database/tables/users_table.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';
import '../../domain/entities/user.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  UserRole _selectedRole = UserRole.user;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Logo
                SvgPicture.asset(
                  'assets/images/splash/logo.svg',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Create Account',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Join the fitness community',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                // Role Selection
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.divider,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Type',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRole = UserRole.user;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _selectedRole == UserRole.user
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _selectedRole == UserRole.user
                                        ? AppColors.primary
                                        : AppColors.divider,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.fitness_center,
                                      color: _selectedRole == UserRole.user
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'User',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: _selectedRole == UserRole.user
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Track workouts\nand nutrition',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRole = UserRole.trainer;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _selectedRole == UserRole.trainer
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _selectedRole == UserRole.trainer
                                        ? AppColors.primary
                                        : AppColors.divider,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: _selectedRole == UserRole.trainer
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Trainer',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: _selectedRole == UserRole.trainer
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Manage clients\nand routines',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Name Field
                CustomTextField(
                  controller: _nameController,
                  hint: 'Full Name',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.textSecondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  hint: 'Password',
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
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                CustomTextField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Register Button
                PrimaryButton(
                  text: 'Create Account',
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
                          .signUpWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            name: _nameController.text.trim(),
                            role: _selectedRole,
                          );
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Terms and Conditions
                Text(
                  'By creating an account, you agree to our\nTerms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
