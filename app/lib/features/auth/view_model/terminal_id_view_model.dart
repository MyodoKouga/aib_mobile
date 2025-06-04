import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// 端末IDを取得する FutureProvider
final terminalIdProvider = FutureProvider<String?>((ref) async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  } else {
    return null;
  }
});

/// terminal_id をバックエンドに登録する Notifier
class TerminalIdRegistrar extends Notifier<void> {
  Future<bool> registerTerminalId(String terminalId) async {
    final url = Uri.parse('http://localhost:8000/register/register_terminal_id');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'terminal_id': terminalId}),
    );

    return response.statusCode == 200;
  }

  @override
  void build() {} // `Notifier<void>` の場合 buildは空でOK
}

/// NotifierProvider の定義（こっちだけ残す）
final terminalIdRegisterProvider =
    NotifierProvider<TerminalIdRegistrar, void>(() => TerminalIdRegistrar());

/// 端末IDからユーザーIDを取得するプロバイダー
final userIdFromTerminalProvider =
    FutureProvider.family<int?, String>((ref, terminalId) async {
  final url = Uri.parse('http://localhost:8000/get/user_id');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'terminal_id': terminalId}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['user_id'] as int?;
  }
  return null;
});
