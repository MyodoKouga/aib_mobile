import 'package:flutter/material.dart';

enum BottomNavItem {
  home,
  battle,
  profile;

  String get label {
    switch (this) {
      case BottomNavItem.home:
        return 'ホーム';
      case BottomNavItem.battle:
        return 'バトル';
      case BottomNavItem.profile:
        return 'マイページ';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavItem.home:
        return Icons.home;
      case BottomNavItem.battle:
        return Icons.sports_kabaddi;
      case BottomNavItem.profile:
        return Icons.person;
    }
  }
}
