import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.assetName, {
    Key? key,
    this.radius = 20,
    this.iconSize = 18,
    this.iconColor,
    this.onPressed,
  }) : super(key: key);

  final double radius;
  final double iconSize;
  final String assetName;
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: radius,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: iconSize,
        minHeight: iconSize,
      ),
      icon: SvgPicture.asset(
        assetName,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}
