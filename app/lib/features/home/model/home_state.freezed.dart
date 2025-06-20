// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  BottomNavItem get currentTab => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  List<dynamic> get characters =>
      throw _privateConstructorUsedError; // TODO: Characterクラス実装後に型を変更
// チュートリアル関連の状態
  bool get isFirstLogin => throw _privateConstructorUsedError;
  bool get showTutorialDialog => throw _privateConstructorUsedError;
  bool get showTutorialOverlay =>
      throw _privateConstructorUsedError; // キャラクター情報を追加
  Uint8List? get characterImage => throw _privateConstructorUsedError;
  String? get characterName => throw _privateConstructorUsedError;
  String? get specialMove => throw _privateConstructorUsedError; // ユーザー情報
  String? get userName => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  String? get myCharId => throw _privateConstructorUsedError;
  int get battleFlg => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError; // お知らせモーダル
  bool get showNotificationModal => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {BottomNavItem currentTab,
      bool isLoading,
      String? errorMessage,
      List<dynamic> characters,
      bool isFirstLogin,
      bool showTutorialDialog,
      bool showTutorialOverlay,
      Uint8List? characterImage,
      String? characterName,
      String? specialMove,
      String? userName,
      int? userId,
      String? myCharId,
      int battleFlg,
      int points,
      bool showNotificationModal});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? characters = null,
    Object? isFirstLogin = null,
    Object? showTutorialDialog = null,
    Object? showTutorialOverlay = null,
    Object? characterImage = freezed,
    Object? characterName = freezed,
    Object? specialMove = freezed,
    Object? userName = freezed,
    Object? userId = freezed,
    Object? myCharId = freezed,
    Object? battleFlg = null,
    Object? points = null,
    Object? showNotificationModal = null,
  }) {
    return _then(_value.copyWith(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as BottomNavItem,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      characters: null == characters
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isFirstLogin: null == isFirstLogin
          ? _value.isFirstLogin
          : isFirstLogin // ignore: cast_nullable_to_non_nullable
              as bool,
      showTutorialDialog: null == showTutorialDialog
          ? _value.showTutorialDialog
          : showTutorialDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      showTutorialOverlay: null == showTutorialOverlay
          ? _value.showTutorialOverlay
          : showTutorialOverlay // ignore: cast_nullable_to_non_nullable
              as bool,
      characterImage: freezed == characterImage
          ? _value.characterImage
          : characterImage // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      characterName: freezed == characterName
          ? _value.characterName
          : characterName // ignore: cast_nullable_to_non_nullable
              as String?,
      specialMove: freezed == specialMove
          ? _value.specialMove
          : specialMove // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      myCharId: freezed == myCharId
          ? _value.myCharId
          : myCharId // ignore: cast_nullable_to_non_nullable
              as String?,
      battleFlg: null == battleFlg
          ? _value.battleFlg
          : battleFlg // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      showNotificationModal: null == showNotificationModal
          ? _value.showNotificationModal
          : showNotificationModal // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BottomNavItem currentTab,
      bool isLoading,
      String? errorMessage,
      List<dynamic> characters,
      bool isFirstLogin,
      bool showTutorialDialog,
      bool showTutorialOverlay,
      Uint8List? characterImage,
      String? characterName,
      String? specialMove,
      String? userName,
      int? userId,
      String? myCharId,
      int battleFlg,
      int points,
      bool showNotificationModal});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? characters = null,
    Object? isFirstLogin = null,
    Object? showTutorialDialog = null,
    Object? showTutorialOverlay = null,
    Object? characterImage = freezed,
    Object? characterName = freezed,
    Object? specialMove = freezed,
    Object? userName = freezed,
    Object? userId = freezed,
    Object? myCharId = freezed,
    Object? battleFlg = null,
    Object? points = null,
    Object? showNotificationModal = null,
  }) {
    return _then(_$HomeStateImpl(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as BottomNavItem,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      characters: null == characters
          ? _value._characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isFirstLogin: null == isFirstLogin
          ? _value.isFirstLogin
          : isFirstLogin // ignore: cast_nullable_to_non_nullable
              as bool,
      showTutorialDialog: null == showTutorialDialog
          ? _value.showTutorialDialog
          : showTutorialDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      showTutorialOverlay: null == showTutorialOverlay
          ? _value.showTutorialOverlay
          : showTutorialOverlay // ignore: cast_nullable_to_non_nullable
              as bool,
      characterImage: freezed == characterImage
          ? _value.characterImage
          : characterImage // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      characterName: freezed == characterName
          ? _value.characterName
          : characterName // ignore: cast_nullable_to_non_nullable
              as String?,
      specialMove: freezed == specialMove
          ? _value.specialMove
          : specialMove // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      myCharId: freezed == myCharId
          ? _value.myCharId
          : myCharId // ignore: cast_nullable_to_non_nullable
              as String?,
      battleFlg: null == battleFlg
          ? _value.battleFlg
          : battleFlg // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      showNotificationModal: null == showNotificationModal
          ? _value.showNotificationModal
          : showNotificationModal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.currentTab = BottomNavItem.home,
      this.isLoading = false,
      this.errorMessage,
      final List<dynamic> characters = const [],
      this.isFirstLogin = false,
      this.showTutorialDialog = false,
      this.showTutorialOverlay = false,
      this.characterImage,
      this.characterName,
      this.specialMove,
      this.userName,
      this.userId,
      this.myCharId,
      this.battleFlg = 0,
      this.points = 0,
      this.showNotificationModal = false})
      : _characters = characters;

  @override
  @JsonKey()
  final BottomNavItem currentTab;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  final List<dynamic> _characters;
  @override
  @JsonKey()
  List<dynamic> get characters {
    if (_characters is EqualUnmodifiableListView) return _characters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characters);
  }

// TODO: Characterクラス実装後に型を変更
// チュートリアル関連の状態
  @override
  @JsonKey()
  final bool isFirstLogin;
  @override
  @JsonKey()
  final bool showTutorialDialog;
  @override
  @JsonKey()
  final bool showTutorialOverlay;
// キャラクター情報を追加
  @override
  final Uint8List? characterImage;
  @override
  final String? characterName;
  @override
  final String? specialMove;
// ユーザー情報
  @override
  final String? userName;
  @override
  final int? userId;
  @override
  final String? myCharId;
  @override
  @JsonKey()
  final int battleFlg;
  @override
  @JsonKey()
  final int points;
// お知らせモーダル
  @override
  @JsonKey()
  final bool showNotificationModal;

  @override
  String toString() {
    return 'HomeState(currentTab: $currentTab, isLoading: $isLoading, errorMessage: $errorMessage, characters: $characters, isFirstLogin: $isFirstLogin, showTutorialDialog: $showTutorialDialog, showTutorialOverlay: $showTutorialOverlay, characterImage: $characterImage, characterName: $characterName, specialMove: $specialMove, userName: $userName, userId: $userId, myCharId: $myCharId, battleFlg: $battleFlg, points: $points, showNotificationModal: $showNotificationModal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.currentTab, currentTab) ||
                other.currentTab == currentTab) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._characters, _characters) &&
            (identical(other.isFirstLogin, isFirstLogin) ||
                other.isFirstLogin == isFirstLogin) &&
            (identical(other.showTutorialDialog, showTutorialDialog) ||
                other.showTutorialDialog == showTutorialDialog) &&
            (identical(other.showTutorialOverlay, showTutorialOverlay) ||
                other.showTutorialOverlay == showTutorialOverlay) &&
            const DeepCollectionEquality()
                .equals(other.characterImage, characterImage) &&
            (identical(other.characterName, characterName) ||
                other.characterName == characterName) &&
            (identical(other.specialMove, specialMove) ||
                other.specialMove == specialMove) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.myCharId, myCharId) ||
                other.myCharId == myCharId) &&
            (identical(other.battleFlg, battleFlg) ||
                other.battleFlg == battleFlg) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.showNotificationModal, showNotificationModal) ||
                other.showNotificationModal == showNotificationModal));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentTab,
      isLoading,
      errorMessage,
      const DeepCollectionEquality().hash(_characters),
      isFirstLogin,
      showTutorialDialog,
      showTutorialOverlay,
      const DeepCollectionEquality().hash(characterImage),
      characterName,
      specialMove,
      userName,
      userId,
      myCharId,
      battleFlg,
      points,
      showNotificationModal);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final BottomNavItem currentTab,
      final bool isLoading,
      final String? errorMessage,
      final List<dynamic> characters,
      final bool isFirstLogin,
      final bool showTutorialDialog,
      final bool showTutorialOverlay,
      final Uint8List? characterImage,
      final String? characterName,
      final String? specialMove,
      final String? userName,
      final int? userId,
      final String? myCharId,
      final int battleFlg,
      final int points,
      final bool showNotificationModal}) = _$HomeStateImpl;

  @override
  BottomNavItem get currentTab;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  List<dynamic> get characters; // TODO: Characterクラス実装後に型を変更
// チュートリアル関連の状態
  @override
  bool get isFirstLogin;
  @override
  bool get showTutorialDialog;
  @override
  bool get showTutorialOverlay; // キャラクター情報を追加
  @override
  Uint8List? get characterImage;
  @override
  String? get characterName;
  @override
  String? get specialMove; // ユーザー情報
  @override
  String? get userName;
  @override
  int? get userId;
  @override
  String? get myCharId;
  @override
  int get battleFlg;
  @override
  int get points; // お知らせモーダル
  @override
  bool get showNotificationModal;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
