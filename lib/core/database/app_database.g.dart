// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, DbUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('España'));
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _profileImageUrlMeta =
      const VerificationMeta('profileImageUrl');
  @override
  late final GeneratedColumn<String> profileImageUrl = GeneratedColumn<String>(
      'profile_image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
      'bio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fitnessLevelMeta =
      const VerificationMeta('fitnessLevel');
  @override
  late final GeneratedColumn<String> fitnessLevel = GeneratedColumn<String>(
      'fitness_level', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specializationsMeta =
      const VerificationMeta('specializations');
  @override
  late final GeneratedColumn<String> specializations = GeneratedColumn<String>(
      'specializations', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hourlyRateMeta =
      const VerificationMeta('hourlyRate');
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
      'hourly_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _certificationsMeta =
      const VerificationMeta('certifications');
  @override
  late final GeneratedColumn<String> certifications = GeneratedColumn<String>(
      'certifications', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _yearsExperienceMeta =
      const VerificationMeta('yearsExperience');
  @override
  late final GeneratedColumn<int> yearsExperience = GeneratedColumn<int>(
      'years_experience', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<UserRole, String> role =
      GeneratedColumn<String>('role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<UserRole>($UsersTable.$converterrole);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        password,
        firstName,
        lastName,
        phone,
        address,
        city,
        country,
        latitude,
        longitude,
        profileImageUrl,
        bio,
        age,
        gender,
        height,
        weight,
        fitnessLevel,
        specializations,
        hourlyRate,
        certifications,
        yearsExperience,
        role,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<DbUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('profile_image_url')) {
      context.handle(
          _profileImageUrlMeta,
          profileImageUrl.isAcceptableOrUnknown(
              data['profile_image_url']!, _profileImageUrlMeta));
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('fitness_level')) {
      context.handle(
          _fitnessLevelMeta,
          fitnessLevel.isAcceptableOrUnknown(
              data['fitness_level']!, _fitnessLevelMeta));
    }
    if (data.containsKey('specializations')) {
      context.handle(
          _specializationsMeta,
          specializations.isAcceptableOrUnknown(
              data['specializations']!, _specializationsMeta));
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
          _hourlyRateMeta,
          hourlyRate.isAcceptableOrUnknown(
              data['hourly_rate']!, _hourlyRateMeta));
    }
    if (data.containsKey('certifications')) {
      context.handle(
          _certificationsMeta,
          certifications.isAcceptableOrUnknown(
              data['certifications']!, _certificationsMeta));
    }
    if (data.containsKey('years_experience')) {
      context.handle(
          _yearsExperienceMeta,
          yearsExperience.isAcceptableOrUnknown(
              data['years_experience']!, _yearsExperienceMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      profileImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_image_url']),
      bio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bio']),
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      fitnessLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fitness_level']),
      specializations: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specializations']),
      hourlyRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hourly_rate']),
      certifications: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}certifications']),
      yearsExperience: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}years_experience']),
      role: $UsersTable.$converterrole.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UserRole, String, String> $converterrole =
      const EnumNameConverter<UserRole>(UserRole.values);
}

class DbUser extends DataClass implements Insertable<DbUser> {
  final int id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? city;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? profileImageUrl;
  final String? bio;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? fitnessLevel;
  final String? specializations;
  final double? hourlyRate;
  final String? certifications;
  final int? yearsExperience;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbUser(
      {required this.id,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      this.phone,
      this.address,
      this.city,
      required this.country,
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
      required this.role,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || profileImageUrl != null) {
      map['profile_image_url'] = Variable<String>(profileImageUrl);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || fitnessLevel != null) {
      map['fitness_level'] = Variable<String>(fitnessLevel);
    }
    if (!nullToAbsent || specializations != null) {
      map['specializations'] = Variable<String>(specializations);
    }
    if (!nullToAbsent || hourlyRate != null) {
      map['hourly_rate'] = Variable<double>(hourlyRate);
    }
    if (!nullToAbsent || certifications != null) {
      map['certifications'] = Variable<String>(certifications);
    }
    if (!nullToAbsent || yearsExperience != null) {
      map['years_experience'] = Variable<int>(yearsExperience);
    }
    {
      map['role'] = Variable<String>($UsersTable.$converterrole.toSql(role));
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      password: Value(password),
      firstName: Value(firstName),
      lastName: Value(lastName),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      country: Value(country),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      profileImageUrl: profileImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImageUrl),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      fitnessLevel: fitnessLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(fitnessLevel),
      specializations: specializations == null && nullToAbsent
          ? const Value.absent()
          : Value(specializations),
      hourlyRate: hourlyRate == null && nullToAbsent
          ? const Value.absent()
          : Value(hourlyRate),
      certifications: certifications == null && nullToAbsent
          ? const Value.absent()
          : Value(certifications),
      yearsExperience: yearsExperience == null && nullToAbsent
          ? const Value.absent()
          : Value(yearsExperience),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUser(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      city: serializer.fromJson<String?>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      profileImageUrl: serializer.fromJson<String?>(json['profileImageUrl']),
      bio: serializer.fromJson<String?>(json['bio']),
      age: serializer.fromJson<int?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      height: serializer.fromJson<double?>(json['height']),
      weight: serializer.fromJson<double?>(json['weight']),
      fitnessLevel: serializer.fromJson<String?>(json['fitnessLevel']),
      specializations: serializer.fromJson<String?>(json['specializations']),
      hourlyRate: serializer.fromJson<double?>(json['hourlyRate']),
      certifications: serializer.fromJson<String?>(json['certifications']),
      yearsExperience: serializer.fromJson<int?>(json['yearsExperience']),
      role: $UsersTable.$converterrole
          .fromJson(serializer.fromJson<String>(json['role'])),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'city': serializer.toJson<String?>(city),
      'country': serializer.toJson<String>(country),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'profileImageUrl': serializer.toJson<String?>(profileImageUrl),
      'bio': serializer.toJson<String?>(bio),
      'age': serializer.toJson<int?>(age),
      'gender': serializer.toJson<String?>(gender),
      'height': serializer.toJson<double?>(height),
      'weight': serializer.toJson<double?>(weight),
      'fitnessLevel': serializer.toJson<String?>(fitnessLevel),
      'specializations': serializer.toJson<String?>(specializations),
      'hourlyRate': serializer.toJson<double?>(hourlyRate),
      'certifications': serializer.toJson<String?>(certifications),
      'yearsExperience': serializer.toJson<int?>(yearsExperience),
      'role':
          serializer.toJson<String>($UsersTable.$converterrole.toJson(role)),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbUser copyWith(
          {int? id,
          String? email,
          String? password,
          String? firstName,
          String? lastName,
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> city = const Value.absent(),
          String? country,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> profileImageUrl = const Value.absent(),
          Value<String?> bio = const Value.absent(),
          Value<int?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> height = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<String?> fitnessLevel = const Value.absent(),
          Value<String?> specializations = const Value.absent(),
          Value<double?> hourlyRate = const Value.absent(),
          Value<String?> certifications = const Value.absent(),
          Value<int?> yearsExperience = const Value.absent(),
          UserRole? role,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbUser(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        city: city.present ? city.value : this.city,
        country: country ?? this.country,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        profileImageUrl: profileImageUrl.present
            ? profileImageUrl.value
            : this.profileImageUrl,
        bio: bio.present ? bio.value : this.bio,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        height: height.present ? height.value : this.height,
        weight: weight.present ? weight.value : this.weight,
        fitnessLevel:
            fitnessLevel.present ? fitnessLevel.value : this.fitnessLevel,
        specializations: specializations.present
            ? specializations.value
            : this.specializations,
        hourlyRate: hourlyRate.present ? hourlyRate.value : this.hourlyRate,
        certifications:
            certifications.present ? certifications.value : this.certifications,
        yearsExperience: yearsExperience.present
            ? yearsExperience.value
            : this.yearsExperience,
        role: role ?? this.role,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbUser copyWithCompanion(UsersCompanion data) {
    return DbUser(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      profileImageUrl: data.profileImageUrl.present
          ? data.profileImageUrl.value
          : this.profileImageUrl,
      bio: data.bio.present ? data.bio.value : this.bio,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      fitnessLevel: data.fitnessLevel.present
          ? data.fitnessLevel.value
          : this.fitnessLevel,
      specializations: data.specializations.present
          ? data.specializations.value
          : this.specializations,
      hourlyRate:
          data.hourlyRate.present ? data.hourlyRate.value : this.hourlyRate,
      certifications: data.certifications.present
          ? data.certifications.value
          : this.certifications,
      yearsExperience: data.yearsExperience.present
          ? data.yearsExperience.value
          : this.yearsExperience,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUser(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('bio: $bio, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('specializations: $specializations, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('certifications: $certifications, ')
          ..write('yearsExperience: $yearsExperience, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        email,
        password,
        firstName,
        lastName,
        phone,
        address,
        city,
        country,
        latitude,
        longitude,
        profileImageUrl,
        bio,
        age,
        gender,
        height,
        weight,
        fitnessLevel,
        specializations,
        hourlyRate,
        certifications,
        yearsExperience,
        role,
        isActive,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUser &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.city == this.city &&
          other.country == this.country &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.profileImageUrl == this.profileImageUrl &&
          other.bio == this.bio &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.fitnessLevel == this.fitnessLevel &&
          other.specializations == this.specializations &&
          other.hourlyRate == this.hourlyRate &&
          other.certifications == this.certifications &&
          other.yearsExperience == this.yearsExperience &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<DbUser> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> city;
  final Value<String> country;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> profileImageUrl;
  final Value<String?> bio;
  final Value<int?> age;
  final Value<String?> gender;
  final Value<double?> height;
  final Value<double?> weight;
  final Value<String?> fitnessLevel;
  final Value<String?> specializations;
  final Value<double?> hourlyRate;
  final Value<String?> certifications;
  final Value<int?> yearsExperience;
  final Value<UserRole> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.specializations = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.certifications = const Value.absent(),
    this.yearsExperience = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.specializations = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.certifications = const Value.absent(),
    this.yearsExperience = const Value.absent(),
    required UserRole role,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : email = Value(email),
        password = Value(password),
        firstName = Value(firstName),
        lastName = Value(lastName),
        role = Value(role);
  static Insertable<DbUser> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? country,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? profileImageUrl,
    Expression<String>? bio,
    Expression<int>? age,
    Expression<String>? gender,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<String>? fitnessLevel,
    Expression<String>? specializations,
    Expression<double>? hourlyRate,
    Expression<String>? certifications,
    Expression<int>? yearsExperience,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      if (bio != null) 'bio': bio,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (fitnessLevel != null) 'fitness_level': fitnessLevel,
      if (specializations != null) 'specializations': specializations,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (certifications != null) 'certifications': certifications,
      if (yearsExperience != null) 'years_experience': yearsExperience,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? email,
      Value<String>? password,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String?>? city,
      Value<String>? country,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? profileImageUrl,
      Value<String?>? bio,
      Value<int?>? age,
      Value<String?>? gender,
      Value<double?>? height,
      Value<double?>? weight,
      Value<String?>? fitnessLevel,
      Value<String?>? specializations,
      Value<double?>? hourlyRate,
      Value<String?>? certifications,
      Value<int?>? yearsExperience,
      Value<UserRole>? role,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
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
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (profileImageUrl.present) {
      map['profile_image_url'] = Variable<String>(profileImageUrl.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (fitnessLevel.present) {
      map['fitness_level'] = Variable<String>(fitnessLevel.value);
    }
    if (specializations.present) {
      map['specializations'] = Variable<String>(specializations.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (certifications.present) {
      map['certifications'] = Variable<String>(certifications.value);
    }
    if (yearsExperience.present) {
      map['years_experience'] = Variable<int>(yearsExperience.value);
    }
    if (role.present) {
      map['role'] =
          Variable<String>($UsersTable.$converterrole.toSql(role.value));
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('bio: $bio, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('specializations: $specializations, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('certifications: $certifications, ')
          ..write('yearsExperience: $yearsExperience, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students
    with TableInfo<$StudentsTable, DbStudent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _trainerIdMeta =
      const VerificationMeta('trainerId');
  @override
  late final GeneratedColumn<int> trainerId = GeneratedColumn<int>(
      'trainer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<StudentStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<StudentStatus>($StudentsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionType, String>
      subscriptionType = GeneratedColumn<String>(
              'subscription_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SubscriptionType>(
              $StudentsTable.$convertersubscriptionType);
  static const VerificationMeta _subscriptionStartDateMeta =
      const VerificationMeta('subscriptionStartDate');
  @override
  late final GeneratedColumn<DateTime> subscriptionStartDate =
      GeneratedColumn<DateTime>('subscription_start_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionEndDateMeta =
      const VerificationMeta('subscriptionEndDate');
  @override
  late final GeneratedColumn<DateTime> subscriptionEndDate =
      GeneratedColumn<DateTime>('subscription_end_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _remainingClassesMeta =
      const VerificationMeta('remainingClasses');
  @override
  late final GeneratedColumn<int> remainingClasses = GeneratedColumn<int>(
      'remaining_classes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalClassesMeta =
      const VerificationMeta('totalClasses');
  @override
  late final GeneratedColumn<int> totalClasses = GeneratedColumn<int>(
      'total_classes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _monthlyFeeMeta =
      const VerificationMeta('monthlyFee');
  @override
  late final GeneratedColumn<double> monthlyFee = GeneratedColumn<double>(
      'monthly_fee', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lastPaymentDateMeta =
      const VerificationMeta('lastPaymentDate');
  @override
  late final GeneratedColumn<DateTime> lastPaymentDate =
      GeneratedColumn<DateTime>('last_payment_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nextPaymentDateMeta =
      const VerificationMeta('nextPaymentDate');
  @override
  late final GeneratedColumn<DateTime> nextPaymentDate =
      GeneratedColumn<DateTime>('next_payment_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _progressPercentageMeta =
      const VerificationMeta('progressPercentage');
  @override
  late final GeneratedColumn<double> progressPercentage =
      GeneratedColumn<double>('progress_percentage', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        trainerId,
        status,
        subscriptionType,
        subscriptionStartDate,
        subscriptionEndDate,
        remainingClasses,
        totalClasses,
        monthlyFee,
        lastPaymentDate,
        nextPaymentDate,
        progressPercentage,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<DbStudent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('trainer_id')) {
      context.handle(_trainerIdMeta,
          trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta));
    } else if (isInserting) {
      context.missing(_trainerIdMeta);
    }
    if (data.containsKey('subscription_start_date')) {
      context.handle(
          _subscriptionStartDateMeta,
          subscriptionStartDate.isAcceptableOrUnknown(
              data['subscription_start_date']!, _subscriptionStartDateMeta));
    } else if (isInserting) {
      context.missing(_subscriptionStartDateMeta);
    }
    if (data.containsKey('subscription_end_date')) {
      context.handle(
          _subscriptionEndDateMeta,
          subscriptionEndDate.isAcceptableOrUnknown(
              data['subscription_end_date']!, _subscriptionEndDateMeta));
    } else if (isInserting) {
      context.missing(_subscriptionEndDateMeta);
    }
    if (data.containsKey('remaining_classes')) {
      context.handle(
          _remainingClassesMeta,
          remainingClasses.isAcceptableOrUnknown(
              data['remaining_classes']!, _remainingClassesMeta));
    }
    if (data.containsKey('total_classes')) {
      context.handle(
          _totalClassesMeta,
          totalClasses.isAcceptableOrUnknown(
              data['total_classes']!, _totalClassesMeta));
    }
    if (data.containsKey('monthly_fee')) {
      context.handle(
          _monthlyFeeMeta,
          monthlyFee.isAcceptableOrUnknown(
              data['monthly_fee']!, _monthlyFeeMeta));
    } else if (isInserting) {
      context.missing(_monthlyFeeMeta);
    }
    if (data.containsKey('last_payment_date')) {
      context.handle(
          _lastPaymentDateMeta,
          lastPaymentDate.isAcceptableOrUnknown(
              data['last_payment_date']!, _lastPaymentDateMeta));
    }
    if (data.containsKey('next_payment_date')) {
      context.handle(
          _nextPaymentDateMeta,
          nextPaymentDate.isAcceptableOrUnknown(
              data['next_payment_date']!, _nextPaymentDateMeta));
    } else if (isInserting) {
      context.missing(_nextPaymentDateMeta);
    }
    if (data.containsKey('progress_percentage')) {
      context.handle(
          _progressPercentageMeta,
          progressPercentage.isAcceptableOrUnknown(
              data['progress_percentage']!, _progressPercentageMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbStudent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbStudent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      trainerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trainer_id'])!,
      status: $StudentsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      subscriptionType: $StudentsTable.$convertersubscriptionType.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}subscription_type'])!),
      subscriptionStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}subscription_start_date'])!,
      subscriptionEndDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}subscription_end_date'])!,
      remainingClasses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remaining_classes'])!,
      totalClasses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_classes'])!,
      monthlyFee: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monthly_fee'])!,
      lastPaymentDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_payment_date']),
      nextPaymentDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_payment_date'])!,
      progressPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}progress_percentage'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StudentStatus, String, String> $converterstatus =
      const EnumNameConverter<StudentStatus>(StudentStatus.values);
  static JsonTypeConverter2<SubscriptionType, String, String>
      $convertersubscriptionType =
      const EnumNameConverter<SubscriptionType>(SubscriptionType.values);
}

class DbStudent extends DataClass implements Insertable<DbStudent> {
  final int id;
  final int userId;
  final int trainerId;
  final StudentStatus status;
  final SubscriptionType subscriptionType;
  final DateTime subscriptionStartDate;
  final DateTime subscriptionEndDate;
  final int remainingClasses;
  final int totalClasses;
  final double monthlyFee;
  final DateTime? lastPaymentDate;
  final DateTime nextPaymentDate;
  final double progressPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbStudent(
      {required this.id,
      required this.userId,
      required this.trainerId,
      required this.status,
      required this.subscriptionType,
      required this.subscriptionStartDate,
      required this.subscriptionEndDate,
      required this.remainingClasses,
      required this.totalClasses,
      required this.monthlyFee,
      this.lastPaymentDate,
      required this.nextPaymentDate,
      required this.progressPercentage,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['trainer_id'] = Variable<int>(trainerId);
    {
      map['status'] =
          Variable<String>($StudentsTable.$converterstatus.toSql(status));
    }
    {
      map['subscription_type'] = Variable<String>(
          $StudentsTable.$convertersubscriptionType.toSql(subscriptionType));
    }
    map['subscription_start_date'] = Variable<DateTime>(subscriptionStartDate);
    map['subscription_end_date'] = Variable<DateTime>(subscriptionEndDate);
    map['remaining_classes'] = Variable<int>(remainingClasses);
    map['total_classes'] = Variable<int>(totalClasses);
    map['monthly_fee'] = Variable<double>(monthlyFee);
    if (!nullToAbsent || lastPaymentDate != null) {
      map['last_payment_date'] = Variable<DateTime>(lastPaymentDate);
    }
    map['next_payment_date'] = Variable<DateTime>(nextPaymentDate);
    map['progress_percentage'] = Variable<double>(progressPercentage);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      userId: Value(userId),
      trainerId: Value(trainerId),
      status: Value(status),
      subscriptionType: Value(subscriptionType),
      subscriptionStartDate: Value(subscriptionStartDate),
      subscriptionEndDate: Value(subscriptionEndDate),
      remainingClasses: Value(remainingClasses),
      totalClasses: Value(totalClasses),
      monthlyFee: Value(monthlyFee),
      lastPaymentDate: lastPaymentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPaymentDate),
      nextPaymentDate: Value(nextPaymentDate),
      progressPercentage: Value(progressPercentage),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbStudent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbStudent(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      trainerId: serializer.fromJson<int>(json['trainerId']),
      status: $StudentsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      subscriptionType: $StudentsTable.$convertersubscriptionType
          .fromJson(serializer.fromJson<String>(json['subscriptionType'])),
      subscriptionStartDate:
          serializer.fromJson<DateTime>(json['subscriptionStartDate']),
      subscriptionEndDate:
          serializer.fromJson<DateTime>(json['subscriptionEndDate']),
      remainingClasses: serializer.fromJson<int>(json['remainingClasses']),
      totalClasses: serializer.fromJson<int>(json['totalClasses']),
      monthlyFee: serializer.fromJson<double>(json['monthlyFee']),
      lastPaymentDate: serializer.fromJson<DateTime?>(json['lastPaymentDate']),
      nextPaymentDate: serializer.fromJson<DateTime>(json['nextPaymentDate']),
      progressPercentage:
          serializer.fromJson<double>(json['progressPercentage']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'trainerId': serializer.toJson<int>(trainerId),
      'status': serializer
          .toJson<String>($StudentsTable.$converterstatus.toJson(status)),
      'subscriptionType': serializer.toJson<String>(
          $StudentsTable.$convertersubscriptionType.toJson(subscriptionType)),
      'subscriptionStartDate':
          serializer.toJson<DateTime>(subscriptionStartDate),
      'subscriptionEndDate': serializer.toJson<DateTime>(subscriptionEndDate),
      'remainingClasses': serializer.toJson<int>(remainingClasses),
      'totalClasses': serializer.toJson<int>(totalClasses),
      'monthlyFee': serializer.toJson<double>(monthlyFee),
      'lastPaymentDate': serializer.toJson<DateTime?>(lastPaymentDate),
      'nextPaymentDate': serializer.toJson<DateTime>(nextPaymentDate),
      'progressPercentage': serializer.toJson<double>(progressPercentage),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbStudent copyWith(
          {int? id,
          int? userId,
          int? trainerId,
          StudentStatus? status,
          SubscriptionType? subscriptionType,
          DateTime? subscriptionStartDate,
          DateTime? subscriptionEndDate,
          int? remainingClasses,
          int? totalClasses,
          double? monthlyFee,
          Value<DateTime?> lastPaymentDate = const Value.absent(),
          DateTime? nextPaymentDate,
          double? progressPercentage,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbStudent(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        trainerId: trainerId ?? this.trainerId,
        status: status ?? this.status,
        subscriptionType: subscriptionType ?? this.subscriptionType,
        subscriptionStartDate:
            subscriptionStartDate ?? this.subscriptionStartDate,
        subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
        remainingClasses: remainingClasses ?? this.remainingClasses,
        totalClasses: totalClasses ?? this.totalClasses,
        monthlyFee: monthlyFee ?? this.monthlyFee,
        lastPaymentDate: lastPaymentDate.present
            ? lastPaymentDate.value
            : this.lastPaymentDate,
        nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
        progressPercentage: progressPercentage ?? this.progressPercentage,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbStudent copyWithCompanion(StudentsCompanion data) {
    return DbStudent(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      status: data.status.present ? data.status.value : this.status,
      subscriptionType: data.subscriptionType.present
          ? data.subscriptionType.value
          : this.subscriptionType,
      subscriptionStartDate: data.subscriptionStartDate.present
          ? data.subscriptionStartDate.value
          : this.subscriptionStartDate,
      subscriptionEndDate: data.subscriptionEndDate.present
          ? data.subscriptionEndDate.value
          : this.subscriptionEndDate,
      remainingClasses: data.remainingClasses.present
          ? data.remainingClasses.value
          : this.remainingClasses,
      totalClasses: data.totalClasses.present
          ? data.totalClasses.value
          : this.totalClasses,
      monthlyFee:
          data.monthlyFee.present ? data.monthlyFee.value : this.monthlyFee,
      lastPaymentDate: data.lastPaymentDate.present
          ? data.lastPaymentDate.value
          : this.lastPaymentDate,
      nextPaymentDate: data.nextPaymentDate.present
          ? data.nextPaymentDate.value
          : this.nextPaymentDate,
      progressPercentage: data.progressPercentage.present
          ? data.progressPercentage.value
          : this.progressPercentage,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbStudent(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trainerId: $trainerId, ')
          ..write('status: $status, ')
          ..write('subscriptionType: $subscriptionType, ')
          ..write('subscriptionStartDate: $subscriptionStartDate, ')
          ..write('subscriptionEndDate: $subscriptionEndDate, ')
          ..write('remainingClasses: $remainingClasses, ')
          ..write('totalClasses: $totalClasses, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('lastPaymentDate: $lastPaymentDate, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      trainerId,
      status,
      subscriptionType,
      subscriptionStartDate,
      subscriptionEndDate,
      remainingClasses,
      totalClasses,
      monthlyFee,
      lastPaymentDate,
      nextPaymentDate,
      progressPercentage,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbStudent &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.trainerId == this.trainerId &&
          other.status == this.status &&
          other.subscriptionType == this.subscriptionType &&
          other.subscriptionStartDate == this.subscriptionStartDate &&
          other.subscriptionEndDate == this.subscriptionEndDate &&
          other.remainingClasses == this.remainingClasses &&
          other.totalClasses == this.totalClasses &&
          other.monthlyFee == this.monthlyFee &&
          other.lastPaymentDate == this.lastPaymentDate &&
          other.nextPaymentDate == this.nextPaymentDate &&
          other.progressPercentage == this.progressPercentage &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentsCompanion extends UpdateCompanion<DbStudent> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> trainerId;
  final Value<StudentStatus> status;
  final Value<SubscriptionType> subscriptionType;
  final Value<DateTime> subscriptionStartDate;
  final Value<DateTime> subscriptionEndDate;
  final Value<int> remainingClasses;
  final Value<int> totalClasses;
  final Value<double> monthlyFee;
  final Value<DateTime?> lastPaymentDate;
  final Value<DateTime> nextPaymentDate;
  final Value<double> progressPercentage;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.trainerId = const Value.absent(),
    this.status = const Value.absent(),
    this.subscriptionType = const Value.absent(),
    this.subscriptionStartDate = const Value.absent(),
    this.subscriptionEndDate = const Value.absent(),
    this.remainingClasses = const Value.absent(),
    this.totalClasses = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.lastPaymentDate = const Value.absent(),
    this.nextPaymentDate = const Value.absent(),
    this.progressPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int trainerId,
    required StudentStatus status,
    required SubscriptionType subscriptionType,
    required DateTime subscriptionStartDate,
    required DateTime subscriptionEndDate,
    this.remainingClasses = const Value.absent(),
    this.totalClasses = const Value.absent(),
    required double monthlyFee,
    this.lastPaymentDate = const Value.absent(),
    required DateTime nextPaymentDate,
    this.progressPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        trainerId = Value(trainerId),
        status = Value(status),
        subscriptionType = Value(subscriptionType),
        subscriptionStartDate = Value(subscriptionStartDate),
        subscriptionEndDate = Value(subscriptionEndDate),
        monthlyFee = Value(monthlyFee),
        nextPaymentDate = Value(nextPaymentDate);
  static Insertable<DbStudent> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? trainerId,
    Expression<String>? status,
    Expression<String>? subscriptionType,
    Expression<DateTime>? subscriptionStartDate,
    Expression<DateTime>? subscriptionEndDate,
    Expression<int>? remainingClasses,
    Expression<int>? totalClasses,
    Expression<double>? monthlyFee,
    Expression<DateTime>? lastPaymentDate,
    Expression<DateTime>? nextPaymentDate,
    Expression<double>? progressPercentage,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (trainerId != null) 'trainer_id': trainerId,
      if (status != null) 'status': status,
      if (subscriptionType != null) 'subscription_type': subscriptionType,
      if (subscriptionStartDate != null)
        'subscription_start_date': subscriptionStartDate,
      if (subscriptionEndDate != null)
        'subscription_end_date': subscriptionEndDate,
      if (remainingClasses != null) 'remaining_classes': remainingClasses,
      if (totalClasses != null) 'total_classes': totalClasses,
      if (monthlyFee != null) 'monthly_fee': monthlyFee,
      if (lastPaymentDate != null) 'last_payment_date': lastPaymentDate,
      if (nextPaymentDate != null) 'next_payment_date': nextPaymentDate,
      if (progressPercentage != null) 'progress_percentage': progressPercentage,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int>? trainerId,
      Value<StudentStatus>? status,
      Value<SubscriptionType>? subscriptionType,
      Value<DateTime>? subscriptionStartDate,
      Value<DateTime>? subscriptionEndDate,
      Value<int>? remainingClasses,
      Value<int>? totalClasses,
      Value<double>? monthlyFee,
      Value<DateTime?>? lastPaymentDate,
      Value<DateTime>? nextPaymentDate,
      Value<double>? progressPercentage,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return StudentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      trainerId: trainerId ?? this.trainerId,
      status: status ?? this.status,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      remainingClasses: remainingClasses ?? this.remainingClasses,
      totalClasses: totalClasses ?? this.totalClasses,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (trainerId.present) {
      map['trainer_id'] = Variable<int>(trainerId.value);
    }
    if (status.present) {
      map['status'] =
          Variable<String>($StudentsTable.$converterstatus.toSql(status.value));
    }
    if (subscriptionType.present) {
      map['subscription_type'] = Variable<String>($StudentsTable
          .$convertersubscriptionType
          .toSql(subscriptionType.value));
    }
    if (subscriptionStartDate.present) {
      map['subscription_start_date'] =
          Variable<DateTime>(subscriptionStartDate.value);
    }
    if (subscriptionEndDate.present) {
      map['subscription_end_date'] =
          Variable<DateTime>(subscriptionEndDate.value);
    }
    if (remainingClasses.present) {
      map['remaining_classes'] = Variable<int>(remainingClasses.value);
    }
    if (totalClasses.present) {
      map['total_classes'] = Variable<int>(totalClasses.value);
    }
    if (monthlyFee.present) {
      map['monthly_fee'] = Variable<double>(monthlyFee.value);
    }
    if (lastPaymentDate.present) {
      map['last_payment_date'] = Variable<DateTime>(lastPaymentDate.value);
    }
    if (nextPaymentDate.present) {
      map['next_payment_date'] = Variable<DateTime>(nextPaymentDate.value);
    }
    if (progressPercentage.present) {
      map['progress_percentage'] = Variable<double>(progressPercentage.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trainerId: $trainerId, ')
          ..write('status: $status, ')
          ..write('subscriptionType: $subscriptionType, ')
          ..write('subscriptionStartDate: $subscriptionStartDate, ')
          ..write('subscriptionEndDate: $subscriptionEndDate, ')
          ..write('remainingClasses: $remainingClasses, ')
          ..write('totalClasses: $totalClasses, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('lastPaymentDate: $lastPaymentDate, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, DbPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _trainerIdMeta =
      const VerificationMeta('trainerId');
  @override
  late final GeneratedColumn<int> trainerId = GeneratedColumn<int>(
      'trainer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentStatus>($PaymentsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String>
      paymentMethod = GeneratedColumn<String>(
              'payment_method', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentMethod>($PaymentsTable.$converterpaymentMethod);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        studentId,
        trainerId,
        amount,
        status,
        paymentMethod,
        description,
        paymentDate,
        dueDate,
        transactionId,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<DbPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('trainer_id')) {
      context.handle(_trainerIdMeta,
          trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta));
    } else if (isInserting) {
      context.missing(_trainerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      trainerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trainer_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      status: $PaymentsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      paymentMethod: $PaymentsTable.$converterpaymentMethod.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}payment_method'])!),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentStatus, String, String> $converterstatus =
      const EnumNameConverter<PaymentStatus>(PaymentStatus.values);
  static JsonTypeConverter2<PaymentMethod, String, String>
      $converterpaymentMethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
}

class DbPayment extends DataClass implements Insertable<DbPayment> {
  final int id;
  final int studentId;
  final int trainerId;
  final double amount;
  final PaymentStatus status;
  final PaymentMethod paymentMethod;
  final String description;
  final DateTime paymentDate;
  final DateTime dueDate;
  final String? transactionId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbPayment(
      {required this.id,
      required this.studentId,
      required this.trainerId,
      required this.amount,
      required this.status,
      required this.paymentMethod,
      required this.description,
      required this.paymentDate,
      required this.dueDate,
      this.transactionId,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['trainer_id'] = Variable<int>(trainerId);
    map['amount'] = Variable<double>(amount);
    {
      map['status'] =
          Variable<String>($PaymentsTable.$converterstatus.toSql(status));
    }
    {
      map['payment_method'] = Variable<String>(
          $PaymentsTable.$converterpaymentMethod.toSql(paymentMethod));
    }
    map['description'] = Variable<String>(description);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      trainerId: Value(trainerId),
      amount: Value(amount),
      status: Value(status),
      paymentMethod: Value(paymentMethod),
      description: Value(description),
      paymentDate: Value(paymentDate),
      dueDate: Value(dueDate),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPayment(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      trainerId: serializer.fromJson<int>(json['trainerId']),
      amount: serializer.fromJson<double>(json['amount']),
      status: $PaymentsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      paymentMethod: $PaymentsTable.$converterpaymentMethod
          .fromJson(serializer.fromJson<String>(json['paymentMethod'])),
      description: serializer.fromJson<String>(json['description']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'trainerId': serializer.toJson<int>(trainerId),
      'amount': serializer.toJson<double>(amount),
      'status': serializer
          .toJson<String>($PaymentsTable.$converterstatus.toJson(status)),
      'paymentMethod': serializer.toJson<String>(
          $PaymentsTable.$converterpaymentMethod.toJson(paymentMethod)),
      'description': serializer.toJson<String>(description),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'transactionId': serializer.toJson<String?>(transactionId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbPayment copyWith(
          {int? id,
          int? studentId,
          int? trainerId,
          double? amount,
          PaymentStatus? status,
          PaymentMethod? paymentMethod,
          String? description,
          DateTime? paymentDate,
          DateTime? dueDate,
          Value<String?> transactionId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbPayment(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        trainerId: trainerId ?? this.trainerId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        description: description ?? this.description,
        paymentDate: paymentDate ?? this.paymentDate,
        dueDate: dueDate ?? this.dueDate,
        transactionId:
            transactionId.present ? transactionId.value : this.transactionId,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbPayment copyWithCompanion(PaymentsCompanion data) {
    return DbPayment(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      status: data.status.present ? data.status.value : this.status,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      description:
          data.description.present ? data.description.value : this.description,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbPayment(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('trainerId: $trainerId, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('description: $description, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('transactionId: $transactionId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      studentId,
      trainerId,
      amount,
      status,
      paymentMethod,
      description,
      paymentDate,
      dueDate,
      transactionId,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPayment &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.trainerId == this.trainerId &&
          other.amount == this.amount &&
          other.status == this.status &&
          other.paymentMethod == this.paymentMethod &&
          other.description == this.description &&
          other.paymentDate == this.paymentDate &&
          other.dueDate == this.dueDate &&
          other.transactionId == this.transactionId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentsCompanion extends UpdateCompanion<DbPayment> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> trainerId;
  final Value<double> amount;
  final Value<PaymentStatus> status;
  final Value<PaymentMethod> paymentMethod;
  final Value<String> description;
  final Value<DateTime> paymentDate;
  final Value<DateTime> dueDate;
  final Value<String?> transactionId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.trainerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int trainerId,
    required double amount,
    required PaymentStatus status,
    required PaymentMethod paymentMethod,
    required String description,
    required DateTime paymentDate,
    required DateTime dueDate,
    this.transactionId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : studentId = Value(studentId),
        trainerId = Value(trainerId),
        amount = Value(amount),
        status = Value(status),
        paymentMethod = Value(paymentMethod),
        description = Value(description),
        paymentDate = Value(paymentDate),
        dueDate = Value(dueDate);
  static Insertable<DbPayment> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? trainerId,
    Expression<double>? amount,
    Expression<String>? status,
    Expression<String>? paymentMethod,
    Expression<String>? description,
    Expression<DateTime>? paymentDate,
    Expression<DateTime>? dueDate,
    Expression<String>? transactionId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (trainerId != null) 'trainer_id': trainerId,
      if (amount != null) 'amount': amount,
      if (status != null) 'status': status,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (description != null) 'description': description,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (dueDate != null) 'due_date': dueDate,
      if (transactionId != null) 'transaction_id': transactionId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? trainerId,
      Value<double>? amount,
      Value<PaymentStatus>? status,
      Value<PaymentMethod>? paymentMethod,
      Value<String>? description,
      Value<DateTime>? paymentDate,
      Value<DateTime>? dueDate,
      Value<String?>? transactionId,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      trainerId: trainerId ?? this.trainerId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      description: description ?? this.description,
      paymentDate: paymentDate ?? this.paymentDate,
      dueDate: dueDate ?? this.dueDate,
      transactionId: transactionId ?? this.transactionId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (trainerId.present) {
      map['trainer_id'] = Variable<int>(trainerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (status.present) {
      map['status'] =
          Variable<String>($PaymentsTable.$converterstatus.toSql(status.value));
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(
          $PaymentsTable.$converterpaymentMethod.toSql(paymentMethod.value));
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('trainerId: $trainerId, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('description: $description, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('transactionId: $transactionId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines
    with TableInfo<$RoutinesTable, DbRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<DifficultyLevel, String>
      difficulty = GeneratedColumn<String>('difficulty', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DifficultyLevel>($RoutinesTable.$converterdifficulty);
  static const VerificationMeta _exerciseCountMeta =
      const VerificationMeta('exerciseCount');
  @override
  late final GeneratedColumn<int> exerciseCount = GeneratedColumn<int>(
      'exercise_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
      'created_by', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<RoutineStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RoutineStatus>($RoutinesTable.$converterstatus);
  static const VerificationMeta _exercisesJsonMeta =
      const VerificationMeta('exercisesJson');
  @override
  late final GeneratedColumn<String> exercisesJson = GeneratedColumn<String>(
      'exercises_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        category,
        durationMinutes,
        difficulty,
        exerciseCount,
        createdBy,
        status,
        exercisesJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(Insertable<DbRoutine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('exercise_count')) {
      context.handle(
          _exerciseCountMeta,
          exerciseCount.isAcceptableOrUnknown(
              data['exercise_count']!, _exerciseCountMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('exercises_json')) {
      context.handle(
          _exercisesJsonMeta,
          exercisesJson.isAcceptableOrUnknown(
              data['exercises_json']!, _exercisesJsonMeta));
    } else if (isInserting) {
      context.missing(_exercisesJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRoutine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      difficulty: $RoutinesTable.$converterdifficulty.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!),
      exerciseCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_count'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_by'])!,
      status: $RoutinesTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      exercisesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercises_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DifficultyLevel, String, String>
      $converterdifficulty =
      const EnumNameConverter<DifficultyLevel>(DifficultyLevel.values);
  static JsonTypeConverter2<RoutineStatus, String, String> $converterstatus =
      const EnumNameConverter<RoutineStatus>(RoutineStatus.values);
}

class DbRoutine extends DataClass implements Insertable<DbRoutine> {
  final int id;
  final String name;
  final String description;
  final String category;
  final int durationMinutes;
  final DifficultyLevel difficulty;
  final int exerciseCount;
  final int createdBy;
  final RoutineStatus status;
  final String exercisesJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbRoutine(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.durationMinutes,
      required this.difficulty,
      required this.exerciseCount,
      required this.createdBy,
      required this.status,
      required this.exercisesJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    {
      map['difficulty'] = Variable<String>(
          $RoutinesTable.$converterdifficulty.toSql(difficulty));
    }
    map['exercise_count'] = Variable<int>(exerciseCount);
    map['created_by'] = Variable<int>(createdBy);
    {
      map['status'] =
          Variable<String>($RoutinesTable.$converterstatus.toSql(status));
    }
    map['exercises_json'] = Variable<String>(exercisesJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      category: Value(category),
      durationMinutes: Value(durationMinutes),
      difficulty: Value(difficulty),
      exerciseCount: Value(exerciseCount),
      createdBy: Value(createdBy),
      status: Value(status),
      exercisesJson: Value(exercisesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbRoutine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRoutine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      difficulty: $RoutinesTable.$converterdifficulty
          .fromJson(serializer.fromJson<String>(json['difficulty'])),
      exerciseCount: serializer.fromJson<int>(json['exerciseCount']),
      createdBy: serializer.fromJson<int>(json['createdBy']),
      status: $RoutinesTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      exercisesJson: serializer.fromJson<String>(json['exercisesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'difficulty': serializer.toJson<String>(
          $RoutinesTable.$converterdifficulty.toJson(difficulty)),
      'exerciseCount': serializer.toJson<int>(exerciseCount),
      'createdBy': serializer.toJson<int>(createdBy),
      'status': serializer
          .toJson<String>($RoutinesTable.$converterstatus.toJson(status)),
      'exercisesJson': serializer.toJson<String>(exercisesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbRoutine copyWith(
          {int? id,
          String? name,
          String? description,
          String? category,
          int? durationMinutes,
          DifficultyLevel? difficulty,
          int? exerciseCount,
          int? createdBy,
          RoutineStatus? status,
          String? exercisesJson,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbRoutine(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        difficulty: difficulty ?? this.difficulty,
        exerciseCount: exerciseCount ?? this.exerciseCount,
        createdBy: createdBy ?? this.createdBy,
        status: status ?? this.status,
        exercisesJson: exercisesJson ?? this.exercisesJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbRoutine copyWithCompanion(RoutinesCompanion data) {
    return DbRoutine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      exerciseCount: data.exerciseCount.present
          ? data.exerciseCount.value
          : this.exerciseCount,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      status: data.status.present ? data.status.value : this.status,
      exercisesJson: data.exercisesJson.present
          ? data.exercisesJson.value
          : this.exercisesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbRoutine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('exerciseCount: $exerciseCount, ')
          ..write('createdBy: $createdBy, ')
          ..write('status: $status, ')
          ..write('exercisesJson: $exercisesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      category,
      durationMinutes,
      difficulty,
      exerciseCount,
      createdBy,
      status,
      exercisesJson,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRoutine &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.durationMinutes == this.durationMinutes &&
          other.difficulty == this.difficulty &&
          other.exerciseCount == this.exerciseCount &&
          other.createdBy == this.createdBy &&
          other.status == this.status &&
          other.exercisesJson == this.exercisesJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutinesCompanion extends UpdateCompanion<DbRoutine> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> category;
  final Value<int> durationMinutes;
  final Value<DifficultyLevel> difficulty;
  final Value<int> exerciseCount;
  final Value<int> createdBy;
  final Value<RoutineStatus> status;
  final Value<String> exercisesJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.exerciseCount = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.status = const Value.absent(),
    this.exercisesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String category,
    required int durationMinutes,
    required DifficultyLevel difficulty,
    this.exerciseCount = const Value.absent(),
    required int createdBy,
    required RoutineStatus status,
    required String exercisesJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        category = Value(category),
        durationMinutes = Value(durationMinutes),
        difficulty = Value(difficulty),
        createdBy = Value(createdBy),
        status = Value(status),
        exercisesJson = Value(exercisesJson);
  static Insertable<DbRoutine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? durationMinutes,
    Expression<String>? difficulty,
    Expression<int>? exerciseCount,
    Expression<int>? createdBy,
    Expression<String>? status,
    Expression<String>? exercisesJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (difficulty != null) 'difficulty': difficulty,
      if (exerciseCount != null) 'exercise_count': exerciseCount,
      if (createdBy != null) 'created_by': createdBy,
      if (status != null) 'status': status,
      if (exercisesJson != null) 'exercises_json': exercisesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RoutinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String>? category,
      Value<int>? durationMinutes,
      Value<DifficultyLevel>? difficulty,
      Value<int>? exerciseCount,
      Value<int>? createdBy,
      Value<RoutineStatus>? status,
      Value<String>? exercisesJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      difficulty: difficulty ?? this.difficulty,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      createdBy: createdBy ?? this.createdBy,
      status: status ?? this.status,
      exercisesJson: exercisesJson ?? this.exercisesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(
          $RoutinesTable.$converterdifficulty.toSql(difficulty.value));
    }
    if (exerciseCount.present) {
      map['exercise_count'] = Variable<int>(exerciseCount.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (status.present) {
      map['status'] =
          Variable<String>($RoutinesTable.$converterstatus.toSql(status.value));
    }
    if (exercisesJson.present) {
      map['exercises_json'] = Variable<String>(exercisesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('exerciseCount: $exerciseCount, ')
          ..write('createdBy: $createdBy, ')
          ..write('status: $status, ')
          ..write('exercisesJson: $exercisesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentRoutinesTable extends StudentRoutines
    with TableInfo<$StudentRoutinesTable, DbStudentRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentRoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES routines (id)'));
  static const VerificationMeta _trainerIdMeta =
      const VerificationMeta('trainerId');
  @override
  late final GeneratedColumn<int> trainerId = GeneratedColumn<int>(
      'trainer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _assignedDateMeta =
      const VerificationMeta('assignedDate');
  @override
  late final GeneratedColumn<DateTime> assignedDate = GeneratedColumn<DateTime>(
      'assigned_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _scheduledDateMeta =
      const VerificationMeta('scheduledDate');
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>('scheduled_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedDateMeta =
      const VerificationMeta('completedDate');
  @override
  late final GeneratedColumn<DateTime> completedDate =
      GeneratedColumn<DateTime>('completed_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<RoutineStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RoutineStatus>($StudentRoutinesTable.$converterstatus);
  static const VerificationMeta _progressPercentageMeta =
      const VerificationMeta('progressPercentage');
  @override
  late final GeneratedColumn<double> progressPercentage =
      GeneratedColumn<double>('progress_percentage', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _completedSessionsMeta =
      const VerificationMeta('completedSessions');
  @override
  late final GeneratedColumn<int> completedSessions = GeneratedColumn<int>(
      'completed_sessions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalSessionsMeta =
      const VerificationMeta('totalSessions');
  @override
  late final GeneratedColumn<int> totalSessions = GeneratedColumn<int>(
      'total_sessions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        studentId,
        routineId,
        trainerId,
        assignedDate,
        scheduledDate,
        startDate,
        completedDate,
        status,
        progressPercentage,
        completedSessions,
        totalSessions,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_routines';
  @override
  VerificationContext validateIntegrity(Insertable<DbStudentRoutine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('trainer_id')) {
      context.handle(_trainerIdMeta,
          trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta));
    } else if (isInserting) {
      context.missing(_trainerIdMeta);
    }
    if (data.containsKey('assigned_date')) {
      context.handle(
          _assignedDateMeta,
          assignedDate.isAcceptableOrUnknown(
              data['assigned_date']!, _assignedDateMeta));
    } else if (isInserting) {
      context.missing(_assignedDateMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
          _scheduledDateMeta,
          scheduledDate.isAcceptableOrUnknown(
              data['scheduled_date']!, _scheduledDateMeta));
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('completed_date')) {
      context.handle(
          _completedDateMeta,
          completedDate.isAcceptableOrUnknown(
              data['completed_date']!, _completedDateMeta));
    }
    if (data.containsKey('progress_percentage')) {
      context.handle(
          _progressPercentageMeta,
          progressPercentage.isAcceptableOrUnknown(
              data['progress_percentage']!, _progressPercentageMeta));
    }
    if (data.containsKey('completed_sessions')) {
      context.handle(
          _completedSessionsMeta,
          completedSessions.isAcceptableOrUnknown(
              data['completed_sessions']!, _completedSessionsMeta));
    }
    if (data.containsKey('total_sessions')) {
      context.handle(
          _totalSessionsMeta,
          totalSessions.isAcceptableOrUnknown(
              data['total_sessions']!, _totalSessionsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbStudentRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbStudentRoutine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}routine_id'])!,
      trainerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trainer_id'])!,
      assignedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}assigned_date'])!,
      scheduledDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_date'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      completedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completed_date']),
      status: $StudentRoutinesTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      progressPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}progress_percentage'])!,
      completedSessions: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}completed_sessions'])!,
      totalSessions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sessions'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StudentRoutinesTable createAlias(String alias) {
    return $StudentRoutinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RoutineStatus, String, String> $converterstatus =
      const EnumNameConverter<RoutineStatus>(RoutineStatus.values);
}

class DbStudentRoutine extends DataClass
    implements Insertable<DbStudentRoutine> {
  final int id;
  final int studentId;
  final int routineId;
  final int trainerId;
  final DateTime assignedDate;
  final DateTime scheduledDate;
  final DateTime? startDate;
  final DateTime? completedDate;
  final RoutineStatus status;
  final double progressPercentage;
  final int completedSessions;
  final int totalSessions;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbStudentRoutine(
      {required this.id,
      required this.studentId,
      required this.routineId,
      required this.trainerId,
      required this.assignedDate,
      required this.scheduledDate,
      this.startDate,
      this.completedDate,
      required this.status,
      required this.progressPercentage,
      required this.completedSessions,
      required this.totalSessions,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['routine_id'] = Variable<int>(routineId);
    map['trainer_id'] = Variable<int>(trainerId);
    map['assigned_date'] = Variable<DateTime>(assignedDate);
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || completedDate != null) {
      map['completed_date'] = Variable<DateTime>(completedDate);
    }
    {
      map['status'] = Variable<String>(
          $StudentRoutinesTable.$converterstatus.toSql(status));
    }
    map['progress_percentage'] = Variable<double>(progressPercentage);
    map['completed_sessions'] = Variable<int>(completedSessions);
    map['total_sessions'] = Variable<int>(totalSessions);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentRoutinesCompanion toCompanion(bool nullToAbsent) {
    return StudentRoutinesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      routineId: Value(routineId),
      trainerId: Value(trainerId),
      assignedDate: Value(assignedDate),
      scheduledDate: Value(scheduledDate),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      completedDate: completedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDate),
      status: Value(status),
      progressPercentage: Value(progressPercentage),
      completedSessions: Value(completedSessions),
      totalSessions: Value(totalSessions),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbStudentRoutine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbStudentRoutine(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      routineId: serializer.fromJson<int>(json['routineId']),
      trainerId: serializer.fromJson<int>(json['trainerId']),
      assignedDate: serializer.fromJson<DateTime>(json['assignedDate']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      completedDate: serializer.fromJson<DateTime?>(json['completedDate']),
      status: $StudentRoutinesTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      progressPercentage:
          serializer.fromJson<double>(json['progressPercentage']),
      completedSessions: serializer.fromJson<int>(json['completedSessions']),
      totalSessions: serializer.fromJson<int>(json['totalSessions']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'routineId': serializer.toJson<int>(routineId),
      'trainerId': serializer.toJson<int>(trainerId),
      'assignedDate': serializer.toJson<DateTime>(assignedDate),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'completedDate': serializer.toJson<DateTime?>(completedDate),
      'status': serializer.toJson<String>(
          $StudentRoutinesTable.$converterstatus.toJson(status)),
      'progressPercentage': serializer.toJson<double>(progressPercentage),
      'completedSessions': serializer.toJson<int>(completedSessions),
      'totalSessions': serializer.toJson<int>(totalSessions),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbStudentRoutine copyWith(
          {int? id,
          int? studentId,
          int? routineId,
          int? trainerId,
          DateTime? assignedDate,
          DateTime? scheduledDate,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> completedDate = const Value.absent(),
          RoutineStatus? status,
          double? progressPercentage,
          int? completedSessions,
          int? totalSessions,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbStudentRoutine(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        routineId: routineId ?? this.routineId,
        trainerId: trainerId ?? this.trainerId,
        assignedDate: assignedDate ?? this.assignedDate,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        startDate: startDate.present ? startDate.value : this.startDate,
        completedDate:
            completedDate.present ? completedDate.value : this.completedDate,
        status: status ?? this.status,
        progressPercentage: progressPercentage ?? this.progressPercentage,
        completedSessions: completedSessions ?? this.completedSessions,
        totalSessions: totalSessions ?? this.totalSessions,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbStudentRoutine copyWithCompanion(StudentRoutinesCompanion data) {
    return DbStudentRoutine(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      assignedDate: data.assignedDate.present
          ? data.assignedDate.value
          : this.assignedDate,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      completedDate: data.completedDate.present
          ? data.completedDate.value
          : this.completedDate,
      status: data.status.present ? data.status.value : this.status,
      progressPercentage: data.progressPercentage.present
          ? data.progressPercentage.value
          : this.progressPercentage,
      completedSessions: data.completedSessions.present
          ? data.completedSessions.value
          : this.completedSessions,
      totalSessions: data.totalSessions.present
          ? data.totalSessions.value
          : this.totalSessions,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbStudentRoutine(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('routineId: $routineId, ')
          ..write('trainerId: $trainerId, ')
          ..write('assignedDate: $assignedDate, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('startDate: $startDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('status: $status, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('completedSessions: $completedSessions, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      studentId,
      routineId,
      trainerId,
      assignedDate,
      scheduledDate,
      startDate,
      completedDate,
      status,
      progressPercentage,
      completedSessions,
      totalSessions,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbStudentRoutine &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.routineId == this.routineId &&
          other.trainerId == this.trainerId &&
          other.assignedDate == this.assignedDate &&
          other.scheduledDate == this.scheduledDate &&
          other.startDate == this.startDate &&
          other.completedDate == this.completedDate &&
          other.status == this.status &&
          other.progressPercentage == this.progressPercentage &&
          other.completedSessions == this.completedSessions &&
          other.totalSessions == this.totalSessions &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentRoutinesCompanion extends UpdateCompanion<DbStudentRoutine> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> routineId;
  final Value<int> trainerId;
  final Value<DateTime> assignedDate;
  final Value<DateTime> scheduledDate;
  final Value<DateTime?> startDate;
  final Value<DateTime?> completedDate;
  final Value<RoutineStatus> status;
  final Value<double> progressPercentage;
  final Value<int> completedSessions;
  final Value<int> totalSessions;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudentRoutinesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.trainerId = const Value.absent(),
    this.assignedDate = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.status = const Value.absent(),
    this.progressPercentage = const Value.absent(),
    this.completedSessions = const Value.absent(),
    this.totalSessions = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentRoutinesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int routineId,
    required int trainerId,
    required DateTime assignedDate,
    required DateTime scheduledDate,
    this.startDate = const Value.absent(),
    this.completedDate = const Value.absent(),
    required RoutineStatus status,
    this.progressPercentage = const Value.absent(),
    this.completedSessions = const Value.absent(),
    this.totalSessions = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : studentId = Value(studentId),
        routineId = Value(routineId),
        trainerId = Value(trainerId),
        assignedDate = Value(assignedDate),
        scheduledDate = Value(scheduledDate),
        status = Value(status);
  static Insertable<DbStudentRoutine> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? routineId,
    Expression<int>? trainerId,
    Expression<DateTime>? assignedDate,
    Expression<DateTime>? scheduledDate,
    Expression<DateTime>? startDate,
    Expression<DateTime>? completedDate,
    Expression<String>? status,
    Expression<double>? progressPercentage,
    Expression<int>? completedSessions,
    Expression<int>? totalSessions,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (routineId != null) 'routine_id': routineId,
      if (trainerId != null) 'trainer_id': trainerId,
      if (assignedDate != null) 'assigned_date': assignedDate,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (startDate != null) 'start_date': startDate,
      if (completedDate != null) 'completed_date': completedDate,
      if (status != null) 'status': status,
      if (progressPercentage != null) 'progress_percentage': progressPercentage,
      if (completedSessions != null) 'completed_sessions': completedSessions,
      if (totalSessions != null) 'total_sessions': totalSessions,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentRoutinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? routineId,
      Value<int>? trainerId,
      Value<DateTime>? assignedDate,
      Value<DateTime>? scheduledDate,
      Value<DateTime?>? startDate,
      Value<DateTime?>? completedDate,
      Value<RoutineStatus>? status,
      Value<double>? progressPercentage,
      Value<int>? completedSessions,
      Value<int>? totalSessions,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return StudentRoutinesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      routineId: routineId ?? this.routineId,
      trainerId: trainerId ?? this.trainerId,
      assignedDate: assignedDate ?? this.assignedDate,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startDate: startDate ?? this.startDate,
      completedDate: completedDate ?? this.completedDate,
      status: status ?? this.status,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      completedSessions: completedSessions ?? this.completedSessions,
      totalSessions: totalSessions ?? this.totalSessions,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (trainerId.present) {
      map['trainer_id'] = Variable<int>(trainerId.value);
    }
    if (assignedDate.present) {
      map['assigned_date'] = Variable<DateTime>(assignedDate.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (completedDate.present) {
      map['completed_date'] = Variable<DateTime>(completedDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $StudentRoutinesTable.$converterstatus.toSql(status.value));
    }
    if (progressPercentage.present) {
      map['progress_percentage'] = Variable<double>(progressPercentage.value);
    }
    if (completedSessions.present) {
      map['completed_sessions'] = Variable<int>(completedSessions.value);
    }
    if (totalSessions.present) {
      map['total_sessions'] = Variable<int>(totalSessions.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('routineId: $routineId, ')
          ..write('trainerId: $trainerId, ')
          ..write('assignedDate: $assignedDate, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('startDate: $startDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('status: $status, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('completedSessions: $completedSessions, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserStatsTable extends UserStats
    with TableInfo<$UserStatsTable, UserStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _heartRateMeta =
      const VerificationMeta('heartRate');
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
      'heart_rate', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _workoutMinutesMeta =
      const VerificationMeta('workoutMinutes');
  @override
  late final GeneratedColumn<int> workoutMinutes = GeneratedColumn<int>(
      'workout_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _workoutsCompletedMeta =
      const VerificationMeta('workoutsCompleted');
  @override
  late final GeneratedColumn<int> workoutsCompleted = GeneratedColumn<int>(
      'workouts_completed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        calories,
        heartRate,
        weight,
        workoutMinutes,
        workoutsCompleted,
        steps,
        date,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_stats';
  @override
  VerificationContext validateIntegrity(Insertable<UserStat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('heart_rate')) {
      context.handle(_heartRateMeta,
          heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('workout_minutes')) {
      context.handle(
          _workoutMinutesMeta,
          workoutMinutes.isAcceptableOrUnknown(
              data['workout_minutes']!, _workoutMinutesMeta));
    }
    if (data.containsKey('workouts_completed')) {
      context.handle(
          _workoutsCompletedMeta,
          workoutsCompleted.isAcceptableOrUnknown(
              data['workouts_completed']!, _workoutsCompletedMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories'])!,
      heartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      workoutMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_minutes'])!,
      workoutsCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}workouts_completed'])!,
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserStatsTable createAlias(String alias) {
    return $UserStatsTable(attachedDatabase, alias);
  }
}

class UserStat extends DataClass implements Insertable<UserStat> {
  final int id;
  final int userId;
  final int calories;
  final int heartRate;
  final double weight;
  final int workoutMinutes;
  final int workoutsCompleted;
  final int steps;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserStat(
      {required this.id,
      required this.userId,
      required this.calories,
      required this.heartRate,
      required this.weight,
      required this.workoutMinutes,
      required this.workoutsCompleted,
      required this.steps,
      required this.date,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['calories'] = Variable<int>(calories);
    map['heart_rate'] = Variable<int>(heartRate);
    map['weight'] = Variable<double>(weight);
    map['workout_minutes'] = Variable<int>(workoutMinutes);
    map['workouts_completed'] = Variable<int>(workoutsCompleted);
    map['steps'] = Variable<int>(steps);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserStatsCompanion toCompanion(bool nullToAbsent) {
    return UserStatsCompanion(
      id: Value(id),
      userId: Value(userId),
      calories: Value(calories),
      heartRate: Value(heartRate),
      weight: Value(weight),
      workoutMinutes: Value(workoutMinutes),
      workoutsCompleted: Value(workoutsCompleted),
      steps: Value(steps),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserStat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStat(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      calories: serializer.fromJson<int>(json['calories']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      weight: serializer.fromJson<double>(json['weight']),
      workoutMinutes: serializer.fromJson<int>(json['workoutMinutes']),
      workoutsCompleted: serializer.fromJson<int>(json['workoutsCompleted']),
      steps: serializer.fromJson<int>(json['steps']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'calories': serializer.toJson<int>(calories),
      'heartRate': serializer.toJson<int>(heartRate),
      'weight': serializer.toJson<double>(weight),
      'workoutMinutes': serializer.toJson<int>(workoutMinutes),
      'workoutsCompleted': serializer.toJson<int>(workoutsCompleted),
      'steps': serializer.toJson<int>(steps),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserStat copyWith(
          {int? id,
          int? userId,
          int? calories,
          int? heartRate,
          double? weight,
          int? workoutMinutes,
          int? workoutsCompleted,
          int? steps,
          DateTime? date,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserStat(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        calories: calories ?? this.calories,
        heartRate: heartRate ?? this.heartRate,
        weight: weight ?? this.weight,
        workoutMinutes: workoutMinutes ?? this.workoutMinutes,
        workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
        steps: steps ?? this.steps,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserStat copyWithCompanion(UserStatsCompanion data) {
    return UserStat(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      calories: data.calories.present ? data.calories.value : this.calories,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      weight: data.weight.present ? data.weight.value : this.weight,
      workoutMinutes: data.workoutMinutes.present
          ? data.workoutMinutes.value
          : this.workoutMinutes,
      workoutsCompleted: data.workoutsCompleted.present
          ? data.workoutsCompleted.value
          : this.workoutsCompleted,
      steps: data.steps.present ? data.steps.value : this.steps,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStat(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('calories: $calories, ')
          ..write('heartRate: $heartRate, ')
          ..write('weight: $weight, ')
          ..write('workoutMinutes: $workoutMinutes, ')
          ..write('workoutsCompleted: $workoutsCompleted, ')
          ..write('steps: $steps, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, calories, heartRate, weight,
      workoutMinutes, workoutsCompleted, steps, date, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStat &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.calories == this.calories &&
          other.heartRate == this.heartRate &&
          other.weight == this.weight &&
          other.workoutMinutes == this.workoutMinutes &&
          other.workoutsCompleted == this.workoutsCompleted &&
          other.steps == this.steps &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserStatsCompanion extends UpdateCompanion<UserStat> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> calories;
  final Value<int> heartRate;
  final Value<double> weight;
  final Value<int> workoutMinutes;
  final Value<int> workoutsCompleted;
  final Value<int> steps;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserStatsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.calories = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.weight = const Value.absent(),
    this.workoutMinutes = const Value.absent(),
    this.workoutsCompleted = const Value.absent(),
    this.steps = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserStatsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.calories = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.weight = const Value.absent(),
    this.workoutMinutes = const Value.absent(),
    this.workoutsCompleted = const Value.absent(),
    this.steps = const Value.absent(),
    required DateTime date,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date);
  static Insertable<UserStat> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? calories,
    Expression<int>? heartRate,
    Expression<double>? weight,
    Expression<int>? workoutMinutes,
    Expression<int>? workoutsCompleted,
    Expression<int>? steps,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (calories != null) 'calories': calories,
      if (heartRate != null) 'heart_rate': heartRate,
      if (weight != null) 'weight': weight,
      if (workoutMinutes != null) 'workout_minutes': workoutMinutes,
      if (workoutsCompleted != null) 'workouts_completed': workoutsCompleted,
      if (steps != null) 'steps': steps,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserStatsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int>? calories,
      Value<int>? heartRate,
      Value<double>? weight,
      Value<int>? workoutMinutes,
      Value<int>? workoutsCompleted,
      Value<int>? steps,
      Value<DateTime>? date,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserStatsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      calories: calories ?? this.calories,
      heartRate: heartRate ?? this.heartRate,
      weight: weight ?? this.weight,
      workoutMinutes: workoutMinutes ?? this.workoutMinutes,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      steps: steps ?? this.steps,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (workoutMinutes.present) {
      map['workout_minutes'] = Variable<int>(workoutMinutes.value);
    }
    if (workoutsCompleted.present) {
      map['workouts_completed'] = Variable<int>(workoutsCompleted.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStatsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('calories: $calories, ')
          ..write('heartRate: $heartRate, ')
          ..write('weight: $weight, ')
          ..write('workoutMinutes: $workoutMinutes, ')
          ..write('workoutsCompleted: $workoutsCompleted, ')
          ..write('steps: $steps, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyProgressTable extends DailyProgress
    with TableInfo<$DailyProgressTable, DailyProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, date, calories, steps, weight, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_progress';
  @override
  VerificationContext validateIntegrity(Insertable<DailyProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories'])!,
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyProgressTable createAlias(String alias) {
    return $DailyProgressTable(attachedDatabase, alias);
  }
}

class DailyProgressData extends DataClass
    implements Insertable<DailyProgressData> {
  final int id;
  final int userId;
  final DateTime date;
  final int calories;
  final int steps;
  final double weight;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyProgressData(
      {required this.id,
      required this.userId,
      required this.date,
      required this.calories,
      required this.steps,
      required this.weight,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['date'] = Variable<DateTime>(date);
    map['calories'] = Variable<int>(calories);
    map['steps'] = Variable<int>(steps);
    map['weight'] = Variable<double>(weight);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyProgressCompanion toCompanion(bool nullToAbsent) {
    return DailyProgressCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      calories: Value(calories),
      steps: Value(steps),
      weight: Value(weight),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyProgressData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      calories: serializer.fromJson<int>(json['calories']),
      steps: serializer.fromJson<int>(json['steps']),
      weight: serializer.fromJson<double>(json['weight']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'date': serializer.toJson<DateTime>(date),
      'calories': serializer.toJson<int>(calories),
      'steps': serializer.toJson<int>(steps),
      'weight': serializer.toJson<double>(weight),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyProgressData copyWith(
          {int? id,
          int? userId,
          DateTime? date,
          int? calories,
          int? steps,
          double? weight,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DailyProgressData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        calories: calories ?? this.calories,
        steps: steps ?? this.steps,
        weight: weight ?? this.weight,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyProgressData copyWithCompanion(DailyProgressCompanion data) {
    return DailyProgressData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      calories: data.calories.present ? data.calories.value : this.calories,
      steps: data.steps.present ? data.steps.value : this.steps,
      weight: data.weight.present ? data.weight.value : this.weight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('calories: $calories, ')
          ..write('steps: $steps, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, date, calories, steps, weight, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyProgressData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.calories == this.calories &&
          other.steps == this.steps &&
          other.weight == this.weight &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyProgressCompanion extends UpdateCompanion<DailyProgressData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> date;
  final Value<int> calories;
  final Value<int> steps;
  final Value<double> weight;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DailyProgressCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.calories = const Value.absent(),
    this.steps = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyProgressCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required DateTime date,
    this.calories = const Value.absent(),
    this.steps = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date);
  static Insertable<DailyProgressData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? date,
    Expression<int>? calories,
    Expression<int>? steps,
    Expression<double>? weight,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (calories != null) 'calories': calories,
      if (steps != null) 'steps': steps,
      if (weight != null) 'weight': weight,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<DateTime>? date,
      Value<int>? calories,
      Value<int>? steps,
      Value<double>? weight,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return DailyProgressCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      calories: calories ?? this.calories,
      steps: steps ?? this.steps,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('calories: $calories, ')
          ..write('steps: $steps, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, DbWorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES routines (id)'));
  static const VerificationMeta _sessionDateMeta =
      const VerificationMeta('sessionDate');
  @override
  late final GeneratedColumn<DateTime> sessionDate = GeneratedColumn<DateTime>(
      'session_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<double> caloriesBurned = GeneratedColumn<double>(
      'calories_burned', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _overallRatingMeta =
      const VerificationMeta('overallRating');
  @override
  late final GeneratedColumn<double> overallRating = GeneratedColumn<double>(
      'overall_rating', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutSessionStatus, String>
      status = GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WorkoutSessionStatus>(
              $WorkoutSessionsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        studentId,
        routineId,
        sessionDate,
        durationMinutes,
        caloriesBurned,
        overallRating,
        notes,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<DbWorkoutSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
          _sessionDateMeta,
          sessionDate.isAcceptableOrUnknown(
              data['session_date']!, _sessionDateMeta));
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
          _caloriesBurnedMeta,
          caloriesBurned.isAcceptableOrUnknown(
              data['calories_burned']!, _caloriesBurnedMeta));
    }
    if (data.containsKey('overall_rating')) {
      context.handle(
          _overallRatingMeta,
          overallRating.isAcceptableOrUnknown(
              data['overall_rating']!, _overallRatingMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbWorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbWorkoutSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}routine_id'])!,
      sessionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}session_date'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      caloriesBurned: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}calories_burned'])!,
      overallRating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}overall_rating'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: $WorkoutSessionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkoutSessionStatus, String, String>
      $converterstatus = const EnumNameConverter<WorkoutSessionStatus>(
          WorkoutSessionStatus.values);
}

class DbWorkoutSession extends DataClass
    implements Insertable<DbWorkoutSession> {
  final int id;
  final int studentId;
  final int routineId;
  final DateTime sessionDate;
  final int durationMinutes;
  final double caloriesBurned;
  final double overallRating;
  final String? notes;
  final WorkoutSessionStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbWorkoutSession(
      {required this.id,
      required this.studentId,
      required this.routineId,
      required this.sessionDate,
      required this.durationMinutes,
      required this.caloriesBurned,
      required this.overallRating,
      this.notes,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['routine_id'] = Variable<int>(routineId);
    map['session_date'] = Variable<DateTime>(sessionDate);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['calories_burned'] = Variable<double>(caloriesBurned);
    map['overall_rating'] = Variable<double>(overallRating);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['status'] = Variable<String>(
          $WorkoutSessionsTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      routineId: Value(routineId),
      sessionDate: Value(sessionDate),
      durationMinutes: Value(durationMinutes),
      caloriesBurned: Value(caloriesBurned),
      overallRating: Value(overallRating),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbWorkoutSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbWorkoutSession(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      routineId: serializer.fromJson<int>(json['routineId']),
      sessionDate: serializer.fromJson<DateTime>(json['sessionDate']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      caloriesBurned: serializer.fromJson<double>(json['caloriesBurned']),
      overallRating: serializer.fromJson<double>(json['overallRating']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: $WorkoutSessionsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'routineId': serializer.toJson<int>(routineId),
      'sessionDate': serializer.toJson<DateTime>(sessionDate),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'caloriesBurned': serializer.toJson<double>(caloriesBurned),
      'overallRating': serializer.toJson<double>(overallRating),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(
          $WorkoutSessionsTable.$converterstatus.toJson(status)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbWorkoutSession copyWith(
          {int? id,
          int? studentId,
          int? routineId,
          DateTime? sessionDate,
          int? durationMinutes,
          double? caloriesBurned,
          double? overallRating,
          Value<String?> notes = const Value.absent(),
          WorkoutSessionStatus? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbWorkoutSession(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        routineId: routineId ?? this.routineId,
        sessionDate: sessionDate ?? this.sessionDate,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        caloriesBurned: caloriesBurned ?? this.caloriesBurned,
        overallRating: overallRating ?? this.overallRating,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbWorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return DbWorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      sessionDate:
          data.sessionDate.present ? data.sessionDate.value : this.sessionDate,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      overallRating: data.overallRating.present
          ? data.overallRating.value
          : this.overallRating,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbWorkoutSession(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('routineId: $routineId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('overallRating: $overallRating, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      studentId,
      routineId,
      sessionDate,
      durationMinutes,
      caloriesBurned,
      overallRating,
      notes,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbWorkoutSession &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.routineId == this.routineId &&
          other.sessionDate == this.sessionDate &&
          other.durationMinutes == this.durationMinutes &&
          other.caloriesBurned == this.caloriesBurned &&
          other.overallRating == this.overallRating &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutSessionsCompanion extends UpdateCompanion<DbWorkoutSession> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> routineId;
  final Value<DateTime> sessionDate;
  final Value<int> durationMinutes;
  final Value<double> caloriesBurned;
  final Value<double> overallRating;
  final Value<String?> notes;
  final Value<WorkoutSessionStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.overallRating = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int routineId,
    required DateTime sessionDate,
    required int durationMinutes,
    this.caloriesBurned = const Value.absent(),
    this.overallRating = const Value.absent(),
    this.notes = const Value.absent(),
    required WorkoutSessionStatus status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : studentId = Value(studentId),
        routineId = Value(routineId),
        sessionDate = Value(sessionDate),
        durationMinutes = Value(durationMinutes),
        status = Value(status);
  static Insertable<DbWorkoutSession> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? routineId,
    Expression<DateTime>? sessionDate,
    Expression<int>? durationMinutes,
    Expression<double>? caloriesBurned,
    Expression<double>? overallRating,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (routineId != null) 'routine_id': routineId,
      if (sessionDate != null) 'session_date': sessionDate,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (overallRating != null) 'overall_rating': overallRating,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutSessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? routineId,
      Value<DateTime>? sessionDate,
      Value<int>? durationMinutes,
      Value<double>? caloriesBurned,
      Value<double>? overallRating,
      Value<String?>? notes,
      Value<WorkoutSessionStatus>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      routineId: routineId ?? this.routineId,
      sessionDate: sessionDate ?? this.sessionDate,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      overallRating: overallRating ?? this.overallRating,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<DateTime>(sessionDate.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<double>(caloriesBurned.value);
    }
    if (overallRating.present) {
      map['overall_rating'] = Variable<double>(overallRating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $WorkoutSessionsTable.$converterstatus.toSql(status.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('routineId: $routineId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('overallRating: $overallRating, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSessionsTable extends ExerciseSessions
    with TableInfo<$ExerciseSessionsTable, DbExerciseSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutSessionIdMeta =
      const VerificationMeta('workoutSessionId');
  @override
  late final GeneratedColumn<int> workoutSessionId = GeneratedColumn<int>(
      'workout_session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_sessions (id)'));
  static const VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
      'exercise_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseDescriptionMeta =
      const VerificationMeta('exerciseDescription');
  @override
  late final GeneratedColumn<String> exerciseDescription =
      GeneratedColumn<String>('exercise_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _restTimeSecondsMeta =
      const VerificationMeta('restTimeSeconds');
  @override
  late final GeneratedColumn<int> restTimeSeconds = GeneratedColumn<int>(
      'rest_time_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<int> percentage = GeneratedColumn<int>(
      'percentage', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workoutSessionId,
        exerciseName,
        exerciseDescription,
        sets,
        reps,
        restTimeSeconds,
        weightKg,
        percentage,
        durationSeconds,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<DbExerciseSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_session_id')) {
      context.handle(
          _workoutSessionIdMeta,
          workoutSessionId.isAcceptableOrUnknown(
              data['workout_session_id']!, _workoutSessionIdMeta));
    } else if (isInserting) {
      context.missing(_workoutSessionIdMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name']!, _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('exercise_description')) {
      context.handle(
          _exerciseDescriptionMeta,
          exerciseDescription.isAcceptableOrUnknown(
              data['exercise_description']!, _exerciseDescriptionMeta));
    } else if (isInserting) {
      context.missing(_exerciseDescriptionMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
          _setsMeta, sets.isAcceptableOrUnknown(data['sets']!, _setsMeta));
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('rest_time_seconds')) {
      context.handle(
          _restTimeSecondsMeta,
          restTimeSeconds.isAcceptableOrUnknown(
              data['rest_time_seconds']!, _restTimeSecondsMeta));
    } else if (isInserting) {
      context.missing(_restTimeSecondsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbExerciseSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbExerciseSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutSessionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}workout_session_id'])!,
      exerciseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_name'])!,
      exerciseDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}exercise_description'])!,
      sets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sets'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      restTimeSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_time_seconds'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}percentage']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExerciseSessionsTable createAlias(String alias) {
    return $ExerciseSessionsTable(attachedDatabase, alias);
  }
}

class DbExerciseSession extends DataClass
    implements Insertable<DbExerciseSession> {
  final int id;
  final int workoutSessionId;
  final String exerciseName;
  final String exerciseDescription;
  final int sets;
  final int reps;
  final int restTimeSeconds;
  final double? weightKg;
  final int? percentage;
  final int? durationSeconds;
  final String? notes;
  final DateTime createdAt;
  const DbExerciseSession(
      {required this.id,
      required this.workoutSessionId,
      required this.exerciseName,
      required this.exerciseDescription,
      required this.sets,
      required this.reps,
      required this.restTimeSeconds,
      this.weightKg,
      this.percentage,
      this.durationSeconds,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_session_id'] = Variable<int>(workoutSessionId);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['exercise_description'] = Variable<String>(exerciseDescription);
    map['sets'] = Variable<int>(sets);
    map['reps'] = Variable<int>(reps);
    map['rest_time_seconds'] = Variable<int>(restTimeSeconds);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<int>(percentage);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExerciseSessionsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSessionsCompanion(
      id: Value(id),
      workoutSessionId: Value(workoutSessionId),
      exerciseName: Value(exerciseName),
      exerciseDescription: Value(exerciseDescription),
      sets: Value(sets),
      reps: Value(reps),
      restTimeSeconds: Value(restTimeSeconds),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory DbExerciseSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbExerciseSession(
      id: serializer.fromJson<int>(json['id']),
      workoutSessionId: serializer.fromJson<int>(json['workoutSessionId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      exerciseDescription:
          serializer.fromJson<String>(json['exerciseDescription']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int>(json['reps']),
      restTimeSeconds: serializer.fromJson<int>(json['restTimeSeconds']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      percentage: serializer.fromJson<int?>(json['percentage']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutSessionId': serializer.toJson<int>(workoutSessionId),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'exerciseDescription': serializer.toJson<String>(exerciseDescription),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int>(reps),
      'restTimeSeconds': serializer.toJson<int>(restTimeSeconds),
      'weightKg': serializer.toJson<double?>(weightKg),
      'percentage': serializer.toJson<int?>(percentage),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbExerciseSession copyWith(
          {int? id,
          int? workoutSessionId,
          String? exerciseName,
          String? exerciseDescription,
          int? sets,
          int? reps,
          int? restTimeSeconds,
          Value<double?> weightKg = const Value.absent(),
          Value<int?> percentage = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      DbExerciseSession(
        id: id ?? this.id,
        workoutSessionId: workoutSessionId ?? this.workoutSessionId,
        exerciseName: exerciseName ?? this.exerciseName,
        exerciseDescription: exerciseDescription ?? this.exerciseDescription,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        restTimeSeconds: restTimeSeconds ?? this.restTimeSeconds,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        percentage: percentage.present ? percentage.value : this.percentage,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  DbExerciseSession copyWithCompanion(ExerciseSessionsCompanion data) {
    return DbExerciseSession(
      id: data.id.present ? data.id.value : this.id,
      workoutSessionId: data.workoutSessionId.present
          ? data.workoutSessionId.value
          : this.workoutSessionId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      exerciseDescription: data.exerciseDescription.present
          ? data.exerciseDescription.value
          : this.exerciseDescription,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      restTimeSeconds: data.restTimeSeconds.present
          ? data.restTimeSeconds.value
          : this.restTimeSeconds,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbExerciseSession(')
          ..write('id: $id, ')
          ..write('workoutSessionId: $workoutSessionId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('exerciseDescription: $exerciseDescription, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('weightKg: $weightKg, ')
          ..write('percentage: $percentage, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workoutSessionId,
      exerciseName,
      exerciseDescription,
      sets,
      reps,
      restTimeSeconds,
      weightKg,
      percentage,
      durationSeconds,
      notes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbExerciseSession &&
          other.id == this.id &&
          other.workoutSessionId == this.workoutSessionId &&
          other.exerciseName == this.exerciseName &&
          other.exerciseDescription == this.exerciseDescription &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.restTimeSeconds == this.restTimeSeconds &&
          other.weightKg == this.weightKg &&
          other.percentage == this.percentage &&
          other.durationSeconds == this.durationSeconds &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class ExerciseSessionsCompanion extends UpdateCompanion<DbExerciseSession> {
  final Value<int> id;
  final Value<int> workoutSessionId;
  final Value<String> exerciseName;
  final Value<String> exerciseDescription;
  final Value<int> sets;
  final Value<int> reps;
  final Value<int> restTimeSeconds;
  final Value<double?> weightKg;
  final Value<int?> percentage;
  final Value<int?> durationSeconds;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const ExerciseSessionsCompanion({
    this.id = const Value.absent(),
    this.workoutSessionId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.exerciseDescription = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.restTimeSeconds = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.percentage = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExerciseSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int workoutSessionId,
    required String exerciseName,
    required String exerciseDescription,
    required int sets,
    required int reps,
    required int restTimeSeconds,
    this.weightKg = const Value.absent(),
    this.percentage = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : workoutSessionId = Value(workoutSessionId),
        exerciseName = Value(exerciseName),
        exerciseDescription = Value(exerciseDescription),
        sets = Value(sets),
        reps = Value(reps),
        restTimeSeconds = Value(restTimeSeconds);
  static Insertable<DbExerciseSession> custom({
    Expression<int>? id,
    Expression<int>? workoutSessionId,
    Expression<String>? exerciseName,
    Expression<String>? exerciseDescription,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<int>? restTimeSeconds,
    Expression<double>? weightKg,
    Expression<int>? percentage,
    Expression<int>? durationSeconds,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutSessionId != null) 'workout_session_id': workoutSessionId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (exerciseDescription != null)
        'exercise_description': exerciseDescription,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (restTimeSeconds != null) 'rest_time_seconds': restTimeSeconds,
      if (weightKg != null) 'weight_kg': weightKg,
      if (percentage != null) 'percentage': percentage,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExerciseSessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? workoutSessionId,
      Value<String>? exerciseName,
      Value<String>? exerciseDescription,
      Value<int>? sets,
      Value<int>? reps,
      Value<int>? restTimeSeconds,
      Value<double?>? weightKg,
      Value<int?>? percentage,
      Value<int?>? durationSeconds,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return ExerciseSessionsCompanion(
      id: id ?? this.id,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      exerciseName: exerciseName ?? this.exerciseName,
      exerciseDescription: exerciseDescription ?? this.exerciseDescription,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restTimeSeconds: restTimeSeconds ?? this.restTimeSeconds,
      weightKg: weightKg ?? this.weightKg,
      percentage: percentage ?? this.percentage,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutSessionId.present) {
      map['workout_session_id'] = Variable<int>(workoutSessionId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (exerciseDescription.present) {
      map['exercise_description'] = Variable<String>(exerciseDescription.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (restTimeSeconds.present) {
      map['rest_time_seconds'] = Variable<int>(restTimeSeconds.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<int>(percentage.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSessionsCompanion(')
          ..write('id: $id, ')
          ..write('workoutSessionId: $workoutSessionId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('exerciseDescription: $exerciseDescription, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('weightKg: $weightKg, ')
          ..write('percentage: $percentage, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetsTable extends ExerciseSets
    with TableInfo<$ExerciseSetsTable, DbExerciseSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseSessionIdMeta =
      const VerificationMeta('exerciseSessionId');
  @override
  late final GeneratedColumn<int> exerciseSessionId = GeneratedColumn<int>(
      'exercise_session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercise_sessions (id)'));
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<int> percentage = GeneratedColumn<int>(
      'percentage', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _restTimeSecondsMeta =
      const VerificationMeta('restTimeSeconds');
  @override
  late final GeneratedColumn<double> restTimeSeconds = GeneratedColumn<double>(
      'rest_time_seconds', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseSessionId,
        setNumber,
        reps,
        weightKg,
        percentage,
        durationSeconds,
        restTimeSeconds,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_sets';
  @override
  VerificationContext validateIntegrity(Insertable<DbExerciseSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_session_id')) {
      context.handle(
          _exerciseSessionIdMeta,
          exerciseSessionId.isAcceptableOrUnknown(
              data['exercise_session_id']!, _exerciseSessionIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseSessionIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('rest_time_seconds')) {
      context.handle(
          _restTimeSecondsMeta,
          restTimeSeconds.isAcceptableOrUnknown(
              data['rest_time_seconds']!, _restTimeSecondsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbExerciseSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbExerciseSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseSessionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}exercise_session_id'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}percentage']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      restTimeSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}rest_time_seconds']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExerciseSetsTable createAlias(String alias) {
    return $ExerciseSetsTable(attachedDatabase, alias);
  }
}

class DbExerciseSet extends DataClass implements Insertable<DbExerciseSet> {
  final int id;
  final int exerciseSessionId;
  final int setNumber;
  final int reps;
  final double? weightKg;
  final int? percentage;
  final int? durationSeconds;
  final double? restTimeSeconds;
  final String? notes;
  final DateTime createdAt;
  const DbExerciseSet(
      {required this.id,
      required this.exerciseSessionId,
      required this.setNumber,
      required this.reps,
      this.weightKg,
      this.percentage,
      this.durationSeconds,
      this.restTimeSeconds,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_session_id'] = Variable<int>(exerciseSessionId);
    map['set_number'] = Variable<int>(setNumber);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<int>(percentage);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || restTimeSeconds != null) {
      map['rest_time_seconds'] = Variable<double>(restTimeSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExerciseSetsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetsCompanion(
      id: Value(id),
      exerciseSessionId: Value(exerciseSessionId),
      setNumber: Value(setNumber),
      reps: Value(reps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      restTimeSeconds: restTimeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restTimeSeconds),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory DbExerciseSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbExerciseSet(
      id: serializer.fromJson<int>(json['id']),
      exerciseSessionId: serializer.fromJson<int>(json['exerciseSessionId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      percentage: serializer.fromJson<int?>(json['percentage']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      restTimeSeconds: serializer.fromJson<double?>(json['restTimeSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseSessionId': serializer.toJson<int>(exerciseSessionId),
      'setNumber': serializer.toJson<int>(setNumber),
      'reps': serializer.toJson<int>(reps),
      'weightKg': serializer.toJson<double?>(weightKg),
      'percentage': serializer.toJson<int?>(percentage),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'restTimeSeconds': serializer.toJson<double?>(restTimeSeconds),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbExerciseSet copyWith(
          {int? id,
          int? exerciseSessionId,
          int? setNumber,
          int? reps,
          Value<double?> weightKg = const Value.absent(),
          Value<int?> percentage = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<double?> restTimeSeconds = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      DbExerciseSet(
        id: id ?? this.id,
        exerciseSessionId: exerciseSessionId ?? this.exerciseSessionId,
        setNumber: setNumber ?? this.setNumber,
        reps: reps ?? this.reps,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        percentage: percentage.present ? percentage.value : this.percentage,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        restTimeSeconds: restTimeSeconds.present
            ? restTimeSeconds.value
            : this.restTimeSeconds,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  DbExerciseSet copyWithCompanion(ExerciseSetsCompanion data) {
    return DbExerciseSet(
      id: data.id.present ? data.id.value : this.id,
      exerciseSessionId: data.exerciseSessionId.present
          ? data.exerciseSessionId.value
          : this.exerciseSessionId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      restTimeSeconds: data.restTimeSeconds.present
          ? data.restTimeSeconds.value
          : this.restTimeSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbExerciseSet(')
          ..write('id: $id, ')
          ..write('exerciseSessionId: $exerciseSessionId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('percentage: $percentage, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseSessionId, setNumber, reps,
      weightKg, percentage, durationSeconds, restTimeSeconds, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbExerciseSet &&
          other.id == this.id &&
          other.exerciseSessionId == this.exerciseSessionId &&
          other.setNumber == this.setNumber &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.percentage == this.percentage &&
          other.durationSeconds == this.durationSeconds &&
          other.restTimeSeconds == this.restTimeSeconds &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class ExerciseSetsCompanion extends UpdateCompanion<DbExerciseSet> {
  final Value<int> id;
  final Value<int> exerciseSessionId;
  final Value<int> setNumber;
  final Value<int> reps;
  final Value<double?> weightKg;
  final Value<int?> percentage;
  final Value<int?> durationSeconds;
  final Value<double?> restTimeSeconds;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const ExerciseSetsCompanion({
    this.id = const Value.absent(),
    this.exerciseSessionId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.percentage = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.restTimeSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExerciseSetsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseSessionId,
    required int setNumber,
    required int reps,
    this.weightKg = const Value.absent(),
    this.percentage = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.restTimeSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : exerciseSessionId = Value(exerciseSessionId),
        setNumber = Value(setNumber),
        reps = Value(reps);
  static Insertable<DbExerciseSet> custom({
    Expression<int>? id,
    Expression<int>? exerciseSessionId,
    Expression<int>? setNumber,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? percentage,
    Expression<int>? durationSeconds,
    Expression<double>? restTimeSeconds,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseSessionId != null) 'exercise_session_id': exerciseSessionId,
      if (setNumber != null) 'set_number': setNumber,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (percentage != null) 'percentage': percentage,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (restTimeSeconds != null) 'rest_time_seconds': restTimeSeconds,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExerciseSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? exerciseSessionId,
      Value<int>? setNumber,
      Value<int>? reps,
      Value<double?>? weightKg,
      Value<int?>? percentage,
      Value<int?>? durationSeconds,
      Value<double?>? restTimeSeconds,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return ExerciseSetsCompanion(
      id: id ?? this.id,
      exerciseSessionId: exerciseSessionId ?? this.exerciseSessionId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      percentage: percentage ?? this.percentage,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      restTimeSeconds: restTimeSeconds ?? this.restTimeSeconds,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseSessionId.present) {
      map['exercise_session_id'] = Variable<int>(exerciseSessionId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<int>(percentage.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (restTimeSeconds.present) {
      map['rest_time_seconds'] = Variable<double>(restTimeSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseSessionId: $exerciseSessionId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('percentage: $percentage, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TrainerProductsTable extends TrainerProducts
    with TableInfo<$TrainerProductsTable, DbTrainerProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainerProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _trainerIdMeta =
      const VerificationMeta('trainerId');
  @override
  late final GeneratedColumn<int> trainerId = GeneratedColumn<int>(
      'trainer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Currency, String> currency =
      GeneratedColumn<String>('currency', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('eur'))
          .withConverter<Currency>($TrainerProductsTable.$convertercurrency);
  static const VerificationMeta _durationInDaysMeta =
      const VerificationMeta('durationInDays');
  @override
  late final GeneratedColumn<int> durationInDays = GeneratedColumn<int>(
      'duration_in_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  @override
  late final GeneratedColumnWithTypeConverter<ProductCategory, String>
      category = GeneratedColumn<String>('category', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ProductCategory>(
              $TrainerProductsTable.$convertercategory);
  static const VerificationMeta _featuresMeta =
      const VerificationMeta('features');
  @override
  late final GeneratedColumn<String> features = GeneratedColumn<String>(
      'features', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPopularMeta =
      const VerificationMeta('isPopular');
  @override
  late final GeneratedColumn<bool> isPopular = GeneratedColumn<bool>(
      'is_popular', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_popular" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<ProductStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ProductStatus>($TrainerProductsTable.$converterstatus);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        trainerId,
        name,
        description,
        price,
        currency,
        durationInDays,
        category,
        features,
        isPopular,
        status,
        imageUrl,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trainer_products';
  @override
  VerificationContext validateIntegrity(Insertable<DbTrainerProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trainer_id')) {
      context.handle(_trainerIdMeta,
          trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta));
    } else if (isInserting) {
      context.missing(_trainerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('duration_in_days')) {
      context.handle(
          _durationInDaysMeta,
          durationInDays.isAcceptableOrUnknown(
              data['duration_in_days']!, _durationInDaysMeta));
    }
    if (data.containsKey('features')) {
      context.handle(_featuresMeta,
          features.isAcceptableOrUnknown(data['features']!, _featuresMeta));
    } else if (isInserting) {
      context.missing(_featuresMeta);
    }
    if (data.containsKey('is_popular')) {
      context.handle(_isPopularMeta,
          isPopular.isAcceptableOrUnknown(data['is_popular']!, _isPopularMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbTrainerProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbTrainerProduct(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      trainerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trainer_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      currency: $TrainerProductsTable.$convertercurrency.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}currency'])!),
      durationInDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_in_days'])!,
      category: $TrainerProductsTable.$convertercategory.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      features: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}features'])!,
      isPopular: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_popular'])!,
      status: $TrainerProductsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TrainerProductsTable createAlias(String alias) {
    return $TrainerProductsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Currency, String, String> $convertercurrency =
      const EnumNameConverter<Currency>(Currency.values);
  static JsonTypeConverter2<ProductCategory, String, String>
      $convertercategory =
      const EnumNameConverter<ProductCategory>(ProductCategory.values);
  static JsonTypeConverter2<ProductStatus, String, String> $converterstatus =
      const EnumNameConverter<ProductStatus>(ProductStatus.values);
}

class DbTrainerProduct extends DataClass
    implements Insertable<DbTrainerProduct> {
  final int id;
  final int trainerId;
  final String name;
  final String description;
  final double price;
  final Currency currency;
  final int durationInDays;
  final ProductCategory category;
  final String features;
  final bool isPopular;
  final ProductStatus status;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbTrainerProduct(
      {required this.id,
      required this.trainerId,
      required this.name,
      required this.description,
      required this.price,
      required this.currency,
      required this.durationInDays,
      required this.category,
      required this.features,
      required this.isPopular,
      required this.status,
      this.imageUrl,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trainer_id'] = Variable<int>(trainerId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    {
      map['currency'] = Variable<String>(
          $TrainerProductsTable.$convertercurrency.toSql(currency));
    }
    map['duration_in_days'] = Variable<int>(durationInDays);
    {
      map['category'] = Variable<String>(
          $TrainerProductsTable.$convertercategory.toSql(category));
    }
    map['features'] = Variable<String>(features);
    map['is_popular'] = Variable<bool>(isPopular);
    {
      map['status'] = Variable<String>(
          $TrainerProductsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrainerProductsCompanion toCompanion(bool nullToAbsent) {
    return TrainerProductsCompanion(
      id: Value(id),
      trainerId: Value(trainerId),
      name: Value(name),
      description: Value(description),
      price: Value(price),
      currency: Value(currency),
      durationInDays: Value(durationInDays),
      category: Value(category),
      features: Value(features),
      isPopular: Value(isPopular),
      status: Value(status),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbTrainerProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbTrainerProduct(
      id: serializer.fromJson<int>(json['id']),
      trainerId: serializer.fromJson<int>(json['trainerId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      currency: $TrainerProductsTable.$convertercurrency
          .fromJson(serializer.fromJson<String>(json['currency'])),
      durationInDays: serializer.fromJson<int>(json['durationInDays']),
      category: $TrainerProductsTable.$convertercategory
          .fromJson(serializer.fromJson<String>(json['category'])),
      features: serializer.fromJson<String>(json['features']),
      isPopular: serializer.fromJson<bool>(json['isPopular']),
      status: $TrainerProductsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trainerId': serializer.toJson<int>(trainerId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'currency': serializer.toJson<String>(
          $TrainerProductsTable.$convertercurrency.toJson(currency)),
      'durationInDays': serializer.toJson<int>(durationInDays),
      'category': serializer.toJson<String>(
          $TrainerProductsTable.$convertercategory.toJson(category)),
      'features': serializer.toJson<String>(features),
      'isPopular': serializer.toJson<bool>(isPopular),
      'status': serializer.toJson<String>(
          $TrainerProductsTable.$converterstatus.toJson(status)),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbTrainerProduct copyWith(
          {int? id,
          int? trainerId,
          String? name,
          String? description,
          double? price,
          Currency? currency,
          int? durationInDays,
          ProductCategory? category,
          String? features,
          bool? isPopular,
          ProductStatus? status,
          Value<String?> imageUrl = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DbTrainerProduct(
        id: id ?? this.id,
        trainerId: trainerId ?? this.trainerId,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        durationInDays: durationInDays ?? this.durationInDays,
        category: category ?? this.category,
        features: features ?? this.features,
        isPopular: isPopular ?? this.isPopular,
        status: status ?? this.status,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DbTrainerProduct copyWithCompanion(TrainerProductsCompanion data) {
    return DbTrainerProduct(
      id: data.id.present ? data.id.value : this.id,
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      price: data.price.present ? data.price.value : this.price,
      currency: data.currency.present ? data.currency.value : this.currency,
      durationInDays: data.durationInDays.present
          ? data.durationInDays.value
          : this.durationInDays,
      category: data.category.present ? data.category.value : this.category,
      features: data.features.present ? data.features.value : this.features,
      isPopular: data.isPopular.present ? data.isPopular.value : this.isPopular,
      status: data.status.present ? data.status.value : this.status,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbTrainerProduct(')
          ..write('id: $id, ')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('durationInDays: $durationInDays, ')
          ..write('category: $category, ')
          ..write('features: $features, ')
          ..write('isPopular: $isPopular, ')
          ..write('status: $status, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      trainerId,
      name,
      description,
      price,
      currency,
      durationInDays,
      category,
      features,
      isPopular,
      status,
      imageUrl,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbTrainerProduct &&
          other.id == this.id &&
          other.trainerId == this.trainerId &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.currency == this.currency &&
          other.durationInDays == this.durationInDays &&
          other.category == this.category &&
          other.features == this.features &&
          other.isPopular == this.isPopular &&
          other.status == this.status &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TrainerProductsCompanion extends UpdateCompanion<DbTrainerProduct> {
  final Value<int> id;
  final Value<int> trainerId;
  final Value<String> name;
  final Value<String> description;
  final Value<double> price;
  final Value<Currency> currency;
  final Value<int> durationInDays;
  final Value<ProductCategory> category;
  final Value<String> features;
  final Value<bool> isPopular;
  final Value<ProductStatus> status;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TrainerProductsCompanion({
    this.id = const Value.absent(),
    this.trainerId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.durationInDays = const Value.absent(),
    this.category = const Value.absent(),
    this.features = const Value.absent(),
    this.isPopular = const Value.absent(),
    this.status = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TrainerProductsCompanion.insert({
    this.id = const Value.absent(),
    required int trainerId,
    required String name,
    required String description,
    required double price,
    this.currency = const Value.absent(),
    this.durationInDays = const Value.absent(),
    required ProductCategory category,
    required String features,
    this.isPopular = const Value.absent(),
    required ProductStatus status,
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : trainerId = Value(trainerId),
        name = Value(name),
        description = Value(description),
        price = Value(price),
        category = Value(category),
        features = Value(features),
        status = Value(status);
  static Insertable<DbTrainerProduct> custom({
    Expression<int>? id,
    Expression<int>? trainerId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<String>? currency,
    Expression<int>? durationInDays,
    Expression<String>? category,
    Expression<String>? features,
    Expression<bool>? isPopular,
    Expression<String>? status,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trainerId != null) 'trainer_id': trainerId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (durationInDays != null) 'duration_in_days': durationInDays,
      if (category != null) 'category': category,
      if (features != null) 'features': features,
      if (isPopular != null) 'is_popular': isPopular,
      if (status != null) 'status': status,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TrainerProductsCompanion copyWith(
      {Value<int>? id,
      Value<int>? trainerId,
      Value<String>? name,
      Value<String>? description,
      Value<double>? price,
      Value<Currency>? currency,
      Value<int>? durationInDays,
      Value<ProductCategory>? category,
      Value<String>? features,
      Value<bool>? isPopular,
      Value<ProductStatus>? status,
      Value<String?>? imageUrl,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TrainerProductsCompanion(
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      durationInDays: durationInDays ?? this.durationInDays,
      category: category ?? this.category,
      features: features ?? this.features,
      isPopular: isPopular ?? this.isPopular,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trainerId.present) {
      map['trainer_id'] = Variable<int>(trainerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(
          $TrainerProductsTable.$convertercurrency.toSql(currency.value));
    }
    if (durationInDays.present) {
      map['duration_in_days'] = Variable<int>(durationInDays.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $TrainerProductsTable.$convertercategory.toSql(category.value));
    }
    if (features.present) {
      map['features'] = Variable<String>(features.value);
    }
    if (isPopular.present) {
      map['is_popular'] = Variable<bool>(isPopular.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $TrainerProductsTable.$converterstatus.toSql(status.value));
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainerProductsCompanion(')
          ..write('id: $id, ')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('durationInDays: $durationInDays, ')
          ..write('category: $category, ')
          ..write('features: $features, ')
          ..write('isPopular: $isPopular, ')
          ..write('status: $status, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $StudentRoutinesTable studentRoutines =
      $StudentRoutinesTable(this);
  late final $UserStatsTable userStats = $UserStatsTable(this);
  late final $DailyProgressTable dailyProgress = $DailyProgressTable(this);
  late final $WorkoutSessionsTable workoutSessions =
      $WorkoutSessionsTable(this);
  late final $ExerciseSessionsTable exerciseSessions =
      $ExerciseSessionsTable(this);
  late final $ExerciseSetsTable exerciseSets = $ExerciseSetsTable(this);
  late final $TrainerProductsTable trainerProducts =
      $TrainerProductsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        students,
        payments,
        routines,
        studentRoutines,
        userStats,
        dailyProgress,
        workoutSessions,
        exerciseSessions,
        exerciseSets,
        trainerProducts
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> city,
  Value<String> country,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> profileImageUrl,
  Value<String?> bio,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> height,
  Value<double?> weight,
  Value<String?> fitnessLevel,
  Value<String?> specializations,
  Value<double?> hourlyRate,
  Value<String?> certifications,
  Value<int?> yearsExperience,
  required UserRole role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> email,
  Value<String> password,
  Value<String> firstName,
  Value<String> lastName,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> city,
  Value<String> country,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> profileImageUrl,
  Value<String?> bio,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> height,
  Value<double?> weight,
  Value<String?> fitnessLevel,
  Value<String?> specializations,
  Value<double?> hourlyRate,
  Value<String?> certifications,
  Value<int?> yearsExperience,
  Value<UserRole> role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, DbUser> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentsTable, List<DbPayment>>
      _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.payments,
          aliasName: $_aliasNameGenerator(db.users.id, db.payments.trainerId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.trainerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RoutinesTable, List<DbRoutine>>
      _routinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.routines,
          aliasName: $_aliasNameGenerator(db.users.id, db.routines.createdBy));

  $$RoutinesTableProcessedTableManager get routinesRefs {
    final manager = $$RoutinesTableTableManager($_db, $_db.routines)
        .filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StudentRoutinesTable, List<DbStudentRoutine>>
      _studentRoutinesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentRoutines,
              aliasName: $_aliasNameGenerator(
                  db.users.id, db.studentRoutines.trainerId));

  $$StudentRoutinesTableProcessedTableManager get studentRoutinesRefs {
    final manager =
        $$StudentRoutinesTableTableManager($_db, $_db.studentRoutines)
            .filter((f) => f.trainerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentRoutinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserStatsTable, List<UserStat>>
      _userStatsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.userStats,
          aliasName: $_aliasNameGenerator(db.users.id, db.userStats.userId));

  $$UserStatsTableProcessedTableManager get userStatsRefs {
    final manager = $$UserStatsTableTableManager($_db, $_db.userStats)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userStatsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DailyProgressTable, List<DailyProgressData>>
      _dailyProgressRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dailyProgress,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.dailyProgress.userId));

  $$DailyProgressTableProcessedTableManager get dailyProgressRefs {
    final manager = $$DailyProgressTableTableManager($_db, $_db.dailyProgress)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyProgressRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TrainerProductsTable, List<DbTrainerProduct>>
      _trainerProductsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.trainerProducts,
              aliasName: $_aliasNameGenerator(
                  db.users.id, db.trainerProducts.trainerId));

  $$TrainerProductsTableProcessedTableManager get trainerProductsRefs {
    final manager =
        $$TrainerProductsTableTableManager($_db, $_db.trainerProducts)
            .filter((f) => f.trainerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_trainerProductsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileImageUrl => $composableBuilder(
      column: $table.profileImageUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fitnessLevel => $composableBuilder(
      column: $table.fitnessLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specializations => $composableBuilder(
      column: $table.specializations,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hourlyRate => $composableBuilder(
      column: $table.hourlyRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get certifications => $composableBuilder(
      column: $table.certifications,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get yearsExperience => $composableBuilder(
      column: $table.yearsExperience,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<UserRole, UserRole, String> get role =>
      $composableBuilder(
          column: $table.role,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> routinesRefs(
      Expression<bool> Function($$RoutinesTableFilterComposer f) f) {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableFilterComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> studentRoutinesRefs(
      Expression<bool> Function($$StudentRoutinesTableFilterComposer f) f) {
    final $$StudentRoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableFilterComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> userStatsRefs(
      Expression<bool> Function($$UserStatsTableFilterComposer f) f) {
    final $$UserStatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userStats,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserStatsTableFilterComposer(
              $db: $db,
              $table: $db.userStats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> dailyProgressRefs(
      Expression<bool> Function($$DailyProgressTableFilterComposer f) f) {
    final $$DailyProgressTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyProgress,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyProgressTableFilterComposer(
              $db: $db,
              $table: $db.dailyProgress,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> trainerProductsRefs(
      Expression<bool> Function($$TrainerProductsTableFilterComposer f) f) {
    final $$TrainerProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trainerProducts,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrainerProductsTableFilterComposer(
              $db: $db,
              $table: $db.trainerProducts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileImageUrl => $composableBuilder(
      column: $table.profileImageUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fitnessLevel => $composableBuilder(
      column: $table.fitnessLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specializations => $composableBuilder(
      column: $table.specializations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
      column: $table.hourlyRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get certifications => $composableBuilder(
      column: $table.certifications,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get yearsExperience => $composableBuilder(
      column: $table.yearsExperience,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get profileImageUrl => $composableBuilder(
      column: $table.profileImageUrl, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get fitnessLevel => $composableBuilder(
      column: $table.fitnessLevel, builder: (column) => column);

  GeneratedColumn<String> get specializations => $composableBuilder(
      column: $table.specializations, builder: (column) => column);

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
      column: $table.hourlyRate, builder: (column) => column);

  GeneratedColumn<String> get certifications => $composableBuilder(
      column: $table.certifications, builder: (column) => column);

  GeneratedColumn<int> get yearsExperience => $composableBuilder(
      column: $table.yearsExperience, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UserRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> routinesRefs<T extends Object>(
      Expression<T> Function($$RoutinesTableAnnotationComposer a) f) {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> studentRoutinesRefs<T extends Object>(
      Expression<T> Function($$StudentRoutinesTableAnnotationComposer a) f) {
    final $$StudentRoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> userStatsRefs<T extends Object>(
      Expression<T> Function($$UserStatsTableAnnotationComposer a) f) {
    final $$UserStatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userStats,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserStatsTableAnnotationComposer(
              $db: $db,
              $table: $db.userStats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> dailyProgressRefs<T extends Object>(
      Expression<T> Function($$DailyProgressTableAnnotationComposer a) f) {
    final $$DailyProgressTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyProgress,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyProgressTableAnnotationComposer(
              $db: $db,
              $table: $db.dailyProgress,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> trainerProductsRefs<T extends Object>(
      Expression<T> Function($$TrainerProductsTableAnnotationComposer a) f) {
    final $$TrainerProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trainerProducts,
        getReferencedColumn: (t) => t.trainerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrainerProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.trainerProducts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function(
        {bool paymentsRefs,
        bool routinesRefs,
        bool studentRoutinesRefs,
        bool userStatsRefs,
        bool dailyProgressRefs,
        bool trainerProductsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> profileImageUrl = const Value.absent(),
            Value<String?> bio = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String?> fitnessLevel = const Value.absent(),
            Value<String?> specializations = const Value.absent(),
            Value<double?> hourlyRate = const Value.absent(),
            Value<String?> certifications = const Value.absent(),
            Value<int?> yearsExperience = const Value.absent(),
            Value<UserRole> role = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            profileImageUrl: profileImageUrl,
            bio: bio,
            age: age,
            gender: gender,
            height: height,
            weight: weight,
            fitnessLevel: fitnessLevel,
            specializations: specializations,
            hourlyRate: hourlyRate,
            certifications: certifications,
            yearsExperience: yearsExperience,
            role: role,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String email,
            required String password,
            required String firstName,
            required String lastName,
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> profileImageUrl = const Value.absent(),
            Value<String?> bio = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String?> fitnessLevel = const Value.absent(),
            Value<String?> specializations = const Value.absent(),
            Value<double?> hourlyRate = const Value.absent(),
            Value<String?> certifications = const Value.absent(),
            Value<int?> yearsExperience = const Value.absent(),
            required UserRole role,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            profileImageUrl: profileImageUrl,
            bio: bio,
            age: age,
            gender: gender,
            height: height,
            weight: weight,
            fitnessLevel: fitnessLevel,
            specializations: specializations,
            hourlyRate: hourlyRate,
            certifications: certifications,
            yearsExperience: yearsExperience,
            role: role,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {paymentsRefs = false,
              routinesRefs = false,
              studentRoutinesRefs = false,
              userStatsRefs = false,
              dailyProgressRefs = false,
              trainerProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (paymentsRefs) db.payments,
                if (routinesRefs) db.routines,
                if (studentRoutinesRefs) db.studentRoutines,
                if (userStatsRefs) db.userStats,
                if (dailyProgressRefs) db.dailyProgress,
                if (trainerProductsRefs) db.trainerProducts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentsRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable, DbPayment>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trainerId == item.id),
                        typedResults: items),
                  if (routinesRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable, DbRoutine>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._routinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).routinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.createdBy == item.id),
                        typedResults: items),
                  if (studentRoutinesRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable,
                            DbStudentRoutine>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._studentRoutinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .studentRoutinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trainerId == item.id),
                        typedResults: items),
                  if (userStatsRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable, UserStat>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._userStatsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).userStatsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (dailyProgressRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable,
                            DailyProgressData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._dailyProgressRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .dailyProgressRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (trainerProductsRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable,
                            DbTrainerProduct>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._trainerProductsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .trainerProductsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trainerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function(
        {bool paymentsRefs,
        bool routinesRefs,
        bool studentRoutinesRefs,
        bool userStatsRefs,
        bool dailyProgressRefs,
        bool trainerProductsRefs})>;
typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required int userId,
  required int trainerId,
  required StudentStatus status,
  required SubscriptionType subscriptionType,
  required DateTime subscriptionStartDate,
  required DateTime subscriptionEndDate,
  Value<int> remainingClasses,
  Value<int> totalClasses,
  required double monthlyFee,
  Value<DateTime?> lastPaymentDate,
  required DateTime nextPaymentDate,
  Value<double> progressPercentage,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<int> trainerId,
  Value<StudentStatus> status,
  Value<SubscriptionType> subscriptionType,
  Value<DateTime> subscriptionStartDate,
  Value<DateTime> subscriptionEndDate,
  Value<int> remainingClasses,
  Value<int> totalClasses,
  Value<double> monthlyFee,
  Value<DateTime?> lastPaymentDate,
  Value<DateTime> nextPaymentDate,
  Value<double> progressPercentage,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, DbStudent> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.students.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _trainerIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.students.trainerId, db.users.id));

  $$UsersTableProcessedTableManager get trainerId {
    final $_column = $_itemColumn<int>('trainer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PaymentsTable, List<DbPayment>>
      _paymentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.payments,
              aliasName:
                  $_aliasNameGenerator(db.students.id, db.payments.studentId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StudentRoutinesTable, List<DbStudentRoutine>>
      _studentRoutinesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentRoutines,
              aliasName: $_aliasNameGenerator(
                  db.students.id, db.studentRoutines.studentId));

  $$StudentRoutinesTableProcessedTableManager get studentRoutinesRefs {
    final manager =
        $$StudentRoutinesTableTableManager($_db, $_db.studentRoutines)
            .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentRoutinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<DbWorkoutSession>>
      _workoutSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workoutSessions,
              aliasName: $_aliasNameGenerator(
                  db.students.id, db.workoutSessions.studentId));

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager =
        $$WorkoutSessionsTableTableManager($_db, $_db.workoutSessions)
            .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_workoutSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StudentStatus, StudentStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<SubscriptionType, SubscriptionType, String>
      get subscriptionType => $composableBuilder(
          column: $table.subscriptionType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get subscriptionStartDate => $composableBuilder(
      column: $table.subscriptionStartDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get subscriptionEndDate => $composableBuilder(
      column: $table.subscriptionEndDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remainingClasses => $composableBuilder(
      column: $table.remainingClasses,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalClasses => $composableBuilder(
      column: $table.totalClasses, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextPaymentDate => $composableBuilder(
      column: $table.nextPaymentDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get trainerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> studentRoutinesRefs(
      Expression<bool> Function($$StudentRoutinesTableFilterComposer f) f) {
    final $$StudentRoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableFilterComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutSessionsRefs(
      Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableFilterComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subscriptionType => $composableBuilder(
      column: $table.subscriptionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get subscriptionStartDate => $composableBuilder(
      column: $table.subscriptionStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get subscriptionEndDate => $composableBuilder(
      column: $table.subscriptionEndDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remainingClasses => $composableBuilder(
      column: $table.remainingClasses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalClasses => $composableBuilder(
      column: $table.totalClasses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextPaymentDate => $composableBuilder(
      column: $table.nextPaymentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get trainerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StudentStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubscriptionType, String>
      get subscriptionType => $composableBuilder(
          column: $table.subscriptionType, builder: (column) => column);

  GeneratedColumn<DateTime> get subscriptionStartDate => $composableBuilder(
      column: $table.subscriptionStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get subscriptionEndDate => $composableBuilder(
      column: $table.subscriptionEndDate, builder: (column) => column);

  GeneratedColumn<int> get remainingClasses => $composableBuilder(
      column: $table.remainingClasses, builder: (column) => column);

  GeneratedColumn<int> get totalClasses => $composableBuilder(
      column: $table.totalClasses, builder: (column) => column);

  GeneratedColumn<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextPaymentDate => $composableBuilder(
      column: $table.nextPaymentDate, builder: (column) => column);

  GeneratedColumn<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get trainerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> studentRoutinesRefs<T extends Object>(
      Expression<T> Function($$StudentRoutinesTableAnnotationComposer a) f) {
    final $$StudentRoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workoutSessionsRefs<T extends Object>(
      Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    DbStudent,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (DbStudent, $$StudentsTableReferences),
    DbStudent,
    PrefetchHooks Function(
        {bool userId,
        bool trainerId,
        bool paymentsRefs,
        bool studentRoutinesRefs,
        bool workoutSessionsRefs})> {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> trainerId = const Value.absent(),
            Value<StudentStatus> status = const Value.absent(),
            Value<SubscriptionType> subscriptionType = const Value.absent(),
            Value<DateTime> subscriptionStartDate = const Value.absent(),
            Value<DateTime> subscriptionEndDate = const Value.absent(),
            Value<int> remainingClasses = const Value.absent(),
            Value<int> totalClasses = const Value.absent(),
            Value<double> monthlyFee = const Value.absent(),
            Value<DateTime?> lastPaymentDate = const Value.absent(),
            Value<DateTime> nextPaymentDate = const Value.absent(),
            Value<double> progressPercentage = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            userId: userId,
            trainerId: trainerId,
            status: status,
            subscriptionType: subscriptionType,
            subscriptionStartDate: subscriptionStartDate,
            subscriptionEndDate: subscriptionEndDate,
            remainingClasses: remainingClasses,
            totalClasses: totalClasses,
            monthlyFee: monthlyFee,
            lastPaymentDate: lastPaymentDate,
            nextPaymentDate: nextPaymentDate,
            progressPercentage: progressPercentage,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required int trainerId,
            required StudentStatus status,
            required SubscriptionType subscriptionType,
            required DateTime subscriptionStartDate,
            required DateTime subscriptionEndDate,
            Value<int> remainingClasses = const Value.absent(),
            Value<int> totalClasses = const Value.absent(),
            required double monthlyFee,
            Value<DateTime?> lastPaymentDate = const Value.absent(),
            required DateTime nextPaymentDate,
            Value<double> progressPercentage = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            userId: userId,
            trainerId: trainerId,
            status: status,
            subscriptionType: subscriptionType,
            subscriptionStartDate: subscriptionStartDate,
            subscriptionEndDate: subscriptionEndDate,
            remainingClasses: remainingClasses,
            totalClasses: totalClasses,
            monthlyFee: monthlyFee,
            lastPaymentDate: lastPaymentDate,
            nextPaymentDate: nextPaymentDate,
            progressPercentage: progressPercentage,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StudentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userId = false,
              trainerId = false,
              paymentsRefs = false,
              studentRoutinesRefs = false,
              workoutSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (paymentsRefs) db.payments,
                if (studentRoutinesRefs) db.studentRoutines,
                if (workoutSessionsRefs) db.workoutSessions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$StudentsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$StudentsTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (trainerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trainerId,
                    referencedTable:
                        $$StudentsTableReferences._trainerIdTable(db),
                    referencedColumn:
                        $$StudentsTableReferences._trainerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentsRefs)
                    await $_getPrefetchedData<DbStudent, $StudentsTable,
                            DbPayment>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items),
                  if (studentRoutinesRefs)
                    await $_getPrefetchedData<DbStudent, $StudentsTable,
                            DbStudentRoutine>(
                        currentTable: table,
                        referencedTable: $$StudentsTableReferences
                            ._studentRoutinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .studentRoutinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items),
                  if (workoutSessionsRefs)
                    await $_getPrefetchedData<DbStudent, $StudentsTable,
                            DbWorkoutSession>(
                        currentTable: table,
                        referencedTable: $$StudentsTableReferences
                            ._workoutSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .workoutSessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentsTable,
    DbStudent,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (DbStudent, $$StudentsTableReferences),
    DbStudent,
    PrefetchHooks Function(
        {bool userId,
        bool trainerId,
        bool paymentsRefs,
        bool studentRoutinesRefs,
        bool workoutSessionsRefs})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int studentId,
  required int trainerId,
  required double amount,
  required PaymentStatus status,
  required PaymentMethod paymentMethod,
  required String description,
  required DateTime paymentDate,
  required DateTime dueDate,
  Value<String?> transactionId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> trainerId,
  Value<double> amount,
  Value<PaymentStatus> status,
  Value<PaymentMethod> paymentMethod,
  Value<String> description,
  Value<DateTime> paymentDate,
  Value<DateTime> dueDate,
  Value<String?> transactionId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, DbPayment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) => db.students
      .createAlias($_aliasNameGenerator(db.payments.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _trainerIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.payments.trainerId, db.users.id));

  $$UsersTableProcessedTableManager get trainerId {
    final $_column = $_itemColumn<int>('trainer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentStatus, PaymentStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String>
      get paymentMethod => $composableBuilder(
          column: $table.paymentMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get trainerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionId => $composableBuilder(
      column: $table.transactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get trainerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get paymentMethod =>
      $composableBuilder(
          column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get trainerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    DbPayment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (DbPayment, $$PaymentsTableReferences),
    DbPayment,
    PrefetchHooks Function({bool studentId, bool trainerId})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> trainerId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<PaymentStatus> status = const Value.absent(),
            Value<PaymentMethod> paymentMethod = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            studentId: studentId,
            trainerId: trainerId,
            amount: amount,
            status: status,
            paymentMethod: paymentMethod,
            description: description,
            paymentDate: paymentDate,
            dueDate: dueDate,
            transactionId: transactionId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int trainerId,
            required double amount,
            required PaymentStatus status,
            required PaymentMethod paymentMethod,
            required String description,
            required DateTime paymentDate,
            required DateTime dueDate,
            Value<String?> transactionId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            studentId: studentId,
            trainerId: trainerId,
            amount: amount,
            status: status,
            paymentMethod: paymentMethod,
            description: description,
            paymentDate: paymentDate,
            dueDate: dueDate,
            transactionId: transactionId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({studentId = false, trainerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$PaymentsTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (trainerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trainerId,
                    referencedTable:
                        $$PaymentsTableReferences._trainerIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._trainerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    DbPayment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (DbPayment, $$PaymentsTableReferences),
    DbPayment,
    PrefetchHooks Function({bool studentId, bool trainerId})>;
typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  required String category,
  required int durationMinutes,
  required DifficultyLevel difficulty,
  Value<int> exerciseCount,
  required int createdBy,
  required RoutineStatus status,
  required String exercisesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> category,
  Value<int> durationMinutes,
  Value<DifficultyLevel> difficulty,
  Value<int> exerciseCount,
  Value<int> createdBy,
  Value<RoutineStatus> status,
  Value<String> exercisesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, DbRoutine> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.routines.createdBy, db.users.id));

  $$UsersTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<int>('created_by')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StudentRoutinesTable, List<DbStudentRoutine>>
      _studentRoutinesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentRoutines,
              aliasName: $_aliasNameGenerator(
                  db.routines.id, db.studentRoutines.routineId));

  $$StudentRoutinesTableProcessedTableManager get studentRoutinesRefs {
    final manager =
        $$StudentRoutinesTableTableManager($_db, $_db.studentRoutines)
            .filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentRoutinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<DbWorkoutSession>>
      _workoutSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workoutSessions,
              aliasName: $_aliasNameGenerator(
                  db.routines.id, db.workoutSessions.routineId));

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager =
        $$WorkoutSessionsTableTableManager($_db, $_db.workoutSessions)
            .filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_workoutSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DifficultyLevel, DifficultyLevel, String>
      get difficulty => $composableBuilder(
          column: $table.difficulty,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get exerciseCount => $composableBuilder(
      column: $table.exerciseCount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RoutineStatus, RoutineStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> studentRoutinesRefs(
      Expression<bool> Function($$StudentRoutinesTableFilterComposer f) f) {
    final $$StudentRoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableFilterComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutSessionsRefs(
      Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableFilterComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseCount => $composableBuilder(
      column: $table.exerciseCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DifficultyLevel, String> get difficulty =>
      $composableBuilder(
          column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<int> get exerciseCount => $composableBuilder(
      column: $table.exerciseCount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoutineStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> studentRoutinesRefs<T extends Object>(
      Expression<T> Function($$StudentRoutinesTableAnnotationComposer a) f) {
    final $$StudentRoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentRoutines,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentRoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.studentRoutines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workoutSessionsRefs<T extends Object>(
      Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutinesTable,
    DbRoutine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (DbRoutine, $$RoutinesTableReferences),
    DbRoutine,
    PrefetchHooks Function(
        {bool createdBy, bool studentRoutinesRefs, bool workoutSessionsRefs})> {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DifficultyLevel> difficulty = const Value.absent(),
            Value<int> exerciseCount = const Value.absent(),
            Value<int> createdBy = const Value.absent(),
            Value<RoutineStatus> status = const Value.absent(),
            Value<String> exercisesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RoutinesCompanion(
            id: id,
            name: name,
            description: description,
            category: category,
            durationMinutes: durationMinutes,
            difficulty: difficulty,
            exerciseCount: exerciseCount,
            createdBy: createdBy,
            status: status,
            exercisesJson: exercisesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String description,
            required String category,
            required int durationMinutes,
            required DifficultyLevel difficulty,
            Value<int> exerciseCount = const Value.absent(),
            required int createdBy,
            required RoutineStatus status,
            required String exercisesJson,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RoutinesCompanion.insert(
            id: id,
            name: name,
            description: description,
            category: category,
            durationMinutes: durationMinutes,
            difficulty: difficulty,
            exerciseCount: exerciseCount,
            createdBy: createdBy,
            status: status,
            exercisesJson: exercisesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RoutinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {createdBy = false,
              studentRoutinesRefs = false,
              workoutSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentRoutinesRefs) db.studentRoutines,
                if (workoutSessionsRefs) db.workoutSessions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (createdBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.createdBy,
                    referencedTable:
                        $$RoutinesTableReferences._createdByTable(db),
                    referencedColumn:
                        $$RoutinesTableReferences._createdByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentRoutinesRefs)
                    await $_getPrefetchedData<DbRoutine, $RoutinesTable,
                            DbStudentRoutine>(
                        currentTable: table,
                        referencedTable: $$RoutinesTableReferences
                            ._studentRoutinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoutinesTableReferences(db, table, p0)
                                .studentRoutinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.routineId == item.id),
                        typedResults: items),
                  if (workoutSessionsRefs)
                    await $_getPrefetchedData<DbRoutine, $RoutinesTable,
                            DbWorkoutSession>(
                        currentTable: table,
                        referencedTable: $$RoutinesTableReferences
                            ._workoutSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoutinesTableReferences(db, table, p0)
                                .workoutSessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.routineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoutinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoutinesTable,
    DbRoutine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (DbRoutine, $$RoutinesTableReferences),
    DbRoutine,
    PrefetchHooks Function(
        {bool createdBy, bool studentRoutinesRefs, bool workoutSessionsRefs})>;
typedef $$StudentRoutinesTableCreateCompanionBuilder = StudentRoutinesCompanion
    Function({
  Value<int> id,
  required int studentId,
  required int routineId,
  required int trainerId,
  required DateTime assignedDate,
  required DateTime scheduledDate,
  Value<DateTime?> startDate,
  Value<DateTime?> completedDate,
  required RoutineStatus status,
  Value<double> progressPercentage,
  Value<int> completedSessions,
  Value<int> totalSessions,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$StudentRoutinesTableUpdateCompanionBuilder = StudentRoutinesCompanion
    Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> routineId,
  Value<int> trainerId,
  Value<DateTime> assignedDate,
  Value<DateTime> scheduledDate,
  Value<DateTime?> startDate,
  Value<DateTime?> completedDate,
  Value<RoutineStatus> status,
  Value<double> progressPercentage,
  Value<int> completedSessions,
  Value<int> totalSessions,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$StudentRoutinesTableReferences extends BaseReferences<
    _$AppDatabase, $StudentRoutinesTable, DbStudentRoutine> {
  $$StudentRoutinesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.studentRoutines.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias(
          $_aliasNameGenerator(db.studentRoutines.routineId, db.routines.id));

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutinesTableTableManager($_db, $_db.routines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _trainerIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.studentRoutines.trainerId, db.users.id));

  $$UsersTableProcessedTableManager get trainerId {
    final $_column = $_itemColumn<int>('trainer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StudentRoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentRoutinesTable> {
  $$StudentRoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get assignedDate => $composableBuilder(
      column: $table.assignedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RoutineStatus, RoutineStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedSessions => $composableBuilder(
      column: $table.completedSessions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableFilterComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get trainerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentRoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentRoutinesTable> {
  $$StudentRoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get assignedDate => $composableBuilder(
      column: $table.assignedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedSessions => $composableBuilder(
      column: $table.completedSessions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableOrderingComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get trainerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentRoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentRoutinesTable> {
  $$StudentRoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get assignedDate => $composableBuilder(
      column: $table.assignedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoutineStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progressPercentage => $composableBuilder(
      column: $table.progressPercentage, builder: (column) => column);

  GeneratedColumn<int> get completedSessions => $composableBuilder(
      column: $table.completedSessions, builder: (column) => column);

  GeneratedColumn<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get trainerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentRoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentRoutinesTable,
    DbStudentRoutine,
    $$StudentRoutinesTableFilterComposer,
    $$StudentRoutinesTableOrderingComposer,
    $$StudentRoutinesTableAnnotationComposer,
    $$StudentRoutinesTableCreateCompanionBuilder,
    $$StudentRoutinesTableUpdateCompanionBuilder,
    (DbStudentRoutine, $$StudentRoutinesTableReferences),
    DbStudentRoutine,
    PrefetchHooks Function({bool studentId, bool routineId, bool trainerId})> {
  $$StudentRoutinesTableTableManager(
      _$AppDatabase db, $StudentRoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentRoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentRoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentRoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> routineId = const Value.absent(),
            Value<int> trainerId = const Value.absent(),
            Value<DateTime> assignedDate = const Value.absent(),
            Value<DateTime> scheduledDate = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completedDate = const Value.absent(),
            Value<RoutineStatus> status = const Value.absent(),
            Value<double> progressPercentage = const Value.absent(),
            Value<int> completedSessions = const Value.absent(),
            Value<int> totalSessions = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentRoutinesCompanion(
            id: id,
            studentId: studentId,
            routineId: routineId,
            trainerId: trainerId,
            assignedDate: assignedDate,
            scheduledDate: scheduledDate,
            startDate: startDate,
            completedDate: completedDate,
            status: status,
            progressPercentage: progressPercentage,
            completedSessions: completedSessions,
            totalSessions: totalSessions,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int routineId,
            required int trainerId,
            required DateTime assignedDate,
            required DateTime scheduledDate,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completedDate = const Value.absent(),
            required RoutineStatus status,
            Value<double> progressPercentage = const Value.absent(),
            Value<int> completedSessions = const Value.absent(),
            Value<int> totalSessions = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentRoutinesCompanion.insert(
            id: id,
            studentId: studentId,
            routineId: routineId,
            trainerId: trainerId,
            assignedDate: assignedDate,
            scheduledDate: scheduledDate,
            startDate: startDate,
            completedDate: completedDate,
            status: status,
            progressPercentage: progressPercentage,
            completedSessions: completedSessions,
            totalSessions: totalSessions,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StudentRoutinesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentId = false, routineId = false, trainerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$StudentRoutinesTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$StudentRoutinesTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (routineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.routineId,
                    referencedTable:
                        $$StudentRoutinesTableReferences._routineIdTable(db),
                    referencedColumn:
                        $$StudentRoutinesTableReferences._routineIdTable(db).id,
                  ) as T;
                }
                if (trainerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trainerId,
                    referencedTable:
                        $$StudentRoutinesTableReferences._trainerIdTable(db),
                    referencedColumn:
                        $$StudentRoutinesTableReferences._trainerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StudentRoutinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentRoutinesTable,
    DbStudentRoutine,
    $$StudentRoutinesTableFilterComposer,
    $$StudentRoutinesTableOrderingComposer,
    $$StudentRoutinesTableAnnotationComposer,
    $$StudentRoutinesTableCreateCompanionBuilder,
    $$StudentRoutinesTableUpdateCompanionBuilder,
    (DbStudentRoutine, $$StudentRoutinesTableReferences),
    DbStudentRoutine,
    PrefetchHooks Function({bool studentId, bool routineId, bool trainerId})>;
typedef $$UserStatsTableCreateCompanionBuilder = UserStatsCompanion Function({
  Value<int> id,
  required int userId,
  Value<int> calories,
  Value<int> heartRate,
  Value<double> weight,
  Value<int> workoutMinutes,
  Value<int> workoutsCompleted,
  Value<int> steps,
  required DateTime date,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserStatsTableUpdateCompanionBuilder = UserStatsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<int> calories,
  Value<int> heartRate,
  Value<double> weight,
  Value<int> workoutMinutes,
  Value<int> workoutsCompleted,
  Value<int> steps,
  Value<DateTime> date,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UserStatsTableReferences
    extends BaseReferences<_$AppDatabase, $UserStatsTable, UserStat> {
  $$UserStatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.userStats.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserStatsTableFilterComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workoutMinutes => $composableBuilder(
      column: $table.workoutMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workoutsCompleted => $composableBuilder(
      column: $table.workoutsCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workoutMinutes => $composableBuilder(
      column: $table.workoutMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workoutsCompleted => $composableBuilder(
      column: $table.workoutsCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get workoutMinutes => $composableBuilder(
      column: $table.workoutMinutes, builder: (column) => column);

  GeneratedColumn<int> get workoutsCompleted => $composableBuilder(
      column: $table.workoutsCompleted, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserStatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserStatsTable,
    UserStat,
    $$UserStatsTableFilterComposer,
    $$UserStatsTableOrderingComposer,
    $$UserStatsTableAnnotationComposer,
    $$UserStatsTableCreateCompanionBuilder,
    $$UserStatsTableUpdateCompanionBuilder,
    (UserStat, $$UserStatsTableReferences),
    UserStat,
    PrefetchHooks Function({bool userId})> {
  $$UserStatsTableTableManager(_$AppDatabase db, $UserStatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> calories = const Value.absent(),
            Value<int> heartRate = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> workoutMinutes = const Value.absent(),
            Value<int> workoutsCompleted = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserStatsCompanion(
            id: id,
            userId: userId,
            calories: calories,
            heartRate: heartRate,
            weight: weight,
            workoutMinutes: workoutMinutes,
            workoutsCompleted: workoutsCompleted,
            steps: steps,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            Value<int> calories = const Value.absent(),
            Value<int> heartRate = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> workoutMinutes = const Value.absent(),
            Value<int> workoutsCompleted = const Value.absent(),
            Value<int> steps = const Value.absent(),
            required DateTime date,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserStatsCompanion.insert(
            id: id,
            userId: userId,
            calories: calories,
            heartRate: heartRate,
            weight: weight,
            workoutMinutes: workoutMinutes,
            workoutsCompleted: workoutsCompleted,
            steps: steps,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserStatsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserStatsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserStatsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserStatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserStatsTable,
    UserStat,
    $$UserStatsTableFilterComposer,
    $$UserStatsTableOrderingComposer,
    $$UserStatsTableAnnotationComposer,
    $$UserStatsTableCreateCompanionBuilder,
    $$UserStatsTableUpdateCompanionBuilder,
    (UserStat, $$UserStatsTableReferences),
    UserStat,
    PrefetchHooks Function({bool userId})>;
typedef $$DailyProgressTableCreateCompanionBuilder = DailyProgressCompanion
    Function({
  Value<int> id,
  required int userId,
  required DateTime date,
  Value<int> calories,
  Value<int> steps,
  Value<double> weight,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$DailyProgressTableUpdateCompanionBuilder = DailyProgressCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<DateTime> date,
  Value<int> calories,
  Value<int> steps,
  Value<double> weight,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$DailyProgressTableReferences extends BaseReferences<_$AppDatabase,
    $DailyProgressTable, DailyProgressData> {
  $$DailyProgressTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.dailyProgress.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DailyProgressTableFilterComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyProgressTable,
    DailyProgressData,
    $$DailyProgressTableFilterComposer,
    $$DailyProgressTableOrderingComposer,
    $$DailyProgressTableAnnotationComposer,
    $$DailyProgressTableCreateCompanionBuilder,
    $$DailyProgressTableUpdateCompanionBuilder,
    (DailyProgressData, $$DailyProgressTableReferences),
    DailyProgressData,
    PrefetchHooks Function({bool userId})> {
  $$DailyProgressTableTableManager(_$AppDatabase db, $DailyProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> calories = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyProgressCompanion(
            id: id,
            userId: userId,
            date: date,
            calories: calories,
            steps: steps,
            weight: weight,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required DateTime date,
            Value<int> calories = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyProgressCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            calories: calories,
            steps: steps,
            weight: weight,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DailyProgressTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$DailyProgressTableReferences._userIdTable(db),
                    referencedColumn:
                        $$DailyProgressTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DailyProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyProgressTable,
    DailyProgressData,
    $$DailyProgressTableFilterComposer,
    $$DailyProgressTableOrderingComposer,
    $$DailyProgressTableAnnotationComposer,
    $$DailyProgressTableCreateCompanionBuilder,
    $$DailyProgressTableUpdateCompanionBuilder,
    (DailyProgressData, $$DailyProgressTableReferences),
    DailyProgressData,
    PrefetchHooks Function({bool userId})>;
typedef $$WorkoutSessionsTableCreateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  required int studentId,
  required int routineId,
  required DateTime sessionDate,
  required int durationMinutes,
  Value<double> caloriesBurned,
  Value<double> overallRating,
  Value<String?> notes,
  required WorkoutSessionStatus status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WorkoutSessionsTableUpdateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> routineId,
  Value<DateTime> sessionDate,
  Value<int> durationMinutes,
  Value<double> caloriesBurned,
  Value<double> overallRating,
  Value<String?> notes,
  Value<WorkoutSessionStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$WorkoutSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutSessionsTable, DbWorkoutSession> {
  $$WorkoutSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.workoutSessions.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias(
          $_aliasNameGenerator(db.workoutSessions.routineId, db.routines.id));

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutinesTableTableManager($_db, $_db.routines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExerciseSessionsTable, List<DbExerciseSession>>
      _exerciseSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exerciseSessions,
              aliasName: $_aliasNameGenerator(
                  db.workoutSessions.id, db.exerciseSessions.workoutSessionId));

  $$ExerciseSessionsTableProcessedTableManager get exerciseSessionsRefs {
    final manager =
        $$ExerciseSessionsTableTableManager($_db, $_db.exerciseSessions).filter(
            (f) => f.workoutSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_exerciseSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get overallRating => $composableBuilder(
      column: $table.overallRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorkoutSessionStatus, WorkoutSessionStatus,
          String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableFilterComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> exerciseSessionsRefs(
      Expression<bool> Function($$ExerciseSessionsTableFilterComposer f) f) {
    final $$ExerciseSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSessions,
        getReferencedColumn: (t) => t.workoutSessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSessionsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get overallRating => $composableBuilder(
      column: $table.overallRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableOrderingComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned, builder: (column) => column);

  GeneratedColumn<double> get overallRating => $composableBuilder(
      column: $table.overallRating, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutSessionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> exerciseSessionsRefs<T extends Object>(
      Expression<T> Function($$ExerciseSessionsTableAnnotationComposer a) f) {
    final $$ExerciseSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSessions,
        getReferencedColumn: (t) => t.workoutSessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    DbWorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (DbWorkoutSession, $$WorkoutSessionsTableReferences),
    DbWorkoutSession,
    PrefetchHooks Function(
        {bool studentId, bool routineId, bool exerciseSessionsRefs})> {
  $$WorkoutSessionsTableTableManager(
      _$AppDatabase db, $WorkoutSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> routineId = const Value.absent(),
            Value<DateTime> sessionDate = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<double> caloriesBurned = const Value.absent(),
            Value<double> overallRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<WorkoutSessionStatus> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion(
            id: id,
            studentId: studentId,
            routineId: routineId,
            sessionDate: sessionDate,
            durationMinutes: durationMinutes,
            caloriesBurned: caloriesBurned,
            overallRating: overallRating,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int routineId,
            required DateTime sessionDate,
            required int durationMinutes,
            Value<double> caloriesBurned = const Value.absent(),
            Value<double> overallRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required WorkoutSessionStatus status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion.insert(
            id: id,
            studentId: studentId,
            routineId: routineId,
            sessionDate: sessionDate,
            durationMinutes: durationMinutes,
            caloriesBurned: caloriesBurned,
            overallRating: overallRating,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentId = false,
              routineId = false,
              exerciseSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (exerciseSessionsRefs) db.exerciseSessions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$WorkoutSessionsTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$WorkoutSessionsTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (routineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.routineId,
                    referencedTable:
                        $$WorkoutSessionsTableReferences._routineIdTable(db),
                    referencedColumn:
                        $$WorkoutSessionsTableReferences._routineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseSessionsRefs)
                    await $_getPrefetchedData<DbWorkoutSession,
                            $WorkoutSessionsTable, DbExerciseSession>(
                        currentTable: table,
                        referencedTable: $$WorkoutSessionsTableReferences
                            ._exerciseSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutSessionsTableReferences(db, table, p0)
                                .exerciseSessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutSessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    DbWorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (DbWorkoutSession, $$WorkoutSessionsTableReferences),
    DbWorkoutSession,
    PrefetchHooks Function(
        {bool studentId, bool routineId, bool exerciseSessionsRefs})>;
typedef $$ExerciseSessionsTableCreateCompanionBuilder
    = ExerciseSessionsCompanion Function({
  Value<int> id,
  required int workoutSessionId,
  required String exerciseName,
  required String exerciseDescription,
  required int sets,
  required int reps,
  required int restTimeSeconds,
  Value<double?> weightKg,
  Value<int?> percentage,
  Value<int?> durationSeconds,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$ExerciseSessionsTableUpdateCompanionBuilder
    = ExerciseSessionsCompanion Function({
  Value<int> id,
  Value<int> workoutSessionId,
  Value<String> exerciseName,
  Value<String> exerciseDescription,
  Value<int> sets,
  Value<int> reps,
  Value<int> restTimeSeconds,
  Value<double?> weightKg,
  Value<int?> percentage,
  Value<int?> durationSeconds,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$ExerciseSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $ExerciseSessionsTable, DbExerciseSession> {
  $$ExerciseSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutSessionsTable _workoutSessionIdTable(_$AppDatabase db) =>
      db.workoutSessions.createAlias($_aliasNameGenerator(
          db.exerciseSessions.workoutSessionId, db.workoutSessions.id));

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionId {
    final $_column = $_itemColumn<int>('workout_session_id')!;

    final manager =
        $$WorkoutSessionsTableTableManager($_db, $_db.workoutSessions)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExerciseSetsTable, List<DbExerciseSet>>
      _exerciseSetsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exerciseSets,
              aliasName: $_aliasNameGenerator(
                  db.exerciseSessions.id, db.exerciseSets.exerciseSessionId));

  $$ExerciseSetsTableProcessedTableManager get exerciseSetsRefs {
    final manager = $$ExerciseSetsTableTableManager($_db, $_db.exerciseSets)
        .filter(
            (f) => f.exerciseSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_exerciseSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExerciseSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSessionsTable> {
  $$ExerciseSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseName => $composableBuilder(
      column: $table.exerciseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseDescription => $composableBuilder(
      column: $table.exerciseDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$WorkoutSessionsTableFilterComposer get workoutSessionId {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutSessionId,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableFilterComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> exerciseSetsRefs(
      Expression<bool> Function($$ExerciseSetsTableFilterComposer f) f) {
    final $$ExerciseSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.exerciseSessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSetsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSessionsTable> {
  $$ExerciseSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseName => $composableBuilder(
      column: $table.exerciseName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseDescription => $composableBuilder(
      column: $table.exerciseDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$WorkoutSessionsTableOrderingComposer get workoutSessionId {
    final $$WorkoutSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutSessionId,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSessionsTable> {
  $$ExerciseSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseName => $composableBuilder(
      column: $table.exerciseName, builder: (column) => column);

  GeneratedColumn<String> get exerciseDescription => $composableBuilder(
      column: $table.exerciseDescription, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WorkoutSessionsTableAnnotationComposer get workoutSessionId {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutSessionId,
        referencedTable: $db.workoutSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> exerciseSetsRefs<T extends Object>(
      Expression<T> Function($$ExerciseSetsTableAnnotationComposer a) f) {
    final $$ExerciseSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseSets,
        getReferencedColumn: (t) => t.exerciseSessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseSessionsTable,
    DbExerciseSession,
    $$ExerciseSessionsTableFilterComposer,
    $$ExerciseSessionsTableOrderingComposer,
    $$ExerciseSessionsTableAnnotationComposer,
    $$ExerciseSessionsTableCreateCompanionBuilder,
    $$ExerciseSessionsTableUpdateCompanionBuilder,
    (DbExerciseSession, $$ExerciseSessionsTableReferences),
    DbExerciseSession,
    PrefetchHooks Function({bool workoutSessionId, bool exerciseSetsRefs})> {
  $$ExerciseSessionsTableTableManager(
      _$AppDatabase db, $ExerciseSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workoutSessionId = const Value.absent(),
            Value<String> exerciseName = const Value.absent(),
            Value<String> exerciseDescription = const Value.absent(),
            Value<int> sets = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> restTimeSeconds = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<int?> percentage = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExerciseSessionsCompanion(
            id: id,
            workoutSessionId: workoutSessionId,
            exerciseName: exerciseName,
            exerciseDescription: exerciseDescription,
            sets: sets,
            reps: reps,
            restTimeSeconds: restTimeSeconds,
            weightKg: weightKg,
            percentage: percentage,
            durationSeconds: durationSeconds,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workoutSessionId,
            required String exerciseName,
            required String exerciseDescription,
            required int sets,
            required int reps,
            required int restTimeSeconds,
            Value<double?> weightKg = const Value.absent(),
            Value<int?> percentage = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExerciseSessionsCompanion.insert(
            id: id,
            workoutSessionId: workoutSessionId,
            exerciseName: exerciseName,
            exerciseDescription: exerciseDescription,
            sets: sets,
            reps: reps,
            restTimeSeconds: restTimeSeconds,
            weightKg: weightKg,
            percentage: percentage,
            durationSeconds: durationSeconds,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {workoutSessionId = false, exerciseSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exerciseSetsRefs) db.exerciseSets],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutSessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutSessionId,
                    referencedTable: $$ExerciseSessionsTableReferences
                        ._workoutSessionIdTable(db),
                    referencedColumn: $$ExerciseSessionsTableReferences
                        ._workoutSessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseSetsRefs)
                    await $_getPrefetchedData<DbExerciseSession,
                            $ExerciseSessionsTable, DbExerciseSet>(
                        currentTable: table,
                        referencedTable: $$ExerciseSessionsTableReferences
                            ._exerciseSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExerciseSessionsTableReferences(db, table, p0)
                                .exerciseSetsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseSessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExerciseSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseSessionsTable,
    DbExerciseSession,
    $$ExerciseSessionsTableFilterComposer,
    $$ExerciseSessionsTableOrderingComposer,
    $$ExerciseSessionsTableAnnotationComposer,
    $$ExerciseSessionsTableCreateCompanionBuilder,
    $$ExerciseSessionsTableUpdateCompanionBuilder,
    (DbExerciseSession, $$ExerciseSessionsTableReferences),
    DbExerciseSession,
    PrefetchHooks Function({bool workoutSessionId, bool exerciseSetsRefs})>;
typedef $$ExerciseSetsTableCreateCompanionBuilder = ExerciseSetsCompanion
    Function({
  Value<int> id,
  required int exerciseSessionId,
  required int setNumber,
  required int reps,
  Value<double?> weightKg,
  Value<int?> percentage,
  Value<int?> durationSeconds,
  Value<double?> restTimeSeconds,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$ExerciseSetsTableUpdateCompanionBuilder = ExerciseSetsCompanion
    Function({
  Value<int> id,
  Value<int> exerciseSessionId,
  Value<int> setNumber,
  Value<int> reps,
  Value<double?> weightKg,
  Value<int?> percentage,
  Value<int?> durationSeconds,
  Value<double?> restTimeSeconds,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$ExerciseSetsTableReferences
    extends BaseReferences<_$AppDatabase, $ExerciseSetsTable, DbExerciseSet> {
  $$ExerciseSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExerciseSessionsTable _exerciseSessionIdTable(_$AppDatabase db) =>
      db.exerciseSessions.createAlias($_aliasNameGenerator(
          db.exerciseSets.exerciseSessionId, db.exerciseSessions.id));

  $$ExerciseSessionsTableProcessedTableManager get exerciseSessionId {
    final $_column = $_itemColumn<int>('exercise_session_id')!;

    final manager =
        $$ExerciseSessionsTableTableManager($_db, $_db.exerciseSessions)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExerciseSetsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ExerciseSessionsTableFilterComposer get exerciseSessionId {
    final $$ExerciseSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseSessionId,
        referencedTable: $db.exerciseSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSessionsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ExerciseSessionsTableOrderingComposer get exerciseSessionId {
    final $$ExerciseSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseSessionId,
        referencedTable: $db.exerciseSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.exerciseSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTable> {
  $$ExerciseSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<double> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExerciseSessionsTableAnnotationComposer get exerciseSessionId {
    final $$ExerciseSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseSessionId,
        referencedTable: $db.exerciseSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseSetsTable,
    DbExerciseSet,
    $$ExerciseSetsTableFilterComposer,
    $$ExerciseSetsTableOrderingComposer,
    $$ExerciseSetsTableAnnotationComposer,
    $$ExerciseSetsTableCreateCompanionBuilder,
    $$ExerciseSetsTableUpdateCompanionBuilder,
    (DbExerciseSet, $$ExerciseSetsTableReferences),
    DbExerciseSet,
    PrefetchHooks Function({bool exerciseSessionId})> {
  $$ExerciseSetsTableTableManager(_$AppDatabase db, $ExerciseSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> exerciseSessionId = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<int?> percentage = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<double?> restTimeSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExerciseSetsCompanion(
            id: id,
            exerciseSessionId: exerciseSessionId,
            setNumber: setNumber,
            reps: reps,
            weightKg: weightKg,
            percentage: percentage,
            durationSeconds: durationSeconds,
            restTimeSeconds: restTimeSeconds,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int exerciseSessionId,
            required int setNumber,
            required int reps,
            Value<double?> weightKg = const Value.absent(),
            Value<int?> percentage = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<double?> restTimeSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExerciseSetsCompanion.insert(
            id: id,
            exerciseSessionId: exerciseSessionId,
            setNumber: setNumber,
            reps: reps,
            weightKg: weightKg,
            percentage: percentage,
            durationSeconds: durationSeconds,
            restTimeSeconds: restTimeSeconds,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseSessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseSessionId,
                    referencedTable: $$ExerciseSetsTableReferences
                        ._exerciseSessionIdTable(db),
                    referencedColumn: $$ExerciseSetsTableReferences
                        ._exerciseSessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExerciseSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseSetsTable,
    DbExerciseSet,
    $$ExerciseSetsTableFilterComposer,
    $$ExerciseSetsTableOrderingComposer,
    $$ExerciseSetsTableAnnotationComposer,
    $$ExerciseSetsTableCreateCompanionBuilder,
    $$ExerciseSetsTableUpdateCompanionBuilder,
    (DbExerciseSet, $$ExerciseSetsTableReferences),
    DbExerciseSet,
    PrefetchHooks Function({bool exerciseSessionId})>;
typedef $$TrainerProductsTableCreateCompanionBuilder = TrainerProductsCompanion
    Function({
  Value<int> id,
  required int trainerId,
  required String name,
  required String description,
  required double price,
  Value<Currency> currency,
  Value<int> durationInDays,
  required ProductCategory category,
  required String features,
  Value<bool> isPopular,
  required ProductStatus status,
  Value<String?> imageUrl,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$TrainerProductsTableUpdateCompanionBuilder = TrainerProductsCompanion
    Function({
  Value<int> id,
  Value<int> trainerId,
  Value<String> name,
  Value<String> description,
  Value<double> price,
  Value<Currency> currency,
  Value<int> durationInDays,
  Value<ProductCategory> category,
  Value<String> features,
  Value<bool> isPopular,
  Value<ProductStatus> status,
  Value<String?> imageUrl,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$TrainerProductsTableReferences extends BaseReferences<
    _$AppDatabase, $TrainerProductsTable, DbTrainerProduct> {
  $$TrainerProductsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _trainerIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.trainerProducts.trainerId, db.users.id));

  $$UsersTableProcessedTableManager get trainerId {
    final $_column = $_itemColumn<int>('trainer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TrainerProductsTableFilterComposer
    extends Composer<_$AppDatabase, $TrainerProductsTable> {
  $$TrainerProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Currency, Currency, String> get currency =>
      $composableBuilder(
          column: $table.currency,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductCategory, ProductCategory, String>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get features => $composableBuilder(
      column: $table.features, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPopular => $composableBuilder(
      column: $table.isPopular, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductStatus, ProductStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get trainerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrainerProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainerProductsTable> {
  $$TrainerProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get features => $composableBuilder(
      column: $table.features, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPopular => $composableBuilder(
      column: $table.isPopular, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get trainerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrainerProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainerProductsTable> {
  $$TrainerProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get features =>
      $composableBuilder(column: $table.features, builder: (column) => column);

  GeneratedColumn<bool> get isPopular =>
      $composableBuilder(column: $table.isPopular, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get trainerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trainerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrainerProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrainerProductsTable,
    DbTrainerProduct,
    $$TrainerProductsTableFilterComposer,
    $$TrainerProductsTableOrderingComposer,
    $$TrainerProductsTableAnnotationComposer,
    $$TrainerProductsTableCreateCompanionBuilder,
    $$TrainerProductsTableUpdateCompanionBuilder,
    (DbTrainerProduct, $$TrainerProductsTableReferences),
    DbTrainerProduct,
    PrefetchHooks Function({bool trainerId})> {
  $$TrainerProductsTableTableManager(
      _$AppDatabase db, $TrainerProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainerProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainerProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainerProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> trainerId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<Currency> currency = const Value.absent(),
            Value<int> durationInDays = const Value.absent(),
            Value<ProductCategory> category = const Value.absent(),
            Value<String> features = const Value.absent(),
            Value<bool> isPopular = const Value.absent(),
            Value<ProductStatus> status = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TrainerProductsCompanion(
            id: id,
            trainerId: trainerId,
            name: name,
            description: description,
            price: price,
            currency: currency,
            durationInDays: durationInDays,
            category: category,
            features: features,
            isPopular: isPopular,
            status: status,
            imageUrl: imageUrl,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int trainerId,
            required String name,
            required String description,
            required double price,
            Value<Currency> currency = const Value.absent(),
            Value<int> durationInDays = const Value.absent(),
            required ProductCategory category,
            required String features,
            Value<bool> isPopular = const Value.absent(),
            required ProductStatus status,
            Value<String?> imageUrl = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TrainerProductsCompanion.insert(
            id: id,
            trainerId: trainerId,
            name: name,
            description: description,
            price: price,
            currency: currency,
            durationInDays: durationInDays,
            category: category,
            features: features,
            isPopular: isPopular,
            status: status,
            imageUrl: imageUrl,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TrainerProductsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({trainerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (trainerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trainerId,
                    referencedTable:
                        $$TrainerProductsTableReferences._trainerIdTable(db),
                    referencedColumn:
                        $$TrainerProductsTableReferences._trainerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TrainerProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrainerProductsTable,
    DbTrainerProduct,
    $$TrainerProductsTableFilterComposer,
    $$TrainerProductsTableOrderingComposer,
    $$TrainerProductsTableAnnotationComposer,
    $$TrainerProductsTableCreateCompanionBuilder,
    $$TrainerProductsTableUpdateCompanionBuilder,
    (DbTrainerProduct, $$TrainerProductsTableReferences),
    DbTrainerProduct,
    PrefetchHooks Function({bool trainerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$StudentRoutinesTableTableManager get studentRoutines =>
      $$StudentRoutinesTableTableManager(_db, _db.studentRoutines);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db, _db.userStats);
  $$DailyProgressTableTableManager get dailyProgress =>
      $$DailyProgressTableTableManager(_db, _db.dailyProgress);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$ExerciseSessionsTableTableManager get exerciseSessions =>
      $$ExerciseSessionsTableTableManager(_db, _db.exerciseSessions);
  $$ExerciseSetsTableTableManager get exerciseSets =>
      $$ExerciseSetsTableTableManager(_db, _db.exerciseSets);
  $$TrainerProductsTableTableManager get trainerProducts =>
      $$TrainerProductsTableTableManager(_db, _db.trainerProducts);
}
