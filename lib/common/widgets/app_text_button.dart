import 'package:flutter/material.dart';
import 'package:zoo_market/common/theme/theme.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    this.onTap,
    this.style,
    required this.text,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: style ?? AppTextStyle.textMob,
        textAlign: TextAlign.center,
      ),
    );
  }
}
