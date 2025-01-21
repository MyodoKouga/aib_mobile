import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateCharacterScreen extends StatefulWidget {
  final String patternName;

  const CreateCharacterScreen({Key? key, required this.patternName}) : super(key: key);

  @override
  _CreateCharacterScreenState createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = {
      'キャラクター名': TextEditingController(),
      'HP': TextEditingController(),
      '攻撃スキル': TextEditingController(),
      '防御スキル': TextEditingController(),
      '必殺技': TextEditingController(),
    };

    if (widget.patternName == 'I4') {
      _controllers['アイテム'] = TextEditingController();
    } else if (widget.patternName == 'I5') {
      _controllers['タイプ'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitCharacter() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> characterData = {
        'pattern': widget.patternName,
        'character_name': _controllers['キャラクター名']!.text,
        'hp': int.tryParse(_controllers['HP']!.text) ?? 0,
        'attack_skill': _controllers['攻撃スキル']!.text,
        'defense_skill': _controllers['防御スキル']!.text,
        'special_move': _controllers['必殺技']!.text,
      };

      if (widget.patternName == 'I4') {
        characterData['item'] = _controllers['アイテム']?.text;
      } else if (widget.patternName == 'I5') {
        characterData['type'] = _controllers['タイプ']?.text;
      }

      final success = await _registerCharacter(characterData);

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CharacterCreationSuccessPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('登録に失敗しました。もう一度お試しください。')),
        );
      }
    }
  }

  Future<bool> _registerCharacter(Map<String, dynamic> data) async {
    String endpoint;

    switch (widget.patternName) {
      case 'I1':
        endpoint = 'http://localhost:8000/create/patternI1';
        break;
      case 'I2':
        endpoint = 'http://localhost:8000/create/patternI2';
        break;
      case 'I3':
        endpoint = 'http://localhost:8000/create/patternI3';
        break;
      case 'I4':
        endpoint = 'http://localhost:8000/create/patternI4';
        break;
      case 'I5':
        endpoint = 'http://localhost:8000/create/patternI5';
        break;
      default:
        endpoint = 'http://localhost:8000/create/default';
    }

    final url = Uri.parse(endpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('サーバーエラー: ${errorResponse['detail'] ?? response.statusCode}');
      }
    } catch (e) {
      throw Exception('サーバー通信に失敗しました: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.patternName} 用キャラクター作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ..._controllers.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: entry.key,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '${entry.key}を入力してください。';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitCharacter,
                  child: const Text('登録'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterCreationSuccessPage extends StatelessWidget {
  const CharacterCreationSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('キャラクター作成完了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'キャラクターを作成しました',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Homeへ'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('バトルへ'),
            ),
          ],
        ),
      ),
    );
  }
}
