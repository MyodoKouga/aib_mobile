import 'dart:ui';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/features/create/model/create_char_model.dart';
import 'package:app/features/create/view_model/create_char_view_model.dart';

class CreateCharacterScreen extends ConsumerStatefulWidget {
  const CreateCharacterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends ConsumerState<CreateCharacterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final statusFields = ['HP', 'ATK', 'DEF', 'AGI', 'LUK'];
  late final Map<String, TextEditingController> _controllers;

  final int totalPoints = 50;
  int get usedPoints => statusValues.values.reduce((sum, val) => sum + val);

  Map<String, int> statusValues = {
    'HP': 0,
    'ATK': 0,
    'DEF': 0,
    'AGI': 0,
    'LUK': 0,
  };

  @override
  void initState() {
    super.initState();
    _controllers = {
      'キャラクター名': TextEditingController(),
      '攻撃スキル': TextEditingController(),
      '防御スキル': TextEditingController(),
      '必殺技': TextEditingController(),
      '必殺技説明': TextEditingController(),
      'HP': TextEditingController(text: statusValues['HP'].toString()),
      'ATK': TextEditingController(text: statusValues['ATK'].toString()),
      'DEF': TextEditingController(text: statusValues['DEF'].toString()),
      'AGI': TextEditingController(text: statusValues['AGI'].toString()),
      'LUK': TextEditingController(text: statusValues['LUK'].toString()),
    };
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
      final character = Character(
        pattern: 'P1',
        userId: 3,
        characterName: _controllers['キャラクター名']!.text,
        hp: statusValues['HP'] ?? 0,
        atk: statusValues['ATK'] ?? 0,
        def: statusValues['DEF'] ?? 0,
        agi: statusValues['AGI'] ?? 0,
        luk: statusValues['LUK'] ?? 0,
        attackSkill: _controllers['攻撃スキル']!.text,
        defenseSkill: _controllers['防御スキル']!.text,
        specialMove: _controllers['必殺技']!.text,
        specialDetail: _controllers['必殺技説明']!.text,
      );
      final success = await ref.read(createCharViewModelProvider.notifier).submitCharacter(character);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: _buildNeumorphicAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: NeumorphicContainer(
          radius: 16.r,
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildField('キャラクター名'),
                Column(
                  children: [
                    Text('ステータスポイント', style: TextStyle(fontSize: 14.sp)),
                    Text('残りポイント: ${totalPoints - usedPoints}',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                ...statusFields.map(_buildStatusRow),
                SizedBox(height: 12.h),
                _buildField('攻撃スキル'),
                _buildField('防御スキル'),
                _buildField('必殺技'),
                _buildField('必殺技説明'),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 197, 197, 197),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _submitCharacter,
                  child: const Text('キャラクターを作成'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNeumorphicAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.h),
      child: NeumorphicContainer(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('キャラクター作成', style: TextStyle(fontSize: 18.sp)),
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label: ${statusValues[label]}', style: TextStyle(fontSize: 16.sp)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: statusValues[label]! > 0
                    ? () => setState(() => statusValues[label] = statusValues[label]! - 1)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: usedPoints < totalPoints
                    ? () => setState(() => statusValues[label] = statusValues[label]! + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label) {
    final isMultiline = label == '必殺技説明';

    return NeumorphicContainer(
      radius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: isMultiline ? 12.h : 0),
      child: TextFormField(
        controller: _controllers[label],
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        maxLines: isMultiline ? 5 : 1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelを入力してください。';
          }
          return null;
        },
      ),
    );
  }
}

class CharacterCreationSuccessPage extends StatelessWidget {
  const CharacterCreationSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: NeumorphicContainer(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('キャラクター作成', style: TextStyle(fontSize: 18.sp)),
          ),
        ),
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