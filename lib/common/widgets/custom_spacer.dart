import 'package:flutter/material.dart';

class ColumnSpacer extends StatelessWidget {
  final double value;

  const ColumnSpacer(
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value * 10,
    );
  }
}

class RowSpacer extends StatelessWidget {
  final double value;

  const RowSpacer(
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value * 10,
    );
  }
}
