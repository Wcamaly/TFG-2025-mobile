import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal.dart';

part 'user_profile_provider.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;
  const factory UserProfileState.loading() = _Loading;
  const factory UserProfileState.loaded(UserProfile profile) = _Loaded;
  const factory UserProfileState.error(String message) = _Error;
}

@freezed
class BMIState with _$BMIState {
  const factory BMIState.initial() = _BMIInitial;
  const factory BMIState.loading() = _BMILoading;
  const factory BMIState.loaded(BMIData bmiData) = _BMILoaded;
  const factory BMIState.error(String message) = _BMIError;
}

@freezed
class CalorieCalculationState with _$CalorieCalculationState {
  const factory CalorieCalculationState.initial() = _CalorieInitial;
  const factory CalorieCalculationState.loading() = _CalorieLoading;
  const factory CalorieCalculationState.loaded(CalorieCalculation calculation) =
      _CalorieLoaded;
  const factory CalorieCalculationState.error(String message) = _CalorieError;
}

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  UserProfileNotifier() : super(const UserProfileState.initial());

  Future<void> loadUserProfile() async {
    state = const UserProfileState.loading();
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user profile
    final mockProfile = UserProfile(
      id: '1',
      name: 'John Doe',
      age: 25,
      gender: 'male',
      weight: 70.0,
      height: 175.0,
      activityLevel: 'moderate',
      goal: 'maintain_weight',
      dietaryRestrictions: [],
      allergies: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = UserProfileState.loaded(mockProfile);
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    state = const UserProfileState.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = UserProfileState.loaded(profile);
  }
}

class BMICalculatorNotifier extends StateNotifier<BMIState> {
  BMICalculatorNotifier() : super(const BMIState.initial());

  Future<void> calculateBMI({
    required double weight,
    required double height,
  }) async {
    state = const BMIState.loading();
    await Future.delayed(const Duration(milliseconds: 500));

    final bmi = weight / ((height / 100) * (height / 100));
    final mockBMI = BMIData(
      bmi: bmi,
      category: bmi < 18.5
          ? 'underweight'
          : bmi < 25
              ? 'normal'
              : bmi < 30
                  ? 'overweight'
                  : 'obese',
      description: 'BMI calculation result',
      idealWeightMin: 18.5 * ((height / 100) * (height / 100)),
      idealWeightMax: 24.9 * ((height / 100) * (height / 100)),
      recommendations: 'Maintain a healthy lifestyle',
    );

    state = BMIState.loaded(mockBMI);
  }

  void reset() {
    state = const BMIState.initial();
  }
}

class CalorieCalculatorNotifier extends StateNotifier<CalorieCalculationState> {
  CalorieCalculatorNotifier() : super(const CalorieCalculationState.initial());

  Future<void> calculateCalories({
    required UserProfile profile,
  }) async {
    state = const CalorieCalculationState.loading();
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock calorie calculation
    final mockCalculation = CalorieCalculation(
      bmr: 1800,
      tdee: 2200,
      maintenanceCalories: 2200,
      weightLossCalories: 1700,
      weightGainCalories: 2700,
      proteinGoal: 140,
      carbsGoal: 275,
      fatsGoal: 73,
      methodology: 'mifflin-st-jeor',
    );

    state = CalorieCalculationState.loaded(mockCalculation);
  }

  void reset() {
    state = const CalorieCalculationState.initial();
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
  return UserProfileNotifier();
});

final bmiCalculatorProvider =
    StateNotifierProvider<BMICalculatorNotifier, BMIState>((ref) {
  return BMICalculatorNotifier();
});

final calorieCalculatorProvider =
    StateNotifierProvider<CalorieCalculatorNotifier, CalorieCalculationState>(
        (ref) {
  return CalorieCalculatorNotifier();
});
