import 'package:flutter/foundation.dart';

@immutable
class OnboardingContent {
  final String title;
  final String description;

  const OnboardingContent({
    required this.title,
    required this.description,
  });
}