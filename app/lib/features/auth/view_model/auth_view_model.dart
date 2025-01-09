import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel();
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel() : super(const AuthState());

  /// ユーザー登録
  Future<void> signUpWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // バックエンドAPIのURL
      final url = Uri.parse("http://localhost:8000/register");

      // リクエストボディを作成
      final requestBody = jsonEncode({
        'email': email,
        'password': password,
      });

      final response = await http.post(
        url,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 正常登録
        state = state.copyWith(isLoading: false);
      } else {
        // UTF-8でレスポンスをデコード
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));

        if (decoded['detail'] is List) {
          // エラーリストを結合して表示
          final errorMessages = (decoded['detail'] as List).join("\n");
          throw Exception(errorMessages);
        } else {
          throw Exception(decoded['detail'] ?? '登録に失敗しました');
        }
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      );
    }
  }

  /// 既存のサインイン
  Future<void> signInWithEmail() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: 認証処理の実装
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '認証に失敗しました。もう一度お試しください。',
      );
    }
  }

  /// 既存のスキップ処理
  Future<void> skipAuth() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'エラーが発生しました。もう一度お試しください。',
      );
    }
  }

  void resetErrorMessage() {
    state = state.copyWith(errorMessage: null);
  }

  void setErrorMessage(String message) {
    state = state.copyWith(errorMessage: message);
  }
}
