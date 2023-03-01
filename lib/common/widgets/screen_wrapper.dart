import 'package:flutter/material.dart';
import 'package:zoo_market/common/widgets/keybordDissmiser.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    required this.body,
    this.backGround,
    this.appBar,
    this.bottom = true,
    this.top = true,
  }) : super(key: key);

  final bool top;
  final bool bottom;
  final Widget body;
  final Color? backGround;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backGround ?? Colors.white,
      child: KeyboardDismissWidget(
        child: SafeArea(
          top: top,
          bottom: bottom,
          child: Scaffold(
            body: body,
            appBar: appBar,
            backgroundColor: backGround ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
