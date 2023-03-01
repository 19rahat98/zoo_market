import 'package:flutter/material.dart';

class AppColors {
  static const error = Color(0xFFF8474C);
  static const black = Color(0xFF151515);
  static const monoGray = Color(0xFFBDBDBD);
  static const monoBrown = Color(0xFF7D291F);
  static const mainOrange = Color(0xFFED8E22);
  static const monoGray2 = Color(0xFFF6F6F6);
}

class AppIcons {
  static const icArrowLeft = 'assets/svg/ic_arrow_left.svg';
  static const icLogoApp = 'assets/svg/ic_logo_app.svg';
  static const icLogoSplash = 'assets/svg/ic_logo_sign.svg';
  static const icClose = 'assets/svg/ic_close.svg';
  static const icVisibilityPassword = 'assets/svg/ic_visibility_password.svg';
  static const icVisibilityOffPassword = 'assets/svg/ic_visibility_off_password.svg';
}

class AppTextStyle {
  static const h1 = TextStyle(
    fontSize: 34,
    fontFamily: 'CeraPro',
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static const h2 = TextStyle(
    fontSize: 30,
    fontFamily: 'CeraPro',
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static const title = TextStyle(
    fontSize: 24,
    fontFamily: 'CeraPro',
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static const textMob = TextStyle(
    fontSize: 20,
    fontFamily: 'CeraPro',
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static const body = TextStyle(
    fontSize: 18,
    fontFamily: 'CeraPro',
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const textInput =  TextStyle(
    color: AppColors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'CeraPro',
  );

  static const regular =  TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'CeraPro',
  );

  static const caption =  TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'CeraPro',
  );
}