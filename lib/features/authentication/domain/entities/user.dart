import '../../../../core/database/tables/users_table.dart';

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.user:
        return 'Usuario';
      case UserRole.trainer:
        return 'Entrenador';
    }
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final bool isEmailVerified;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final UserRole role;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.isEmailVerified = false,
    this.createdAt,
    this.lastLoginAt,
    this.role = UserRole.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'role': role.name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      role: json['role'] != null
          ? UserRole.fromString(json['role'] as String)
          : UserRole.user,
    );
  }
}
