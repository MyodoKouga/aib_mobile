class Character {
  final String pattern;
  final int userId;
  final String characterName;
  final int hp;
  final int atk;
  final int def;
  final int agi;
  final int luk;
  final String attackSkill;
  final String defenseSkill;
  final String specialMove;
  final String specialDetail;

  Character({
    required this.pattern,
    required this.userId,
    required this.characterName,
    required this.hp,
    required this.atk,
    required this.def,
    required this.agi,
    required this.luk,
    required this.attackSkill,
    required this.defenseSkill,
    required this.specialMove,
    required this.specialDetail,
  });

  Map<String, dynamic> toJson() => {
    "pattern": pattern,
    "user_id": userId,
    "character_name": characterName,
    "hp": hp,
    "atk": atk,
    "defense": def,
    "spe": agi,
    "luc": luk,
    "attack_skill": attackSkill,
    "defense_skill": defenseSkill,
    "special_move": specialMove,
    "special_detail": specialDetail,
  };
}
