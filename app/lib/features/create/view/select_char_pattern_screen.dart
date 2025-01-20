import 'package:flutter/material.dart';
import 'package:app/features/create/view/create_char_screen.dart';

class SelectCharPatternScreen extends StatefulWidget {
  const SelectCharPatternScreen({Key? key}) : super(key: key);

  @override
  _SelectCharPatternScreenState createState() => _SelectCharPatternScreenState();
}

class _SelectCharPatternScreenState extends State<SelectCharPatternScreen> {
  String? selectedPattern;
  final List<String> patterns = ['I1', 'I2', 'I3', 'I4', 'I5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('開発用ページ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '作成パターンを選択してください:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedPattern,
              hint: const Text('選択してください'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPattern = newValue;
                });
              },
              items: patterns.map((String pattern) {
                return DropdownMenuItem<String>(
                  value: pattern,
                  child: Text(pattern),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedPattern != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateCharacterScreen(patternName: selectedPattern!),
                          ),
                        );
                      }
                    : null,
                child: const Text('作成ページへ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
