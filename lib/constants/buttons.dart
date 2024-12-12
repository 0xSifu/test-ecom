import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';

class AppButton {
  AppButton._();
  static const ButtonStyle outlineGray = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    side: WidgetStatePropertyAll(
      BorderSide(
        color: AppColor.grayBorder,
      ),
    ),
    foregroundColor: WidgetStatePropertyAll(AppColor.grayText),
  );
  static ButtonStyle outlineGrayActive = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColor.primaryColor.withOpacity(0.1)),
    side: const WidgetStatePropertyAll(
      BorderSide(
        color: AppColor.primaryColor,
      ),
    ),
    foregroundColor: const WidgetStatePropertyAll(AppColor.primaryColor),
  );
}
