// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingPage {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isLastPage => throw _privateConstructorUsedError;
  String? get buttonText => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingPageCopyWith<OnboardingPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingPageCopyWith<$Res> {
  factory $OnboardingPageCopyWith(
          OnboardingPage value, $Res Function(OnboardingPage) then) =
      _$OnboardingPageCopyWithImpl<$Res, OnboardingPage>;
  @useResult
  $Res call(
      {String title,
      String subtitle,
      String imageUrl,
      bool isLastPage,
      String? buttonText});
}

/// @nodoc
class _$OnboardingPageCopyWithImpl<$Res, $Val extends OnboardingPage>
    implements $OnboardingPageCopyWith<$Res> {
  _$OnboardingPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
    Object? isLastPage = null,
    Object? buttonText = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLastPage: null == isLastPage
          ? _value.isLastPage
          : isLastPage // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonText: freezed == buttonText
          ? _value.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingPageImplCopyWith<$Res>
    implements $OnboardingPageCopyWith<$Res> {
  factory _$$OnboardingPageImplCopyWith(_$OnboardingPageImpl value,
          $Res Function(_$OnboardingPageImpl) then) =
      __$$OnboardingPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String subtitle,
      String imageUrl,
      bool isLastPage,
      String? buttonText});
}

/// @nodoc
class __$$OnboardingPageImplCopyWithImpl<$Res>
    extends _$OnboardingPageCopyWithImpl<$Res, _$OnboardingPageImpl>
    implements _$$OnboardingPageImplCopyWith<$Res> {
  __$$OnboardingPageImplCopyWithImpl(
      _$OnboardingPageImpl _value, $Res Function(_$OnboardingPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
    Object? isLastPage = null,
    Object? buttonText = freezed,
  }) {
    return _then(_$OnboardingPageImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLastPage: null == isLastPage
          ? _value.isLastPage
          : isLastPage // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonText: freezed == buttonText
          ? _value.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OnboardingPageImpl implements _OnboardingPage {
  const _$OnboardingPageImpl(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.isLastPage,
      this.buttonText});

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String imageUrl;
  @override
  final bool isLastPage;
  @override
  final String? buttonText;

  @override
  String toString() {
    return 'OnboardingPage(title: $title, subtitle: $subtitle, imageUrl: $imageUrl, isLastPage: $isLastPage, buttonText: $buttonText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingPageImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isLastPage, isLastPage) ||
                other.isLastPage == isLastPage) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, subtitle, imageUrl, isLastPage, buttonText);

  /// Create a copy of OnboardingPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingPageImplCopyWith<_$OnboardingPageImpl> get copyWith =>
      __$$OnboardingPageImplCopyWithImpl<_$OnboardingPageImpl>(
          this, _$identity);
}

abstract class _OnboardingPage implements OnboardingPage {
  const factory _OnboardingPage(
      {required final String title,
      required final String subtitle,
      required final String imageUrl,
      required final bool isLastPage,
      final String? buttonText}) = _$OnboardingPageImpl;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get imageUrl;
  @override
  bool get isLastPage;
  @override
  String? get buttonText;

  /// Create a copy of OnboardingPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingPageImplCopyWith<_$OnboardingPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
