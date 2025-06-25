import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../domain/entities/meal.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/bmi_calculator_card.dart';
import '../widgets/calorie_calculator_card.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String _selectedGender = 'male';
  String _selectedActivityLevel = 'moderate';
  String _selectedGoal = 'maintain_weight';
  List<String> _selectedRestrictions = [];
  List<String> _selectedAllergies = [];

  final List<String> _activityLevels = [
    'sedentary',
    'light',
    'moderate',
    'active',
    'very_active',
  ];

  final List<String> _goals = [
    'lose_weight',
    'maintain_weight',
    'gain_weight',
    'gain_muscle',
  ];

  final List<String> _dietaryRestrictions = [
    'vegetarian',
    'vegan',
    'gluten_free',
    'dairy_free',
    'keto',
    'paleo',
    'low_carb',
  ];

  final List<String> _commonAllergies = [
    'nuts',
    'shellfish',
    'eggs',
    'milk',
    'soy',
    'wheat',
    'fish',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProfileProvider.notifier).loadUserProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileProvider);
    final bmiState = ref.watch(bmiCalculatorProvider);
    final calorieState = ref.watch(calorieCalculatorProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile & Health',
          style: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
        ),
      ),
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (profile) {
          _populateFields(profile);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information
                  _buildSectionTitle('Personal Information'),
                  const SizedBox(height: 16),
                  _buildPersonalInfoSection(),

                  const SizedBox(height: 32),

                  // Physical Measurements
                  _buildSectionTitle('Physical Measurements'),
                  const SizedBox(height: 16),
                  _buildPhysicalMeasurementsSection(),

                  const SizedBox(height: 24),

                  // BMI Calculator
                  BMICalculatorCard(
                    weight: double.tryParse(_weightController.text) ?? 0.0,
                    height: double.tryParse(_heightController.text) ?? 0.0,
                    bmiState: bmiState,
                    onCalculate: () {
                      final weight = double.tryParse(_weightController.text);
                      final height = double.tryParse(_heightController.text);
                      if (weight != null && height != null) {
                        ref.read(bmiCalculatorProvider.notifier).calculateBMI(
                              weight: weight,
                              height: height,
                            );
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // Activity & Goals
                  _buildSectionTitle('Activity & Goals'),
                  const SizedBox(height: 16),
                  _buildActivityGoalsSection(),

                  const SizedBox(height: 24),

                  // Calorie Calculator
                  CalorieCalculatorCard(
                    profile: _buildCurrentProfile(profile),
                    calorieState: calorieState,
                    onCalculate: () {
                      final currentProfile = _buildCurrentProfile(profile);
                      ref
                          .read(calorieCalculatorProvider.notifier)
                          .calculateCalories(profile: currentProfile);
                    },
                  ),

                  const SizedBox(height: 32),

                  // Dietary Preferences
                  _buildSectionTitle('Dietary Preferences'),
                  const SizedBox(height: 16),
                  _buildDietaryPreferencesSection(),

                  const SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: 'Save Profile',
                      onPressed: _saveProfile,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                message,
                style: AppTextStyles.bodyLarge.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(userProfileProvider.notifier).loadUserProfile();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.titleLarge.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          decoration: _inputDecoration('Full Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                decoration: _inputDecoration('Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 16 || age > 100) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                dropdownColor: AppColors.surface,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                decoration: _inputDecoration('Gender'),
                items: [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGender = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhysicalMeasurementsSection() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            decoration: _inputDecoration('Weight (kg)'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your weight';
              }
              final weight = double.tryParse(value);
              if (weight == null || weight < 30 || weight > 300) {
                return 'Please enter a valid weight';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            decoration: _inputDecoration('Height (cm)'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your height';
              }
              final height = double.tryParse(value);
              if (height == null || height < 100 || height > 250) {
                return 'Please enter a valid height';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity Level',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedActivityLevel,
          dropdownColor: AppColors.surface,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          decoration: _inputDecoration('Activity Level'),
          items: _activityLevels.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(_getActivityLevelLabel(level)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedActivityLevel = value;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Goal',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGoal,
          dropdownColor: AppColors.surface,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          decoration: _inputDecoration('Goal'),
          items: _goals.map((goal) {
            return DropdownMenuItem(
              value: goal,
              child: Text(_getGoalLabel(goal)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedGoal = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDietaryPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Restrictions',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _dietaryRestrictions.map((restriction) {
            final isSelected = _selectedRestrictions.contains(restriction);
            return FilterChip(
              label: Text(restriction.replaceAll('_', ' ').toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedRestrictions.add(restriction);
                  } else {
                    _selectedRestrictions.remove(restriction);
                  }
                });
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary.withOpacity(0.3),
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? AppColors.primary : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          'Allergies',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _commonAllergies.map((allergy) {
            final isSelected = _selectedAllergies.contains(allergy);
            return FilterChip(
              label: Text(allergy.toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAllergies.add(allergy);
                  } else {
                    _selectedAllergies.remove(allergy);
                  }
                });
              },
              backgroundColor: AppColors.surface,
              selectedColor: Colors.red.withOpacity(0.3),
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? Colors.red : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  void _populateFields(UserProfile profile) {
    if (_nameController.text.isEmpty) {
      _nameController.text = profile.name;
      _ageController.text = profile.age.toString();
      _weightController.text = profile.weight.toString();
      _heightController.text = profile.height.toString();
      _selectedGender = profile.gender;
      _selectedActivityLevel = profile.activityLevel;
      _selectedGoal = profile.goal;
      _selectedRestrictions = List.from(profile.dietaryRestrictions);
      _selectedAllergies = List.from(profile.allergies);
    }
  }

  UserProfile _buildCurrentProfile(UserProfile currentProfile) {
    return currentProfile.copyWith(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? currentProfile.age,
      weight: double.tryParse(_weightController.text) ?? currentProfile.weight,
      height: double.tryParse(_heightController.text) ?? currentProfile.height,
      gender: _selectedGender,
      activityLevel: _selectedActivityLevel,
      goal: _selectedGoal,
      dietaryRestrictions: _selectedRestrictions,
      allergies: _selectedAllergies,
      updatedAt: DateTime.now(),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final currentProfile = ref.read(userProfileProvider).whenOrNull(
            loaded: (profile) => profile,
          );

      if (currentProfile != null) {
        final updatedProfile = _buildCurrentProfile(currentProfile);
        ref
            .read(userProfileProvider.notifier)
            .updateUserProfile(updatedProfile);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  String _getActivityLevelLabel(String level) {
    switch (level) {
      case 'sedentary':
        return 'Sedentary (little/no exercise)';
      case 'light':
        return 'Light (light exercise 1-3 days/week)';
      case 'moderate':
        return 'Moderate (moderate exercise 3-5 days/week)';
      case 'active':
        return 'Active (hard exercise 6-7 days/week)';
      case 'very_active':
        return 'Very Active (very hard exercise/training)';
      default:
        return level;
    }
  }

  String _getGoalLabel(String goal) {
    switch (goal) {
      case 'lose_weight':
        return 'Lose Weight';
      case 'maintain_weight':
        return 'Maintain Weight';
      case 'gain_weight':
        return 'Gain Weight';
      case 'gain_muscle':
        return 'Gain Muscle';
      default:
        return goal;
    }
  }
}
