import '../../../../core/database/app_database.dart';
import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phone,
    super.address,
    super.city,
    super.latitude,
    super.longitude,
    super.profileImageUrl,
    super.bio,
    super.age,
    super.gender,
    super.height,
    super.weight,
    super.fitnessLevel,
    super.specializations,
    super.hourlyRate,
    super.certifications,
    super.yearsExperience,
    super.isActive,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
  });

  // Factory para crear desde la base de datos
  factory UserProfileModel.fromDbUser(DbUser dbUser) {
    return UserProfileModel(
      id: dbUser.id.toString(),
      email: dbUser.email,
      firstName: dbUser.firstName,
      lastName: dbUser.lastName,
      phone: dbUser.phone,
      address: dbUser.address,
      city: dbUser.city,
      latitude: dbUser.latitude,
      longitude: dbUser.longitude,
      profileImageUrl: dbUser.profileImageUrl,
      bio: dbUser.bio,
      age: dbUser.age,
      gender: dbUser.gender,
      height: dbUser.height,
      weight: dbUser.weight,
      fitnessLevel: dbUser.fitnessLevel,
      specializations: dbUser.specializations,
      hourlyRate: dbUser.hourlyRate,
      certifications: dbUser.certifications,
      yearsExperience: dbUser.yearsExperience,
      isActive: dbUser.isActive,
      role: dbUser.role,
      createdAt: dbUser.createdAt,
      updatedAt: dbUser.updatedAt,
    );
  }

  // Crear desde UserProfile
  factory UserProfileModel.fromUserProfile(UserProfile profile) {
    return UserProfileModel(
      id: profile.id,
      email: profile.email,
      firstName: profile.firstName,
      lastName: profile.lastName,
      phone: profile.phone,
      address: profile.address,
      city: profile.city,
      latitude: profile.latitude,
      longitude: profile.longitude,
      profileImageUrl: profile.profileImageUrl,
      bio: profile.bio,
      age: profile.age,
      gender: profile.gender,
      height: profile.height,
      weight: profile.weight,
      fitnessLevel: profile.fitnessLevel,
      specializations: profile.specializations,
      hourlyRate: profile.hourlyRate,
      certifications: profile.certifications,
      yearsExperience: profile.yearsExperience,
      isActive: profile.isActive,
      role: profile.role,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
