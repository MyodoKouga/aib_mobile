import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:app/features/create/view/select_char_pattern_screen.dart';
import 'package:app/features/battle/view/single_battle_patterns_screen.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState()) {
    loadCharacters();
    fetchCharacterImage(); // キャラクター画像を取得
    fetchCharacterInfo(); // キャラクター情報を取得
    fetchUserPoints(); // ポイントを取得
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

  Future<void> fetchCharacterImage() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final userId = 1;
      final mainCharId = 1;

      final url = Uri.parse('http://localhost:8000/get/char_image');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      state = state.copyWith(
        isLoading: false,
        characterImage: response.bodyBytes,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '画像の取得に失敗しました',
      );
    }
  }

  Future<void> fetchCharacterInfo() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final userId = 1;

      final url = Uri.parse('http://localhost:8000/get/char_info');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final characterName = data['char_name'] as String?;

      state = state.copyWith(
        isLoading: false,
        characterName: characterName,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'キャラクター情報の取得に失敗しました',
      );
    }
  }

  Future<void> fetchUserPoints() async {
    try {
      final userId = 1;

      final url = Uri.parse('http://localhost:8000/get/points'); // ← ここはAPIのURLに合わせてね
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final points = data['points'] as int;

      state = state.copyWith(points: points);
    } catch (e) {
      state = state.copyWith(errorMessage: 'ポイントの取得に失敗しました');
    }
  }

  void handleCreateButtonPress(BuildContext context) {
    if (state.showTutorialOverlay) {
      completeTutorial();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SelectCharPatternScreen()),
    );
  }

  void handleBattleButtonPress(BuildContext context) {
    if (state.showTutorialOverlay) {
      completeTutorial();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SingleBattlePatternsScreen()),
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
