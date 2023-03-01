import 'package:flutter/material.dart';

/// кнопка с заполненным цветом
class AppFilledColorButton extends StatelessWidget {
  const AppFilledColorButton({
    Key? key,
    this.height,
    this.child,
    this.width,
    this.onTap,
    this.borderRadiusRadii = 4.0,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  /// дочерний элемент
  final Widget? child;

  /// ширина
  final double? width;

  /// высота
  final double? height;

  /// внутреннний отступ
  final EdgeInsetsGeometry? padding;

  /// внешний отступ
  final EdgeInsetsGeometry? margin;

  /// округление фигуры
  final double borderRadiusRadii;

  final Color? color;

  /// обратный вызов при нажатии на виджет
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadiusRadii),
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
          backgroundColor: color ?? Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusRadii),
          ),
        ),
        child: child,
      ),
    );
  }
}
