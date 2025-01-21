// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  String get username => throw _privateConstructorUsedError; // ユーザー名
  String get email => throw _privateConstructorUsedError; // メールアドレス
  String get bio => throw _privateConstructorUsedError; // 自己紹介文
  String get avatarUrl => throw _privateConstructorUsedError; // プロフィール画像URL
  bool get isLoading => throw _privateConstructorUsedError; // 読み込み中の状態
  String? get errorMessage => throw _privateConstructorUsedError; // エラーメッセージ
  bool get isGuest => throw _privateConstructorUsedError; // ゲストユーザーかどうか
  bool get isEmailVerified => throw _privateConstructorUsedError; // メール認証済みかどうか
  bool get isProfileComplete =>
      throw _privateConstructorUsedError; // プロフィール情報が完全かどうか
  DateTime? get lastUpdated =>
      throw _privateConstructorUsedError; // プロフィールの最終更新日時
  Map<String, dynamic> get preferences =>
      throw _privateConstructorUsedError; // ユーザー設定情報
  bool get isUploadingImage =>
      throw _privateConstructorUsedError; // 画像アップロード中かどうか
  String? get imageUploadError =>
      throw _privateConstructorUsedError; // 画像アップロード時のエラーメッセージ
  int get uploadProgress => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {String username,
      String email,
      String bio,
      String avatarUrl,
      bool isLoading,
      String? errorMessage,
      bool isGuest,
      bool isEmailVerified,
      bool isProfileComplete,
      DateTime? lastUpdated,
      Map<String, dynamic> preferences,
      bool isUploadingImage,
      String? imageUploadError,
      int uploadProgress});
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? bio = null,
    Object? avatarUrl = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isGuest = null,
    Object? isEmailVerified = null,
    Object? isProfileComplete = null,
    Object? lastUpdated = freezed,
    Object? preferences = null,
    Object? isUploadingImage = null,
    Object? imageUploadError = freezed,
    Object? uploadProgress = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isGuest: null == isGuest
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isUploadingImage: null == isUploadingImage
          ? _value.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUploadError: freezed == imageUploadError
          ? _value.imageUploadError
          : imageUploadError // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadProgress: null == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
          _$ProfileStateImpl value, $Res Function(_$ProfileStateImpl) then) =
      __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String email,
      String bio,
      String avatarUrl,
      bool isLoading,
      String? errorMessage,
      bool isGuest,
      bool isEmailVerified,
      bool isProfileComplete,
      DateTime? lastUpdated,
      Map<String, dynamic> preferences,
      bool isUploadingImage,
      String? imageUploadError,
      int uploadProgress});
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
      _$ProfileStateImpl _value, $Res Function(_$ProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? bio = null,
    Object? avatarUrl = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isGuest = null,
    Object? isEmailVerified = null,
    Object? isProfileComplete = null,
    Object? lastUpdated = freezed,
    Object? preferences = null,
    Object? isUploadingImage = null,
    Object? imageUploadError = freezed,
    Object? uploadProgress = null,
  }) {
    return _then(_$ProfileStateImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isGuest: null == isGuest
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isUploadingImage: null == isUploadingImage
          ? _value.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUploadError: freezed == imageUploadError
          ? _value.imageUploadError
          : imageUploadError // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadProgress: null == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProfileStateImpl extends _ProfileState {
  const _$ProfileStateImpl(
      {this.username = "",
      this.email = "",
      this.bio = "",
      this.avatarUrl = "",
      this.isLoading = false,
      this.errorMessage,
      this.isGuest = false,
      this.isEmailVerified = false,
      this.isProfileComplete = false,
      this.lastUpdated,
      final Map<String, dynamic> preferences = const {},
      this.isUploadingImage = false,
      this.imageUploadError,
      this.uploadProgress = 0})
      : _preferences = preferences,
        super._();

  @override
  @JsonKey()
  final String username;
// ユーザー名
  @override
  @JsonKey()
  final String email;
// メールアドレス
  @override
  @JsonKey()
  final String bio;
// 自己紹介文
  @override
  @JsonKey()
  final String avatarUrl;
// プロフィール画像URL
  @override
  @JsonKey()
  final bool isLoading;
// 読み込み中の状態
  @override
  final String? errorMessage;
// エラーメッセージ
  @override
  @JsonKey()
  final bool isGuest;
// ゲストユーザーかどうか
  @override
  @JsonKey()
  final bool isEmailVerified;
// メール認証済みかどうか
  @override
  @JsonKey()
  final bool isProfileComplete;
// プロフィール情報が完全かどうか
  @override
  final DateTime? lastUpdated;
// プロフィールの最終更新日時
  final Map<String, dynamic> _preferences;
// プロフィールの最終更新日時
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

// ユーザー設定情報
  @override
  @JsonKey()
  final bool isUploadingImage;
// 画像アップロード中かどうか
  @override
  final String? imageUploadError;
// 画像アップロード時のエラーメッセージ
  @override
  @JsonKey()
  final int uploadProgress;

  @override
  String toString() {
    return 'ProfileState(username: $username, email: $email, bio: $bio, avatarUrl: $avatarUrl, isLoading: $isLoading, errorMessage: $errorMessage, isGuest: $isGuest, isEmailVerified: $isEmailVerified, isProfileComplete: $isProfileComplete, lastUpdated: $lastUpdated, preferences: $preferences, isUploadingImage: $isUploadingImage, imageUploadError: $imageUploadError, uploadProgress: $uploadProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isGuest, isGuest) || other.isGuest == isGuest) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            (identical(other.isUploadingImage, isUploadingImage) ||
                other.isUploadingImage == isUploadingImage) &&
            (identical(other.imageUploadError, imageUploadError) ||
                other.imageUploadError == imageUploadError) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      email,
      bio,
      avatarUrl,
      isLoading,
      errorMessage,
      isGuest,
      isEmailVerified,
      isProfileComplete,
      lastUpdated,
      const DeepCollectionEquality().hash(_preferences),
      isUploadingImage,
      imageUploadError,
      uploadProgress);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState extends ProfileState {
  const factory _ProfileState(
      {final String username,
      final String email,
      final String bio,
      final String avatarUrl,
      final bool isLoading,
      final String? errorMessage,
      final bool isGuest,
      final bool isEmailVerified,
      final bool isProfileComplete,
      final DateTime? lastUpdated,
      final Map<String, dynamic> preferences,
      final bool isUploadingImage,
      final String? imageUploadError,
      final int uploadProgress}) = _$ProfileStateImpl;
  const _ProfileState._() : super._();

  @override
  String get username; // ユーザー名
  @override
  String get email; // メールアドレス
  @override
  String get bio; // 自己紹介文
  @override
  String get avatarUrl; // プロフィール画像URL
  @override
  bool get isLoading; // 読み込み中の状態
  @override
  String? get errorMessage; // エラーメッセージ
  @override
  bool get isGuest; // ゲストユーザーかどうか
  @override
  bool get isEmailVerified; // メール認証済みかどうか
  @override
  bool get isProfileComplete; // プロフィール情報が完全かどうか
  @override
  DateTime? get lastUpdated; // プロフィールの最終更新日時
  @override
  Map<String, dynamic> get preferences; // ユーザー設定情報
  @override
  bool get isUploadingImage; // 画像アップロード中かどうか
  @override
  String? get imageUploadError; // 画像アップロード時のエラーメッセージ
  @override
  int get uploadProgress;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
