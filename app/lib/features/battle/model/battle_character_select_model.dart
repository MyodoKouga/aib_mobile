import 'dart:typed_data';

class BattleCharacter {
  final int id;
  final String name;
  final Uint8List? image;
  final int hp;
  final int atk;
  final int def;
  final int agi;
  final int luk;
  int isMainChar;
  final String attackSkill;
  final String defenseSkill;
  final String specialMove;
  final String specialDetail;
  final int totalUsePoint;

  BattleCharacter({
    required this.id,
    required this.name,
    required this.image,
    required this.hp,
    required this.atk,
    required this.def,
    required this.agi,
    required this.luk,
    required this.isMainChar,
    required this.attackSkill,
    required this.defenseSkill,
    required this.specialMove,
    required this.specialDetail,
    required this.totalUsePoint,
  });

  factory BattleCharacter.fromJson(Map<String, dynamic> json) {
    return BattleCharacter(
      id: json['id'],
      name: json['name'],
      image: json['image'], // Uint8List変換済みならOK
      hp: json['hp'],
      atk: json['atk'],
      def: json['def'],
      agi: json['agi'],
      luk: json['luk'],
      isMainChar: json['is_main_char'],
      attackSkill: json['attack_skill'],
      defenseSkill: json['defense_skill'],
      specialMove: json['special_move'],
      specialDetail: json['special_detail'],
      totalUsePoint: json['total_use_point'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'hp': hp,
      'atk': atk,
      'def': def,
      'agi': agi,
      'luk': luk,
      'is_main_char': isMainChar,
      'attack_skill': attackSkill,
      'defense_skill': defenseSkill,
      'special_move': specialMove,
      'special_detail': specialDetail,
      'total_use_point': totalUsePoint,
    };
  }
}
