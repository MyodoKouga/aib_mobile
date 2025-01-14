import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel() : super(const ProfileState());

  // ローカルストレージからプロフィール情報を読み取る
  Future<void> loadProfileFromLocal() async {
    final prefs = await SharedPreferences.getInstance();

    state = state.copyWith(
      username: prefs.getString('username') ?? 'ゲスト',
      bio: prefs.getString('bio') ?? 'よろしくお願いします！',
      avatarUrl: prefs.getString('avatarUrl') ?? "https://via.placeholder.com/150",
    );
  }

  // プロフィール更新（ローカル保存も反映）
  Future<void> updateProfile(String username, String bio) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // ダミーのAPI呼び出し
      await Future.delayed(const Duration(seconds: 1));

      // ローカルストレージに保存
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('bio', bio);

      state = state.copyWith(
        username: username,
        bio: bio,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "プロフィールの更新に失敗しました。",
      );
    }
  }

  // エラーのリセット
  void resetErrorMessage() {
    state = state.copyWith(errorMessage: null);
  }
}

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel();
});
