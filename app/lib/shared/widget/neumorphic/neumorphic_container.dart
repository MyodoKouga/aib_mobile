import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool isPressed;
  final bool isInverted;
  final double radius;
  
  const NeumorphicContainer({
    required this.child,
    this.padding,
    this.isPressed = false,
    this.isInverted = false,
    this.radius = 15.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: isInverted ? _getInvertedShadows() : _getDefaultShadows(),
      ),
      child: child,
    );
  }

  List<BoxShadow> _getDefaultShadows() => [
    BoxShadow(
      color: Colors.white.withOpacity(0.8),
      offset: Offset(isPressed ? 4 : -4, isPressed ? 4 : -4),
      blurRadius: 15,
    ),
    BoxShadow(
      color: const Color(0xFFA3B1C6).withOpacity(0.5),
      offset: Offset(isPressed ? -4 : 4, isPressed ? -4 : 4),
      blurRadius: 15,
    ),
  ];

  List<BoxShadow> _getInvertedShadows() => _getDefaultShadows().map((shadow) => 
    BoxShadow(
      color: shadow.color,
      offset: -shadow.offset,
      blurRadius: shadow.blurRadius,
    )
  ).toList();
}