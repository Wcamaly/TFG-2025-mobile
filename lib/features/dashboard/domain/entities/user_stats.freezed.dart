// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserStats {
  int get calories => throw _privateConstructorUsedError;
  int get heartRate => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  List<DailyProgress> get weeklyProgress => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {int calories,
      int heartRate,
      double weight,
      List<DailyProgress> weeklyProgress});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? heartRate = null,
    Object? weight = null,
    Object? weeklyProgress = null,
  }) {
    return _then(_value.copyWith(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyProgress: null == weeklyProgress
          ? _value.weeklyProgress
          : weeklyProgress // ignore: cast_nullable_to_non_nullable
              as List<DailyProgress>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int calories,
      int heartRate,
      double weight,
      List<DailyProgress> weeklyProgress});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? heartRate = null,
    Object? weight = null,
    Object? weeklyProgress = null,
  }) {
    return _then(_$UserStatsImpl(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyProgress: null == weeklyProgress
          ? _value._weeklyProgress
          : weeklyProgress // ignore: cast_nullable_to_non_nullable
              as List<DailyProgress>,
    ));
  }
}

/// @nodoc

class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl(
      {required this.calories,
      required this.heartRate,
      required this.weight,
      required final List<DailyProgress> weeklyProgress})
      : _weeklyProgress = weeklyProgress;

  @override
  final int calories;
  @override
  final int heartRate;
  @override
  final double weight;
  final List<DailyProgress> _weeklyProgress;
  @override
  List<DailyProgress> get weeklyProgress {
    if (_weeklyProgress is EqualUnmodifiableListView) return _weeklyProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyProgress);
  }

  @override
  String toString() {
    return 'UserStats(calories: $calories, heartRate: $heartRate, weight: $weight, weeklyProgress: $weeklyProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            const DeepCollectionEquality()
                .equals(other._weeklyProgress, _weeklyProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, calories, heartRate, weight,
      const DeepCollectionEquality().hash(_weeklyProgress));

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);
}

abstract class _UserStats implements UserStats {
  const factory _UserStats(
      {required final int calories,
      required final int heartRate,
      required final double weight,
      required final List<DailyProgress> weeklyProgress}) = _$UserStatsImpl;

  @override
  int get calories;
  @override
  int get heartRate;
  @override
  double get weight;
  @override
  List<DailyProgress> get weeklyProgress;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyProgress {
  DateTime get date => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  /// Create a copy of DailyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyProgressCopyWith<DailyProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyProgressCopyWith<$Res> {
  factory $DailyProgressCopyWith(
          DailyProgress value, $Res Function(DailyProgress) then) =
      _$DailyProgressCopyWithImpl<$Res, DailyProgress>;
  @useResult
  $Res call({DateTime date, int calories, int steps, double weight});
}

/// @nodoc
class _$DailyProgressCopyWithImpl<$Res, $Val extends DailyProgress>
    implements $DailyProgressCopyWith<$Res> {
  _$DailyProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? calories = null,
    Object? steps = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyProgressImplCopyWith<$Res>
    implements $DailyProgressCopyWith<$Res> {
  factory _$$DailyProgressImplCopyWith(
          _$DailyProgressImpl value, $Res Function(_$DailyProgressImpl) then) =
      __$$DailyProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int calories, int steps, double weight});
}

/// @nodoc
class __$$DailyProgressImplCopyWithImpl<$Res>
    extends _$DailyProgressCopyWithImpl<$Res, _$DailyProgressImpl>
    implements _$$DailyProgressImplCopyWith<$Res> {
  __$$DailyProgressImplCopyWithImpl(
      _$DailyProgressImpl _value, $Res Function(_$DailyProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? calories = null,
    Object? steps = null,
    Object? weight = null,
  }) {
    return _then(_$DailyProgressImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DailyProgressImpl implements _DailyProgress {
  const _$DailyProgressImpl(
      {required this.date,
      required this.calories,
      required this.steps,
      required this.weight});

  @override
  final DateTime date;
  @override
  final int calories;
  @override
  final int steps;
  @override
  final double weight;

  @override
  String toString() {
    return 'DailyProgress(date: $date, calories: $calories, steps: $steps, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyProgressImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, calories, steps, weight);

  /// Create a copy of DailyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyProgressImplCopyWith<_$DailyProgressImpl> get copyWith =>
      __$$DailyProgressImplCopyWithImpl<_$DailyProgressImpl>(this, _$identity);
}

abstract class _DailyProgress implements DailyProgress {
  const factory _DailyProgress(
      {required final DateTime date,
      required final int calories,
      required final int steps,
      required final double weight}) = _$DailyProgressImpl;

  @override
  DateTime get date;
  @override
  int get calories;
  @override
  int get steps;
  @override
  double get weight;

  /// Create a copy of DailyProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyProgressImplCopyWith<_$DailyProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
