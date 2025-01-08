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
  }) = _HomeState;
}
