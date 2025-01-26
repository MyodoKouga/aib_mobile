import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState()) {
    // 初期化時にキャラクター一覧を取得
    loadCharacters();
  }

  void changeTab(BottomNavItem tab) {
    state = state.copyWith(currentTab: tab);
  }

  Future<void> loadCharacters() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: キャラクター一覧の取得処理を実装
      await Future.delayed(const Duration(seconds: 1)); // 仮の遅延

      // 仮のデータ
      final characters = []; // TODO: Characterクラスの実装後に仮データを追加

      state = state.copyWith(
        isLoading: false,
        characters: characters,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'キャラクター情報の取得に失敗しました',
      );
    }
  }

  void initializeTutorial() {
    state = state.copyWith(
      isFirstLogin: true,
      showTutorialDialog: true,
    );
  }

  void closeTutorialDialog() {
    state = state.copyWith(
      showTutorialDialog: false,
      showTutorialOverlay: true,
    );
  }

  void completeTutorial() {
    state = state.copyWith(
      isFirstLogin: false,
      showTutorialOverlay: false,
    );
  }
}
