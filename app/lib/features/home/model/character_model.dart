import 'dart:convert';
import 'dart:typed_data';

class Character {
  final int id;
  final String name;
  final Uint8List? image;

  Character({
    required this.id,
    required this.name,
    this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final base64Image = json['image_path'] as String?;
    Uint8List? imageBytes;

    if (base64Image != null && base64Image.isNotEmpty) {
      imageBytes = base64Decode(base64Image);
    }

    return Character(
      id: json['char_id'] as int,
      name: json['char_name'] as String,
      image: imageBytes,
    );
  }
}
