import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:app/features/create/view/create_char_screen.dart';
import 'package:app/features/battle/view/single_battle_screen.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState()) {
    fetchUserInfo(); // ユーザー情報を取得
    // loadCharacters();
  }
  void openNotificationModal() {
    state = state.copyWith(showNotificationModal: true);
  }

  void closeNotificationModal() {
    state = state.copyWith(showNotificationModal: false);
  }

  void changeTab(BottomNavItem tab) {
    state = state.copyWith(currentTab: tab);
  }

  Future<void> loadCharacters() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await Future.delayed(const Duration(seconds: 1)); // 仮の遅延

      final characters = []; // TODO: Characterクラスの実装後にデータ追加

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

  Future<void> fetchUserInfo() async {
    try {
      final userId = 1;
      final url = Uri.parse('http://localhost:8000/get/user_info');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      debugPrint('サーバーからのレスポンス: $data');

      final userName = data['user_name'] as String?;
      final points = int.tryParse('${data['user_point']}') ?? 0;
      final characterName = data['mycharacter_name'] as String?;
      final battleFlg = data['battle_wait_flg'] as int;

      Uint8List? characterImage;
      final base64Image = data['mycharacter_image_path'] as String?;
      if (base64Image != null) {
        characterImage = base64Decode(base64Image);
      }

      state = state.copyWith(
        isLoading: false,
        userName: userName,
        points: points,
        battleFlg: battleFlg,
        characterName: characterName,
        characterImage: characterImage,
      );
    } catch (e) {
      debugPrint('エラー: $e');
      state = state.copyWith(errorMessage: 'ユーザー情報の取得に失敗しました');
    }
  }

  // キャラ作成画面へ遷移
  void handleCreateButtonPress(BuildContext context) {
  if (state.showTutorialOverlay) {
    completeTutorial();
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CreateCharacterScreen()),
  );
}

  // シングルバトル画面へ遷移
  void handleBattleButtonPress(BuildContext context) {
    if (state.showTutorialOverlay) {
      completeTutorial();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SingleBattleScreen()),
    );
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
