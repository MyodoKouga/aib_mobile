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

    // チュートリアル関連の状態を追加
    @Default(false) bool isFirstLogin,
    @Default(false) bool showTutorialDialog,
    @Default(false) bool showTutorialOverlay,
  }) = _HomeState;
}
