import '../../domain/entities/user.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/users_table.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.photoUrl,
    super.isEmailVerified = false,
    super.createdAt,
    super.lastLoginAt,
    super.role = UserRole.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  factory UserModel.fromDbUser(DbUser dbUser) {
    print('🔄 UserModel.fromDbUser: Converting DbUser to UserModel');
    print('   DbUser ID (int): ${dbUser.id}');
    print('   DbUser Email: ${dbUser.email}');
    print('   DbUser Name: ${dbUser.firstName} ${dbUser.lastName}');

    final userModel = UserModel(
      id: dbUser.id.toString(),
      email: dbUser.email,
      name: '${dbUser.firstName} ${dbUser.lastName}',
      photoUrl: dbUser.profileImageUrl,
      isEmailVerified: false,
      createdAt: dbUser.createdAt,
      lastLoginAt: null,
      role: dbUser.role,
    );

    print('🔄 UserModel.fromDbUser: Conversion complete');
    print('   UserModel ID (string): ${userModel.id}');
    print('   UserModel Email: ${userModel.email}');
    print('   UserModel Name: ${userModel.name}');

    return userModel;
  }

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

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      photoUrl: photoUrl,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      role: role,
    );
  }
}
