import 'package:flutter/material.dart';

class CharacterChangeScreen extends StatelessWidget {
  const CharacterChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('キャラクター変更'),
      ),
      body: Column(
        children: [
          // タイトルテキスト
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '使用可能キャラクター',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // キャラクターカードのグリッド
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 横に3つ並べる
                  crossAxisSpacing: 8, // 横方向のスペース
                  mainAxisSpacing: 8, // 縦方向のスペース
                  childAspectRatio: 3 / 4, // カードのアスペクト比 (幅:高さ)
                ),
                itemCount: 15, // 仮で15個のカードを用意
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // 仮の背景色
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'キャラ画像',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'キャラクター名 ${index + 1}', // 仮のキャラクター名
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // 新規作成ボタン
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 48.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // 新規作成ボタンの色
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // 新規作成処理
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('新規作成ボタンが押されました')),
                  );
                },
                child: const Text('AIキャラクター新規作成'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
