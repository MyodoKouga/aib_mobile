// character_detail_model.dart
import 'dart:typed_data';

class CharacterDetail {
  final int id;
  final String name;
  final int hp;
  final int atk;
  final int def;
  final int agi;
  final int luk;
  final String attackSkill;
  final String defenseSkill;
  final String specialMove;
  final String specialDetail;
  final int totalUsePoint;
  final Uint8List? image;
  int isMainChar;

  CharacterDetail({
    required this.id,
    required this.name,
    required this.hp,
    required this.atk,
    required this.def,
    required this.agi,
    required this.luk,
    required this.attackSkill,
    required this.defenseSkill,
    required this.specialMove,
    required this.specialDetail,
    required this.totalUsePoint,
    this.image,
    required this.isMainChar,
  });

  factory CharacterDetail.fromJson(Map<String, dynamic> json, {Uint8List? image}) {
    return CharacterDetail(
      id: json['char_id'] ?? 0,
      name: json['char_name'] ?? '',
      hp: json['hp'] ?? 0,
      atk: json['atk'] ?? 0,
      def: json['defense'] ?? 0,
      agi: json['spe'] ?? 0,
      luk: json['luc'] ?? 0,
      attackSkill: json['attack_skill'] ?? '',
      defenseSkill: json['defense_skill'] ?? '',
      specialMove: json['special_move'] ?? '',
      specialDetail: json['special_detail'] ?? '',
      totalUsePoint: json['total_use_point'] ?? 0,
      image: image, 
      isMainChar: json['is_main_char'] ?? 0,
    );
  }

}
