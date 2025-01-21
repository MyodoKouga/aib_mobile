import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._(); // private constructor を追加

  const factory ProfileState({
    @Default("") String username, // ユーザー名
    @Default("") String email, // メールアドレス
    @Default("") String bio, // 自己紹介文
    @Default("") String avatarUrl, // プロフィール画像URL
    @Default(false) bool isLoading, // 読み込み中の状態
    String? errorMessage, // エラーメッセージ
    @Default(false) bool isGuest, // ゲストユーザーかどうか
    @Default(false) bool isEmailVerified, // メール認証済みかどうか
    @Default(false) bool isProfileComplete, // プロフィール情報が完全かどうか
    DateTime? lastUpdated, // プロフィールの最終更新日時
    @Default({}) Map<String, dynamic> preferences, // ユーザー設定情報
    @Default(false) bool isUploadingImage, // 画像アップロード中かどうか
    String? imageUploadError, // 画像アップロード時のエラーメッセージ
    @Default(0) int uploadProgress, // アップロードの進捗（0-100）
  }) = _ProfileState;

  bool get hasCompleteProfile =>
      username.isNotEmpty && username != 'ゲスト' && email.isNotEmpty && bio.isNotEmpty && avatarUrl.isNotEmpty;

  bool get hasValidImage => avatarUrl.isNotEmpty && (avatarUrl.startsWith('http') || avatarUrl.startsWith('/'));
}
