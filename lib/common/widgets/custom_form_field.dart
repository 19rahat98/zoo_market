import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration textFieldStyle({
    istDate = false,
    bool removeBorder = false,
    VoidCallback? hidePassword,
    EdgeInsetsGeometry? contentPadding,
    String labelTextStr = '',
    String hintTextStr = '',
    String prefixIconName = 'phoneIconOrange',
    bool showPasswordHideButton = false,
  }) {
    return InputDecoration(
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      suffixIcon: showPasswordHideButton
          ? IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: hidePassword,
            )
          : null,
      counterText: '',
      isDense: true,
      contentPadding: contentPadding ?? const EdgeInsets.only(top: 4, bottom: 8),
      labelText: labelTextStr.isEmpty ? null : labelTextStr,
      hintText: hintTextStr,
      enabledBorder: !removeBorder
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff39C7F3)),
            )
          : InputBorder.none,
      focusedBorder: !removeBorder
          ? const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff39C7F3),
              ),
            )
          : InputBorder.none,
    );
  }
}
