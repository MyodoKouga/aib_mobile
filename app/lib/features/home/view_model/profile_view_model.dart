import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../model/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileViewModel extends StateNotifier<ProfileState> {
  final ImagePicker _imagePicker = ImagePicker();
  ProfileViewModel() : super(const ProfileState());

  // ローカルストレージからプロフィール情報を読み取る
  Future<void> loadProfileFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final username = prefs.getString('username') ?? 'ゲスト';
      final email = prefs.getString('email') ?? '';
      final bio = prefs.getString('bio') ?? 'よろしくお願いします！';
      final avatarUrl = prefs.getString('avatarUrl') ?? "https://via.placeholder.com/150";
      final isEmailVerified = prefs.getBool('isEmailVerified') ?? false;
      final lastUpdatedStr = prefs.getString('lastUpdated');

      // preferencesの読み込み
      final preferencesStr = prefs.getString('preferences');
      final Map<String, dynamic> preferences =
          preferencesStr != null ? Map<String, dynamic>.from(jsonDecode(preferencesStr)) : {};

      state = state.copyWith(
        username: username,
        email: email,
        bio: bio,
        avatarUrl: avatarUrl,
        isGuest: username == 'ゲスト',
        isEmailVerified: isEmailVerified,
        lastUpdated: lastUpdatedStr != null ? DateTime.parse(lastUpdatedStr) : null,
        preferences: preferences,
        isProfileComplete: username != 'ゲスト' && email.isNotEmpty && bio.isNotEmpty && avatarUrl.isNotEmpty,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: "プロフィール情報の読み込みに失敗しました。",
        isLoading: false,
      );
    }
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
      final now = DateTime.now();
      await prefs.setString('lastUpdated', now.toIso8601String());

      final isGuest = username == 'ゲスト';
      await prefs.setBool('isGuest', isGuest);

      state = state.copyWith(
        username: username,
        bio: bio,
        isGuest: isGuest,
        lastUpdated: now,
        isLoading: false,
        isProfileComplete: state.hasCompleteProfile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "プロフィールの更新に失敗しました。",
      );
    }
  }

  /// ユーザー名のみを更新する（API & ローカル保存）
  Future<bool> updateUsername(int userId, String newUsername) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final uri = Uri.parse('http://localhost:8000/update/update_username');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'new_username': newUsername,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', newUsername);
      final now = DateTime.now();
      await prefs.setString('lastUpdated', now.toIso8601String());

      final isGuest = newUsername == 'ゲスト';
      await prefs.setBool('isGuest', isGuest);

      final isProfileComplete =
          state.copyWith(username: newUsername).hasCompleteProfile;

      state = state.copyWith(
        username: newUsername,
        isGuest: isGuest,
        lastUpdated: now,
        isLoading: false,
        isProfileComplete: isProfileComplete,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "ユーザー名の更新に失敗しました。",
      );
      return false;
    }
  }

  // メールアドレスの更新
  Future<void> updateEmail(String email, {bool verified = false}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setBool('isEmailVerified', verified);

      state = state.copyWith(
        email: email,
        isEmailVerified: verified,
        isLoading: false,
        isProfileComplete: state.hasCompleteProfile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "メールアドレスの更新に失敗しました。",
      );
    }
  }

  // メールアドレス変更API呼び出し
  Future<bool> changeEmail({
    required int userId,
    required String password,
    required String newEmail,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final uri = Uri.parse('http://localhost:8000/update/update_email');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'password': password,
          'new_email': newEmail,
        }),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', newEmail);
        state = state.copyWith(email: newEmail, isLoading: false);
        return true;
      } else {
        final body = jsonDecode(response.body);
        final detail = body['detail']?.toString() ?? '';
        final isPasswordError = response.statusCode == 401 ||
            detail.contains('password') ||
            detail.contains('パスワード');
        state = state.copyWith(
          isLoading: false,
          errorMessage: isPasswordError
              ? 'パスワードが間違っています'
              : detail.isNotEmpty
                  ? detail
                  : 'メールアドレスの更新に失敗しました。',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'メールアドレスの更新に失敗しました。',
      );
      return false;
    }
  }

  // パスワード変更API呼び出し
  Future<bool> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final uri = Uri.parse('http://localhost:8000/update/update_password');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        final body = jsonDecode(response.body);
        final detail = body['detail']?.toString() ?? '';
        final isPasswordError = response.statusCode == 401 ||
            detail.contains('password') ||
            detail.contains('パスワード');
        state = state.copyWith(
          isLoading: false,
          errorMessage: isPasswordError
              ? 'パスワードが間違っています'
              : detail.isNotEmpty
                  ? detail
                  : 'パスワードの更新に失敗しました。',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'パスワードの更新に失敗しました。',
      );
      return false;
    }
  }

  // 画像アップロード
  Future<void> uploadProfileImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image == null) return;

      state = state.copyWith(
        isUploadingImage: true,
        imageUploadError: null,
        uploadProgress: 0,
      );

      // TODO: 実際のAPIを使用する場合はここで画像をアップロード
      // アップロード進捗のシミュレーション
      for (var i = 0; i <= 100; i += 20) {
        if (!mounted) return; // StateNotifierが破棄されている場合は処理を中断
        await Future.delayed(const Duration(milliseconds: 100));
        state = state.copyWith(uploadProgress: i);
      }

      // ローカルストレージに画像パスを保存
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarUrl', image.path);

      state = state.copyWith(
        avatarUrl: image.path,
        isUploadingImage: false,
        uploadProgress: 100,
        lastUpdated: DateTime.now(),
        isProfileComplete: state.hasCompleteProfile,
      );
    } catch (e) {
      state = state.copyWith(
        isUploadingImage: false,
        imageUploadError: "画像のアップロードに失敗しました: ${e.toString()}",
        uploadProgress: 0,
      );
    }
  }

  // ユーザー設定の更新
  Future<void> updatePreferences(Map<String, dynamic> newPreferences) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final preferencesJson = jsonEncode(Map<String, dynamic>.from(newPreferences));
      await prefs.setString('preferences', preferencesJson);

      state = state.copyWith(
        preferences: Map<String, dynamic>.from(newPreferences),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: "設定の更新に失敗しました。",
      );
    }
  }

  // エラーのリセット
  void resetErrorMessage() {
    state = state.copyWith(
      errorMessage: null,
      imageUploadError: null,
    );
  }

  void setErrorMessage(String message) {
    state = state.copyWith(errorMessage: message);
  }
}

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel();
});
