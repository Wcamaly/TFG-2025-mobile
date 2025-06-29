import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/services/places_service.dart';
import '../../../../core/widgets/inputs/address_autocomplete_field.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/profile_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final UserProfile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _bioController;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _specializationsController;
  late final TextEditingController _hourlyRateController;
  late final TextEditingController _certificationsController;
  late final TextEditingController _yearsExperienceController;

  String? _selectedGender;
  String? _selectedFitnessLevel;

  final List<String> _genderOptions = ['male', 'female', 'other'];
  final List<String> _fitnessLevelOptions = [
    'beginner',
    'intermediate',
    'advanced',
    'expert'
  ];

  bool _isLoading = false;
  bool _isGettingCoordinates = false;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _latitude = widget.profile.latitude;
    _longitude = widget.profile.longitude;
  }

  void _initializeControllers() {
    _firstNameController =
        TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
    _addressController =
        TextEditingController(text: widget.profile.address ?? '');
    _cityController = TextEditingController(text: widget.profile.city ?? '');
    _bioController = TextEditingController(text: widget.profile.bio ?? '');
    _ageController =
        TextEditingController(text: widget.profile.age?.toString() ?? '');
    _heightController =
        TextEditingController(text: widget.profile.height?.toString() ?? '');
    _weightController =
        TextEditingController(text: widget.profile.weight?.toString() ?? '');
    _specializationsController =
        TextEditingController(text: widget.profile.specializations ?? '');
    _hourlyRateController = TextEditingController(
        text: widget.profile.hourlyRate?.toString() ?? '');
    _certificationsController =
        TextEditingController(text: widget.profile.certifications ?? '');
    _yearsExperienceController = TextEditingController(
        text: widget.profile.yearsExperience?.toString() ?? '');

    _selectedGender = widget.profile.gender;
    _selectedFitnessLevel = widget.profile.fitnessLevel;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _specializationsController.dispose();
    _hourlyRateController.dispose();
    _certificationsController.dispose();
    _yearsExperienceController.dispose();
    super.dispose();
  }

  void _onCoordinatesObtained(Map<String, double> coordinates) {
    setState(() {
      _latitude = coordinates['latitude'];
      _longitude = coordinates['longitude'];
    });

    // Extraer la ciudad de la dirección seleccionada
    _extractCityFromAddress();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('coordinatesObtained'.tr()),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Extrae la ciudad de la dirección seleccionada
  void _extractCityFromAddress() {
    final address = _addressController.text.trim();
    if (address.isNotEmpty) {
      // Buscar la ciudad en la dirección (generalmente después de la última coma)
      final parts = address.split(',');
      if (parts.length >= 2) {
        // Tomar el penúltimo elemento como ciudad (último suele ser el país)
        final city = parts[parts.length - 2].trim();
        if (city.isNotEmpty) {
          _cityController.text = city;
        }
      }
    }
  }

  Future<void> _getCoordinatesFromAddress() async {
    final address = _addressController.text.trim();
    if (address.isEmpty) return;

    setState(() {
      _isGettingCoordinates = true;
    });

    try {
      final coordinates =
          await PlacesService.getCoordinatesFromAddress(address);

      if (coordinates != null) {
        setState(() {
          _latitude = coordinates['latitude'];
          _longitude = coordinates['longitude'];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('coordinatesObtained'.tr()),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('coordinatesNotFound'.tr()),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errorGettingCoordinates'.tr()),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isGettingCoordinates = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'editProfile'.tr(),
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: Text(
              'save'.tr(),
              style: AppTextStyles.bodyLarge.copyWith(
                color: _isLoading ? AppColors.textSecondary : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'personalInformation'.tr(),
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _firstNameController,
                            label: 'firstName'.tr(),
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'pleaseEnterFirstName'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _lastNameController,
                            label: 'lastName'.tr(),
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'pleaseEnterLastName'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'phone'.tr(),
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // Campo de dirección con autocompletado
                    AddressAutocompleteField(
                      controller: _addressController,
                      label: 'address'.tr(),
                      icon: Icons.location_on,
                      onCoordinatesObtained: _onCoordinatesObtained,
                    ),

                    // Mostrar coordenadas si están disponibles
                    if (_latitude != null && _longitude != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.success.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: AppColors.success, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'coordinatesAvailable'.tr(namedArgs: {
                                  'lat': _latitude!.toStringAsFixed(4),
                                  'lng': _longitude!.toStringAsFixed(4),
                                }),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _latitude = null;
                                  _longitude = null;
                                });
                              },
                              icon: const Icon(Icons.clear, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _bioController,
                      label: 'bio'.tr(),
                      icon: Icons.description,
                      maxLines: 3,
                    ),

                    // Información Física
                    const SizedBox(height: 32),
                    Text(
                      'profile.physicalInformation'.tr(),
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _ageController,
                            label: 'profile.age'.tr(),
                            icon: Icons.cake,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final n = int.tryParse(value);
                                if (n == null || n < 0 || n > 120) {
                                  return 'Introduce una edad válida';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdownField(
                            value: _selectedGender,
                            label: 'profile.gender'.tr(),
                            icon: Icons.person,
                            items: _genderOptions.map((gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender.tr()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _heightController,
                            label: 'profile.height'.tr() + ' (cm)',
                            icon: Icons.height,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final n = double.tryParse(value);
                                if (n == null || n < 50 || n > 250) {
                                  return 'Introduce una altura válida';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _weightController,
                            label: 'profile.weight'.tr() + ' (kg)',
                            icon: Icons.monitor_weight,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final n = double.tryParse(value);
                                if (n == null || n < 20 || n > 300) {
                                  return 'Introduce un peso válido';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      value: _selectedFitnessLevel,
                      label: 'profile.fitnessLevel'.tr(),
                      icon: Icons.fitness_center,
                      items: _fitnessLevelOptions.map((level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Text(level.tr()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFitnessLevel = value;
                        });
                      },
                    ),

                    // Campos profesionales solo para entrenadores
                    if (widget.profile.isTrainer) ...[
                      const SizedBox(height: 32),
                      Text(
                        'Información Profesional',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _specializationsController,
                        label: 'Especializaciones',
                        icon: Icons.star,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _hourlyRateController,
                        label: 'Tarifa por hora (€)',
                        icon: Icons.euro,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final n = double.tryParse(value);
                            if (n == null || n < 0) {
                              return 'Introduce un valor válido';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _yearsExperienceController,
                        label: 'Años de experiencia',
                        icon: Icons.work,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final n = int.tryParse(value);
                            if (n == null || n < 0) {
                              return 'Introduce un valor válido';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _certificationsController,
                        label: 'Certificaciones',
                        icon: Icons.school,
                      ),
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedProfile = widget.profile.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        address: _addressController.text.trim().isNotEmpty
            ? _addressController.text.trim()
            : null,
        city: _cityController.text.trim().isNotEmpty
            ? _cityController.text.trim()
            : null,
        bio: _bioController.text.trim().isNotEmpty
            ? _bioController.text.trim()
            : null,
        latitude: _latitude,
        longitude: _longitude,
        // Información física
        age: _ageController.text.trim().isNotEmpty
            ? int.tryParse(_ageController.text.trim())
            : null,
        gender: _selectedGender,
        height: _heightController.text.trim().isNotEmpty
            ? double.tryParse(_heightController.text.trim())
            : null,
        weight: _weightController.text.trim().isNotEmpty
            ? double.tryParse(_weightController.text.trim())
            : null,
        fitnessLevel: _selectedFitnessLevel,
        // Campos profesionales solo para entrenadores
        specializations: widget.profile.isTrainer &&
                _specializationsController.text.trim().isNotEmpty
            ? _specializationsController.text.trim()
            : null,
        hourlyRate: widget.profile.isTrainer &&
                _hourlyRateController.text.trim().isNotEmpty
            ? double.tryParse(_hourlyRateController.text.trim())
            : null,
        yearsExperience: widget.profile.isTrainer &&
                _yearsExperienceController.text.trim().isNotEmpty
            ? int.tryParse(_yearsExperienceController.text.trim())
            : null,
        certifications: widget.profile.isTrainer &&
                _certificationsController.text.trim().isNotEmpty
            ? _certificationsController.text.trim()
            : null,
        updatedAt: DateTime.now(),
      );

      final success = await ref
          .read(profileProvider.notifier)
          .updateProfile(updatedProfile);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profileUpdatedSuccessfully'.tr()),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('errorUpdatingProfile'.tr()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
