import 'package:flutter/material.dart';

class AnimatedTabContainer extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedTabContainer({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}