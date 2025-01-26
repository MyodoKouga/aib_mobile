import 'package:flutter/material.dart';

class AnimatedNeumorphicContainer extends StatefulWidget {
  final Widget child;
  final bool isPressed;
  final Duration duration;
  final EdgeInsetsGeometry? padding;
  final double radius;

  const AnimatedNeumorphicContainer({
    required this.child,
    this.isPressed = false,
    this.duration = const Duration(milliseconds: 200),
    this.padding,
    this.radius = 15.0,
    super.key,
  });

  @override
  State<AnimatedNeumorphicContainer> createState() => _AnimatedNeumorphicContainerState();
}

class _AnimatedNeumorphicContainerState extends State<AnimatedNeumorphicContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: -4, end: 4).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isPressed ? _controller.forward() : _controller.reverse();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(-_animation.value, -_animation.value),
              blurRadius: 15,
            ),
            BoxShadow(
              color: const Color(0xFFA3B1C6).withOpacity(0.5),
              offset: Offset(_animation.value, _animation.value),
              blurRadius: 15,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}