import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default("") String username, // ユーザー名
    @Default("") String email, // メールアドレス
    @Default("") String bio, // 自己紹介文
    @Default("") String avatarUrl, // プロフィール画像URL
    @Default(false) bool isLoading, // 読み込み中の状態
    String? errorMessage, // エラーメッセージ
  }) = _ProfileState;
}
