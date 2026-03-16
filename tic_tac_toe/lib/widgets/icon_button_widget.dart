import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color color;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: color, width: 2.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        child: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }
}
