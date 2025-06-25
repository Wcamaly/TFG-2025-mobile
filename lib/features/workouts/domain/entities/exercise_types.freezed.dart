// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ExerciseCategory get category => throw _privateConstructorUsedError;
  WorkoutType get workoutType => throw _privateConstructorUsedError;
  List<String> get muscleGroups => throw _privateConstructorUsedError;
  List<String> get equipment => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get videoUrl =>
      throw _privateConstructorUsedError; // Para ejercicios tradicionales
  int? get sets => throw _privateConstructorUsedError;
  int? get reps => throw _privateConstructorUsedError;
  int? get restTimeSeconds =>
      throw _privateConstructorUsedError; // Para WODs y ejercicios de tiempo
  int? get durationMinutes => throw _privateConstructorUsedError;
  int? get rounds =>
      throw _privateConstructorUsedError; // Para ejercicios compuestos (lista de sub-ejercicios)
  List<SubExercise>? get subExercises =>
      throw _privateConstructorUsedError; // Configuración específica
  Map<String, dynamic>? get config => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      ExerciseCategory category,
      WorkoutType workoutType,
      List<String> muscleGroups,
      List<String> equipment,
      String? imageUrl,
      String? videoUrl,
      int? sets,
      int? reps,
      int? restTimeSeconds,
      int? durationMinutes,
      int? rounds,
      List<SubExercise>? subExercises,
      Map<String, dynamic>? config});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? workoutType = null,
    Object? muscleGroups = null,
    Object? equipment = null,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? sets = freezed,
    Object? reps = freezed,
    Object? restTimeSeconds = freezed,
    Object? durationMinutes = freezed,
    Object? rounds = freezed,
    Object? subExercises = freezed,
    Object? config = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ExerciseCategory,
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      muscleGroups: null == muscleGroups
          ? _value.muscleGroups
          : muscleGroups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sets: freezed == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int?,
      reps: freezed == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      restTimeSeconds: freezed == restTimeSeconds
          ? _value.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      rounds: freezed == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int?,
      subExercises: freezed == subExercises
          ? _value.subExercises
          : subExercises // ignore: cast_nullable_to_non_nullable
              as List<SubExercise>?,
      config: freezed == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      ExerciseCategory category,
      WorkoutType workoutType,
      List<String> muscleGroups,
      List<String> equipment,
      String? imageUrl,
      String? videoUrl,
      int? sets,
      int? reps,
      int? restTimeSeconds,
      int? durationMinutes,
      int? rounds,
      List<SubExercise>? subExercises,
      Map<String, dynamic>? config});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? workoutType = null,
    Object? muscleGroups = null,
    Object? equipment = null,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? sets = freezed,
    Object? reps = freezed,
    Object? restTimeSeconds = freezed,
    Object? durationMinutes = freezed,
    Object? rounds = freezed,
    Object? subExercises = freezed,
    Object? config = freezed,
  }) {
    return _then(_$ExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ExerciseCategory,
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      muscleGroups: null == muscleGroups
          ? _value._muscleGroups
          : muscleGroups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equipment: null == equipment
          ? _value._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sets: freezed == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int?,
      reps: freezed == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      restTimeSeconds: freezed == restTimeSeconds
          ? _value.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      rounds: freezed == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int?,
      subExercises: freezed == subExercises
          ? _value._subExercises
          : subExercises // ignore: cast_nullable_to_non_nullable
              as List<SubExercise>?,
      config: freezed == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.workoutType,
      required final List<String> muscleGroups,
      required final List<String> equipment,
      this.imageUrl,
      this.videoUrl,
      this.sets,
      this.reps,
      this.restTimeSeconds,
      this.durationMinutes,
      this.rounds,
      final List<SubExercise>? subExercises,
      final Map<String, dynamic>? config})
      : _muscleGroups = muscleGroups,
        _equipment = equipment,
        _subExercises = subExercises,
        _config = config;

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final ExerciseCategory category;
  @override
  final WorkoutType workoutType;
  final List<String> _muscleGroups;
  @override
  List<String> get muscleGroups {
    if (_muscleGroups is EqualUnmodifiableListView) return _muscleGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_muscleGroups);
  }

  final List<String> _equipment;
  @override
  List<String> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  @override
  final String? imageUrl;
  @override
  final String? videoUrl;
// Para ejercicios tradicionales
  @override
  final int? sets;
  @override
  final int? reps;
  @override
  final int? restTimeSeconds;
// Para WODs y ejercicios de tiempo
  @override
  final int? durationMinutes;
  @override
  final int? rounds;
// Para ejercicios compuestos (lista de sub-ejercicios)
  final List<SubExercise>? _subExercises;
// Para ejercicios compuestos (lista de sub-ejercicios)
  @override
  List<SubExercise>? get subExercises {
    final value = _subExercises;
    if (value == null) return null;
    if (_subExercises is EqualUnmodifiableListView) return _subExercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Configuración específica
  final Map<String, dynamic>? _config;
// Configuración específica
  @override
  Map<String, dynamic>? get config {
    final value = _config;
    if (value == null) return null;
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, description: $description, category: $category, workoutType: $workoutType, muscleGroups: $muscleGroups, equipment: $equipment, imageUrl: $imageUrl, videoUrl: $videoUrl, sets: $sets, reps: $reps, restTimeSeconds: $restTimeSeconds, durationMinutes: $durationMinutes, rounds: $rounds, subExercises: $subExercises, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            const DeepCollectionEquality()
                .equals(other._muscleGroups, _muscleGroups) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.restTimeSeconds, restTimeSeconds) ||
                other.restTimeSeconds == restTimeSeconds) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            const DeepCollectionEquality()
                .equals(other._subExercises, _subExercises) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      workoutType,
      const DeepCollectionEquality().hash(_muscleGroups),
      const DeepCollectionEquality().hash(_equipment),
      imageUrl,
      videoUrl,
      sets,
      reps,
      restTimeSeconds,
      durationMinutes,
      rounds,
      const DeepCollectionEquality().hash(_subExercises),
      const DeepCollectionEquality().hash(_config));

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final String id,
      required final String name,
      required final String description,
      required final ExerciseCategory category,
      required final WorkoutType workoutType,
      required final List<String> muscleGroups,
      required final List<String> equipment,
      final String? imageUrl,
      final String? videoUrl,
      final int? sets,
      final int? reps,
      final int? restTimeSeconds,
      final int? durationMinutes,
      final int? rounds,
      final List<SubExercise>? subExercises,
      final Map<String, dynamic>? config}) = _$ExerciseImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  ExerciseCategory get category;
  @override
  WorkoutType get workoutType;
  @override
  List<String> get muscleGroups;
  @override
  List<String> get equipment;
  @override
  String? get imageUrl;
  @override
  String? get videoUrl; // Para ejercicios tradicionales
  @override
  int? get sets;
  @override
  int? get reps;
  @override
  int? get restTimeSeconds; // Para WODs y ejercicios de tiempo
  @override
  int? get durationMinutes;
  @override
  int? get rounds; // Para ejercicios compuestos (lista de sub-ejercicios)
  @override
  List<SubExercise>? get subExercises; // Configuración específica
  @override
  Map<String, dynamic>? get config;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SubExercise {
  String get name => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of SubExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubExerciseCopyWith<SubExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubExerciseCopyWith<$Res> {
  factory $SubExerciseCopyWith(
          SubExercise value, $Res Function(SubExercise) then) =
      _$SubExerciseCopyWithImpl<$Res, SubExercise>;
  @useResult
  $Res call({String name, int reps, String? notes});
}

/// @nodoc
class _$SubExerciseCopyWithImpl<$Res, $Val extends SubExercise>
    implements $SubExerciseCopyWith<$Res> {
  _$SubExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reps = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubExerciseImplCopyWith<$Res>
    implements $SubExerciseCopyWith<$Res> {
  factory _$$SubExerciseImplCopyWith(
          _$SubExerciseImpl value, $Res Function(_$SubExerciseImpl) then) =
      __$$SubExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int reps, String? notes});
}

/// @nodoc
class __$$SubExerciseImplCopyWithImpl<$Res>
    extends _$SubExerciseCopyWithImpl<$Res, _$SubExerciseImpl>
    implements _$$SubExerciseImplCopyWith<$Res> {
  __$$SubExerciseImplCopyWithImpl(
      _$SubExerciseImpl _value, $Res Function(_$SubExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reps = null,
    Object? notes = freezed,
  }) {
    return _then(_$SubExerciseImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SubExerciseImpl implements _SubExercise {
  const _$SubExerciseImpl({required this.name, required this.reps, this.notes});

  @override
  final String name;
  @override
  final int reps;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SubExercise(name: $name, reps: $reps, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubExerciseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, reps, notes);

  /// Create a copy of SubExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubExerciseImplCopyWith<_$SubExerciseImpl> get copyWith =>
      __$$SubExerciseImplCopyWithImpl<_$SubExerciseImpl>(this, _$identity);
}

abstract class _SubExercise implements SubExercise {
  const factory _SubExercise(
      {required final String name,
      required final int reps,
      final String? notes}) = _$SubExerciseImpl;

  @override
  String get name;
  @override
  int get reps;
  @override
  String? get notes;

  /// Create a copy of SubExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubExerciseImplCopyWith<_$SubExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExerciseStats {
  String get exerciseId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  WorkoutType get workoutType =>
      throw _privateConstructorUsedError; // Stats comunes
  int? get completedReps => throw _privateConstructorUsedError;
  double? get weightUsed => throw _privateConstructorUsedError;
  int? get timeSeconds =>
      throw _privateConstructorUsedError; // Stats específicos por tipo
  int? get rounds => throw _privateConstructorUsedError; // Para AMRAPs
  double? get personalRecord => throw _privateConstructorUsedError; // Para PRs
  int? get maxReps => throw _privateConstructorUsedError; // Para max reps
  String? get notes => throw _privateConstructorUsedError; // Rating subjetivo
  int? get difficultyRating => throw _privateConstructorUsedError; // 1-10
  int? get energyLevel => throw _privateConstructorUsedError; // 1-10
// Para ejercicios compuestos
  List<SubExerciseStats>? get subExerciseStats =>
      throw _privateConstructorUsedError;

  /// Create a copy of ExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseStatsCopyWith<ExerciseStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseStatsCopyWith<$Res> {
  factory $ExerciseStatsCopyWith(
          ExerciseStats value, $Res Function(ExerciseStats) then) =
      _$ExerciseStatsCopyWithImpl<$Res, ExerciseStats>;
  @useResult
  $Res call(
      {String exerciseId,
      DateTime date,
      WorkoutType workoutType,
      int? completedReps,
      double? weightUsed,
      int? timeSeconds,
      int? rounds,
      double? personalRecord,
      int? maxReps,
      String? notes,
      int? difficultyRating,
      int? energyLevel,
      List<SubExerciseStats>? subExerciseStats});
}

/// @nodoc
class _$ExerciseStatsCopyWithImpl<$Res, $Val extends ExerciseStats>
    implements $ExerciseStatsCopyWith<$Res> {
  _$ExerciseStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? date = null,
    Object? workoutType = null,
    Object? completedReps = freezed,
    Object? weightUsed = freezed,
    Object? timeSeconds = freezed,
    Object? rounds = freezed,
    Object? personalRecord = freezed,
    Object? maxReps = freezed,
    Object? notes = freezed,
    Object? difficultyRating = freezed,
    Object? energyLevel = freezed,
    Object? subExerciseStats = freezed,
  }) {
    return _then(_value.copyWith(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      completedReps: freezed == completedReps
          ? _value.completedReps
          : completedReps // ignore: cast_nullable_to_non_nullable
              as int?,
      weightUsed: freezed == weightUsed
          ? _value.weightUsed
          : weightUsed // ignore: cast_nullable_to_non_nullable
              as double?,
      timeSeconds: freezed == timeSeconds
          ? _value.timeSeconds
          : timeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      rounds: freezed == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int?,
      personalRecord: freezed == personalRecord
          ? _value.personalRecord
          : personalRecord // ignore: cast_nullable_to_non_nullable
              as double?,
      maxReps: freezed == maxReps
          ? _value.maxReps
          : maxReps // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyRating: freezed == difficultyRating
          ? _value.difficultyRating
          : difficultyRating // ignore: cast_nullable_to_non_nullable
              as int?,
      energyLevel: freezed == energyLevel
          ? _value.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      subExerciseStats: freezed == subExerciseStats
          ? _value.subExerciseStats
          : subExerciseStats // ignore: cast_nullable_to_non_nullable
              as List<SubExerciseStats>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseStatsImplCopyWith<$Res>
    implements $ExerciseStatsCopyWith<$Res> {
  factory _$$ExerciseStatsImplCopyWith(
          _$ExerciseStatsImpl value, $Res Function(_$ExerciseStatsImpl) then) =
      __$$ExerciseStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String exerciseId,
      DateTime date,
      WorkoutType workoutType,
      int? completedReps,
      double? weightUsed,
      int? timeSeconds,
      int? rounds,
      double? personalRecord,
      int? maxReps,
      String? notes,
      int? difficultyRating,
      int? energyLevel,
      List<SubExerciseStats>? subExerciseStats});
}

/// @nodoc
class __$$ExerciseStatsImplCopyWithImpl<$Res>
    extends _$ExerciseStatsCopyWithImpl<$Res, _$ExerciseStatsImpl>
    implements _$$ExerciseStatsImplCopyWith<$Res> {
  __$$ExerciseStatsImplCopyWithImpl(
      _$ExerciseStatsImpl _value, $Res Function(_$ExerciseStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? date = null,
    Object? workoutType = null,
    Object? completedReps = freezed,
    Object? weightUsed = freezed,
    Object? timeSeconds = freezed,
    Object? rounds = freezed,
    Object? personalRecord = freezed,
    Object? maxReps = freezed,
    Object? notes = freezed,
    Object? difficultyRating = freezed,
    Object? energyLevel = freezed,
    Object? subExerciseStats = freezed,
  }) {
    return _then(_$ExerciseStatsImpl(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      completedReps: freezed == completedReps
          ? _value.completedReps
          : completedReps // ignore: cast_nullable_to_non_nullable
              as int?,
      weightUsed: freezed == weightUsed
          ? _value.weightUsed
          : weightUsed // ignore: cast_nullable_to_non_nullable
              as double?,
      timeSeconds: freezed == timeSeconds
          ? _value.timeSeconds
          : timeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      rounds: freezed == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int?,
      personalRecord: freezed == personalRecord
          ? _value.personalRecord
          : personalRecord // ignore: cast_nullable_to_non_nullable
              as double?,
      maxReps: freezed == maxReps
          ? _value.maxReps
          : maxReps // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyRating: freezed == difficultyRating
          ? _value.difficultyRating
          : difficultyRating // ignore: cast_nullable_to_non_nullable
              as int?,
      energyLevel: freezed == energyLevel
          ? _value.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      subExerciseStats: freezed == subExerciseStats
          ? _value._subExerciseStats
          : subExerciseStats // ignore: cast_nullable_to_non_nullable
              as List<SubExerciseStats>?,
    ));
  }
}

/// @nodoc

class _$ExerciseStatsImpl implements _ExerciseStats {
  const _$ExerciseStatsImpl(
      {required this.exerciseId,
      required this.date,
      required this.workoutType,
      this.completedReps,
      this.weightUsed,
      this.timeSeconds,
      this.rounds,
      this.personalRecord,
      this.maxReps,
      this.notes,
      this.difficultyRating,
      this.energyLevel,
      final List<SubExerciseStats>? subExerciseStats})
      : _subExerciseStats = subExerciseStats;

  @override
  final String exerciseId;
  @override
  final DateTime date;
  @override
  final WorkoutType workoutType;
// Stats comunes
  @override
  final int? completedReps;
  @override
  final double? weightUsed;
  @override
  final int? timeSeconds;
// Stats específicos por tipo
  @override
  final int? rounds;
// Para AMRAPs
  @override
  final double? personalRecord;
// Para PRs
  @override
  final int? maxReps;
// Para max reps
  @override
  final String? notes;
// Rating subjetivo
  @override
  final int? difficultyRating;
// 1-10
  @override
  final int? energyLevel;
// 1-10
// Para ejercicios compuestos
  final List<SubExerciseStats>? _subExerciseStats;
// 1-10
// Para ejercicios compuestos
  @override
  List<SubExerciseStats>? get subExerciseStats {
    final value = _subExerciseStats;
    if (value == null) return null;
    if (_subExerciseStats is EqualUnmodifiableListView)
      return _subExerciseStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExerciseStats(exerciseId: $exerciseId, date: $date, workoutType: $workoutType, completedReps: $completedReps, weightUsed: $weightUsed, timeSeconds: $timeSeconds, rounds: $rounds, personalRecord: $personalRecord, maxReps: $maxReps, notes: $notes, difficultyRating: $difficultyRating, energyLevel: $energyLevel, subExerciseStats: $subExerciseStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseStatsImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.completedReps, completedReps) ||
                other.completedReps == completedReps) &&
            (identical(other.weightUsed, weightUsed) ||
                other.weightUsed == weightUsed) &&
            (identical(other.timeSeconds, timeSeconds) ||
                other.timeSeconds == timeSeconds) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.personalRecord, personalRecord) ||
                other.personalRecord == personalRecord) &&
            (identical(other.maxReps, maxReps) || other.maxReps == maxReps) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.difficultyRating, difficultyRating) ||
                other.difficultyRating == difficultyRating) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            const DeepCollectionEquality()
                .equals(other._subExerciseStats, _subExerciseStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      exerciseId,
      date,
      workoutType,
      completedReps,
      weightUsed,
      timeSeconds,
      rounds,
      personalRecord,
      maxReps,
      notes,
      difficultyRating,
      energyLevel,
      const DeepCollectionEquality().hash(_subExerciseStats));

  /// Create a copy of ExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseStatsImplCopyWith<_$ExerciseStatsImpl> get copyWith =>
      __$$ExerciseStatsImplCopyWithImpl<_$ExerciseStatsImpl>(this, _$identity);
}

abstract class _ExerciseStats implements ExerciseStats {
  const factory _ExerciseStats(
      {required final String exerciseId,
      required final DateTime date,
      required final WorkoutType workoutType,
      final int? completedReps,
      final double? weightUsed,
      final int? timeSeconds,
      final int? rounds,
      final double? personalRecord,
      final int? maxReps,
      final String? notes,
      final int? difficultyRating,
      final int? energyLevel,
      final List<SubExerciseStats>? subExerciseStats}) = _$ExerciseStatsImpl;

  @override
  String get exerciseId;
  @override
  DateTime get date;
  @override
  WorkoutType get workoutType; // Stats comunes
  @override
  int? get completedReps;
  @override
  double? get weightUsed;
  @override
  int? get timeSeconds; // Stats específicos por tipo
  @override
  int? get rounds; // Para AMRAPs
  @override
  double? get personalRecord; // Para PRs
  @override
  int? get maxReps; // Para max reps
  @override
  String? get notes; // Rating subjetivo
  @override
  int? get difficultyRating; // 1-10
  @override
  int? get energyLevel; // 1-10
// Para ejercicios compuestos
  @override
  List<SubExerciseStats>? get subExerciseStats;

  /// Create a copy of ExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseStatsImplCopyWith<_$ExerciseStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SubExerciseStats {
  String get name => throw _privateConstructorUsedError;
  int get completedReps => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of SubExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubExerciseStatsCopyWith<SubExerciseStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubExerciseStatsCopyWith<$Res> {
  factory $SubExerciseStatsCopyWith(
          SubExerciseStats value, $Res Function(SubExerciseStats) then) =
      _$SubExerciseStatsCopyWithImpl<$Res, SubExerciseStats>;
  @useResult
  $Res call({String name, int completedReps, double? weight, String? notes});
}

/// @nodoc
class _$SubExerciseStatsCopyWithImpl<$Res, $Val extends SubExerciseStats>
    implements $SubExerciseStatsCopyWith<$Res> {
  _$SubExerciseStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? completedReps = null,
    Object? weight = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completedReps: null == completedReps
          ? _value.completedReps
          : completedReps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubExerciseStatsImplCopyWith<$Res>
    implements $SubExerciseStatsCopyWith<$Res> {
  factory _$$SubExerciseStatsImplCopyWith(_$SubExerciseStatsImpl value,
          $Res Function(_$SubExerciseStatsImpl) then) =
      __$$SubExerciseStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int completedReps, double? weight, String? notes});
}

/// @nodoc
class __$$SubExerciseStatsImplCopyWithImpl<$Res>
    extends _$SubExerciseStatsCopyWithImpl<$Res, _$SubExerciseStatsImpl>
    implements _$$SubExerciseStatsImplCopyWith<$Res> {
  __$$SubExerciseStatsImplCopyWithImpl(_$SubExerciseStatsImpl _value,
      $Res Function(_$SubExerciseStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? completedReps = null,
    Object? weight = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$SubExerciseStatsImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completedReps: null == completedReps
          ? _value.completedReps
          : completedReps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SubExerciseStatsImpl implements _SubExerciseStats {
  const _$SubExerciseStatsImpl(
      {required this.name,
      required this.completedReps,
      this.weight,
      this.notes});

  @override
  final String name;
  @override
  final int completedReps;
  @override
  final double? weight;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SubExerciseStats(name: $name, completedReps: $completedReps, weight: $weight, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubExerciseStatsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.completedReps, completedReps) ||
                other.completedReps == completedReps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, completedReps, weight, notes);

  /// Create a copy of SubExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubExerciseStatsImplCopyWith<_$SubExerciseStatsImpl> get copyWith =>
      __$$SubExerciseStatsImplCopyWithImpl<_$SubExerciseStatsImpl>(
          this, _$identity);
}

abstract class _SubExerciseStats implements SubExerciseStats {
  const factory _SubExerciseStats(
      {required final String name,
      required final int completedReps,
      final double? weight,
      final String? notes}) = _$SubExerciseStatsImpl;

  @override
  String get name;
  @override
  int get completedReps;
  @override
  double? get weight;
  @override
  String? get notes;

  /// Create a copy of SubExerciseStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubExerciseStatsImplCopyWith<_$SubExerciseStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PersonalRecord {
  String get exerciseId => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  PRType get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalRecordCopyWith<PersonalRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalRecordCopyWith<$Res> {
  factory $PersonalRecordCopyWith(
          PersonalRecord value, $Res Function(PersonalRecord) then) =
      _$PersonalRecordCopyWithImpl<$Res, PersonalRecord>;
  @useResult
  $Res call(
      {String exerciseId,
      String exerciseName,
      DateTime date,
      PRType type,
      double value,
      String? notes});
}

/// @nodoc
class _$PersonalRecordCopyWithImpl<$Res, $Val extends PersonalRecord>
    implements $PersonalRecordCopyWith<$Res> {
  _$PersonalRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? date = null,
    Object? type = null,
    Object? value = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PRType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalRecordImplCopyWith<$Res>
    implements $PersonalRecordCopyWith<$Res> {
  factory _$$PersonalRecordImplCopyWith(_$PersonalRecordImpl value,
          $Res Function(_$PersonalRecordImpl) then) =
      __$$PersonalRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String exerciseId,
      String exerciseName,
      DateTime date,
      PRType type,
      double value,
      String? notes});
}

/// @nodoc
class __$$PersonalRecordImplCopyWithImpl<$Res>
    extends _$PersonalRecordCopyWithImpl<$Res, _$PersonalRecordImpl>
    implements _$$PersonalRecordImplCopyWith<$Res> {
  __$$PersonalRecordImplCopyWithImpl(
      _$PersonalRecordImpl _value, $Res Function(_$PersonalRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? date = null,
    Object? type = null,
    Object? value = null,
    Object? notes = freezed,
  }) {
    return _then(_$PersonalRecordImpl(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PRType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PersonalRecordImpl implements _PersonalRecord {
  const _$PersonalRecordImpl(
      {required this.exerciseId,
      required this.exerciseName,
      required this.date,
      required this.type,
      required this.value,
      this.notes});

  @override
  final String exerciseId;
  @override
  final String exerciseName;
  @override
  final DateTime date;
  @override
  final PRType type;
  @override
  final double value;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PersonalRecord(exerciseId: $exerciseId, exerciseName: $exerciseName, date: $date, type: $type, value: $value, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalRecordImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, exerciseId, exerciseName, date, type, value, notes);

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalRecordImplCopyWith<_$PersonalRecordImpl> get copyWith =>
      __$$PersonalRecordImplCopyWithImpl<_$PersonalRecordImpl>(
          this, _$identity);
}

abstract class _PersonalRecord implements PersonalRecord {
  const factory _PersonalRecord(
      {required final String exerciseId,
      required final String exerciseName,
      required final DateTime date,
      required final PRType type,
      required final double value,
      final String? notes}) = _$PersonalRecordImpl;

  @override
  String get exerciseId;
  @override
  String get exerciseName;
  @override
  DateTime get date;
  @override
  PRType get type;
  @override
  double get value;
  @override
  String? get notes;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalRecordImplCopyWith<_$PersonalRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<Exercise> get exercises => throw _privateConstructorUsedError;
  List<ExerciseStats> get stats => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  int? get caloriesBurned => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double? get overallRating => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) then) =
      _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String name,
      List<Exercise> exercises,
      List<ExerciseStats> stats,
      int durationMinutes,
      int? caloriesBurned,
      String? notes,
      double? overallRating});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? name = null,
    Object? exercises = null,
    Object? stats = null,
    Object? durationMinutes = null,
    Object? caloriesBurned = freezed,
    Object? notes = freezed,
    Object? overallRating = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<ExerciseStats>,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesBurned: freezed == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      overallRating: freezed == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(_$WorkoutSessionImpl value,
          $Res Function(_$WorkoutSessionImpl) then) =
      __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String name,
      List<Exercise> exercises,
      List<ExerciseStats> stats,
      int durationMinutes,
      int? caloriesBurned,
      String? notes,
      double? overallRating});
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
      _$WorkoutSessionImpl _value, $Res Function(_$WorkoutSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? name = null,
    Object? exercises = null,
    Object? stats = null,
    Object? durationMinutes = null,
    Object? caloriesBurned = freezed,
    Object? notes = freezed,
    Object? overallRating = freezed,
  }) {
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<ExerciseStats>,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesBurned: freezed == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      overallRating: freezed == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
      {required this.id,
      required this.date,
      required this.name,
      required final List<Exercise> exercises,
      required final List<ExerciseStats> stats,
      required this.durationMinutes,
      this.caloriesBurned,
      this.notes,
      this.overallRating})
      : _exercises = exercises,
        _stats = stats;

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String name;
  final List<Exercise> _exercises;
  @override
  List<Exercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  final List<ExerciseStats> _stats;
  @override
  List<ExerciseStats> get stats {
    if (_stats is EqualUnmodifiableListView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stats);
  }

  @override
  final int durationMinutes;
  @override
  final int? caloriesBurned;
  @override
  final String? notes;
  @override
  final double? overallRating;

  @override
  String toString() {
    return 'WorkoutSession(id: $id, date: $date, name: $name, exercises: $exercises, stats: $stats, durationMinutes: $durationMinutes, caloriesBurned: $caloriesBurned, notes: $notes, overallRating: $overallRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises) &&
            const DeepCollectionEquality().equals(other._stats, _stats) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      name,
      const DeepCollectionEquality().hash(_exercises),
      const DeepCollectionEquality().hash(_stats),
      durationMinutes,
      caloriesBurned,
      notes,
      overallRating);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
          this, _$identity);
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession(
      {required final String id,
      required final DateTime date,
      required final String name,
      required final List<Exercise> exercises,
      required final List<ExerciseStats> stats,
      required final int durationMinutes,
      final int? caloriesBurned,
      final String? notes,
      final double? overallRating}) = _$WorkoutSessionImpl;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  String get name;
  @override
  List<Exercise> get exercises;
  @override
  List<ExerciseStats> get stats;
  @override
  int get durationMinutes;
  @override
  int? get caloriesBurned;
  @override
  String? get notes;
  @override
  double? get overallRating;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
