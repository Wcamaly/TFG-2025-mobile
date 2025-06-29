import '../../../../core/database/tables/users_table.dart';
import '../../../../core/database/app_database.dart';

class UserProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? profileImageUrl;
  final String? bio;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? fitnessLevel;
  // Campos específicos para entrenadores
  final String? specializations;
  final double? hourlyRate;
  final String? certifications;
  final int? yearsExperience;
  final bool? isActive;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.profileImageUrl,
    this.bio,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.fitnessLevel,
    this.specializations,
    this.hourlyRate,
    this.certifications,
    this.yearsExperience,
    this.isActive,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  bool get isTrainer => role == UserRole.trainer;

  bool get hasLocation => latitude != null && longitude != null;

  String get displayLocation {
    if (city != null) return city!;
    if (hasLocation)
      return '${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}';
    return 'Ubicación no disponible';
  }

  // Método copyWith para crear versiones actualizadas
  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? profileImageUrl,
    String? bio,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? fitnessLevel,
    String? specializations,
    double? hourlyRate,
    String? certifications,
    int? yearsExperience,
    bool? isActive,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      specializations: specializations ?? this.specializations,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      certifications: certifications ?? this.certifications,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      isActive: isActive ?? this.isActive,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Factory para crear desde la base de datos
  factory UserProfile.fromDbUser(DbUser dbUser) {
    return UserProfile(
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
}
