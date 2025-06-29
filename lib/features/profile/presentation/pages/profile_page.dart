import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'profile.selectProfilePhoto'.tr(),
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  icon: Icons.camera_alt,
                  label: 'profile.camera'.tr(),
                  onTap: () => _selectImage(ImageSource.camera),
                ),
                _buildImageOption(
                  icon: Icons.photo_library,
                  label: 'profile.gallery'.tr(),
                  onTap: () => _selectImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage(ImageSource source) async {
    Navigator.pop(context);
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        // TODO: Aquí se subiría la imagen al servidor y se actualizaría el perfil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile.imageSelected'.tr()),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('profile.errorSelectingImage'.tr(args: [e.toString()])),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'profile.title'.tr(),
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              final profileState = ref.read(profileProvider);
              profileState.when(
                initial: () {},
                loading: () {},
                error: (_) {},
                loaded: (profile) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(profile: profile),
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: profileState.when(
          initial: () => Center(child: Text('profile.initializing'.tr())),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'profile.errorLoadingProfile'.tr(),
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(profileProvider.notifier).loadProfile(),
                  child: Text('profile.retry'.tr()),
                ),
              ],
            ),
          ),
          loaded: (profile) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Avatar y nombre con funcionalidad de edición
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (profile.profileImageUrl != null
                                ? NetworkImage(profile.profileImageUrl!)
                                : null) as ImageProvider?,
                        child: _selectedImage == null &&
                                profile.profileImageUrl == null
                            ? Text(
                                profile.firstName.isNotEmpty
                                    ? profile.firstName[0].toUpperCase()
                                    : 'U',
                                style: AppTextStyles.displayLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.background,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  profile.fullName,
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  profile.email,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                if (profile.isTrainer) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'profile.trainer'.tr(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Información personal
                _buildInfoSection(
                  title: 'profile.personalInformation'.tr(),
                  children: [
                    if (profile.address != null)
                      _buildInfoItem(Icons.location_on, 'profile.address'.tr(),
                          profile.address!),
                    if (profile.phone != null)
                      _buildInfoItem(
                          Icons.phone, 'profile.phone'.tr(), profile.phone!),
                    if (profile.age != null)
                      _buildInfoItem(Icons.cake, 'profile.age'.tr(),
                          '${profile.age} ${'profile.years'.tr()}'),
                    if (profile.gender != null)
                      _buildInfoItem(
                          Icons.person, 'profile.gender'.tr(), profile.gender!),
                    if (profile.bio != null && profile.bio!.isNotEmpty)
                      _buildInfoItem(
                          Icons.description, 'profile.bio'.tr(), profile.bio!),
                  ],
                ),

                // Información física (si está disponible)
                if (profile.height != null || profile.weight != null) ...[
                  const SizedBox(height: 24),
                  _buildInfoSection(
                    title: 'profile.physicalInformation'.tr(),
                    children: [
                      if (profile.height != null)
                        _buildInfoItem(Icons.height, 'profile.height'.tr(),
                            '${profile.height} cm'),
                      if (profile.weight != null)
                        _buildInfoItem(Icons.monitor_weight,
                            'profile.weight'.tr(), '${profile.weight} kg'),
                      if (profile.fitnessLevel != null)
                        _buildInfoItem(Icons.fitness_center,
                            'profile.fitnessLevel'.tr(), profile.fitnessLevel!),
                    ],
                  ),
                ],

                // Información del entrenador (si es entrenador)
                if (profile.isTrainer) ...[
                  const SizedBox(height: 24),
                  _buildInfoSection(
                    title: 'profile.professionalInformation'.tr(),
                    children: [
                      if (profile.specializations != null)
                        _buildInfoItem(
                            Icons.star,
                            'profile.specializations'.tr(),
                            profile.specializations!),
                      if (profile.hourlyRate != null)
                        _buildInfoItem(Icons.euro, 'profile.hourlyRate'.tr(),
                            '€${profile.hourlyRate}/h'),
                      if (profile.yearsExperience != null)
                        _buildInfoItem(Icons.work, 'profile.experience'.tr(),
                            '${profile.yearsExperience} ${'profile.years'.tr()}'),
                      if (profile.certifications != null)
                        _buildInfoItem(
                            Icons.school,
                            'profile.certifications'.tr(),
                            profile.certifications!),
                    ],
                  ),
                ],

                // Biografía
                if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildInfoSection(
                    title: 'profile.aboutMe'.tr(),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                AppColors.textSecondary.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          profile.bio!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 32),

                // Botón de cerrar sesión
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).signOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'profile.signOut'.tr(),
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
