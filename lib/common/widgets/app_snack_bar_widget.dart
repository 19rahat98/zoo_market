import 'package:flutter/material.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/theme/theme.dart';

/// снэкбар для алертов при успешном сценарии
SnackBar successSnackBar({String? title}){
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title ?? CoreConstant.empty,
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: AppColors.mainOrange,
  );
}

/// снэкбар для алертов при возникновение ошибок
SnackBar errorSnackBar({String? title}){
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.dangerous,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title ?? CoreConstant.empty,
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: AppColors.error,
  );
}