import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel();
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel() : super(const AuthState());

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
}
