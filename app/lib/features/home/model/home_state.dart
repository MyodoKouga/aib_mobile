import 'dart:ffi';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'bottom_nav_item.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(BottomNavItem.home) BottomNavItem currentTab,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<dynamic> characters, // TODO: Characterクラス実装後に型を変更

    // チュートリアル関連の状態
    @Default(false) bool isFirstLogin,
    @Default(false) bool showTutorialDialog,
    @Default(false) bool showTutorialOverlay,

    // キャラクター情報を追加
    Uint8List? characterImage,
    String? characterName,
    String? specialMove,

    // ユーザー情報
    String? userName,
    int? userId,
    String? myCharId,
    @Default(0) int battleFlg,
    @Default(0) int points,

    // お知らせモーダル
    @Default(false) bool showNotificationModal,

  }) = _HomeState;
}
