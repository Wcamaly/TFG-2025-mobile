import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel> getCurrentUserProfile(String userId);
  Future<UserProfileModel> updateProfile(UserProfileModel profile);
  Future<void> deleteProfile(String userId);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final AppDatabase _database;

  ProfileLocalDataSourceImpl(this._database);

  @override
  Future<UserProfileModel> getCurrentUserProfile(String userId) async {
    try {
      final user = await (_database.select(_database.users)
            ..where((tbl) => tbl.id.equals(int.parse(userId))))
          .getSingleOrNull();

      if (user == null) {
        throw ServerException('userNotFound');
      }

      return UserProfileModel.fromDbUser(user);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('profileLoadError');
    }
  }

  @override
  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    try {
      final companion = UsersCompanion(
        id: Value(int.parse(profile.id)),
        firstName: Value(profile.firstName),
        lastName: Value(profile.lastName),
        phone: Value(profile.phone),
        address: Value(profile.address),
        city: Value(profile.city),
        bio: Value(profile.bio),
        age: Value(profile.age),
        gender: Value(profile.gender),
        height: Value(profile.height),
        weight: Value(profile.weight),
        fitnessLevel: Value(profile.fitnessLevel),
        specializations: Value(profile.specializations),
        hourlyRate: Value(profile.hourlyRate),
        certifications: Value(profile.certifications),
        yearsExperience: Value(profile.yearsExperience),
        updatedAt: Value(DateTime.now()),
      );

      await (_database.update(_database.users)
            ..where((tbl) => tbl.id.equals(int.parse(profile.id))))
          .write(companion);

      return await getCurrentUserProfile(profile.id);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('profileUpdateError');
    }
  }

  @override
  Future<void> deleteProfile(String userId) async {
    try {
      await (_database.delete(_database.users)
            ..where((tbl) => tbl.id.equals(int.parse(userId))))
          .go();
    } catch (e) {
      throw ServerException('profileDeleteError');
    }
  }
}
