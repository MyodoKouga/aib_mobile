import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeumorphicButton extends StatefulWidget {
 final Widget child;
 final VoidCallback? onPressed;
 final EdgeInsetsGeometry? padding;
 final double radius;
 final bool isPressed;

 const NeumorphicButton({
   required this.child,
   this.onPressed,
   this.padding,
   this.radius = 8.0,
   this.isPressed = false,
   super.key,
 });

 @override
 State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
 bool isPressed = false;

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTapDown: (_) => setState(() => isPressed = true),
     onTapUp: (_) => setState(() => isPressed = false),
     onTapCancel: () => setState(() => isPressed = false),
     onTap: widget.onPressed,
     child: Container(
       padding: widget.padding ?? EdgeInsets.all(12.w),
       decoration: BoxDecoration(
         color: const Color(0xFFE0E5EC),
         borderRadius: BorderRadius.circular(widget.radius),
         boxShadow: [
           BoxShadow(
             color: Colors.white.withOpacity(0.8),
             offset: Offset(isPressed ? 2 : -4, isPressed ? 2 : -4),
             blurRadius: 15,
           ),
           BoxShadow(
             color: const Color(0xFFA3B1C6).withOpacity(0.5),
             offset: Offset(isPressed ? -2 : 4, isPressed ? -2 : 4),
             blurRadius: 15,
           ),
         ],
       ),
       child: widget.child,
     ),
   );
 }
}