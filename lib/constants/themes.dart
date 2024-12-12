import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ufo_elektronika/constants/colors.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColor.primaryColor,
    fontFamily: "MYRIADPRO",
    disabledColor: const Color(0xFF969696),
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 18
      ),
      titleMedium: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 16
      ),
      titleSmall: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 14
      ),
      labelLarge: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 14
      ),
      labelMedium: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 12
      ),
      labelSmall: TextStyle(
        fontFamily: "MYRIADPRO",
        fontSize: 10
      ),
    ),

    /* ------------------------------ app bar theme ----------------------------- */
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 15,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 15,
        color: AppColor.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColor.primaryColor
      ),
      iconTheme: IconThemeData(
        color: AppColor.primaryColor
      )
    ),

    /* ------------------------- bottom bavigation theme ------------------------ */
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: Color(0xFF161616),
      selectedLabelStyle: TextStyle(
        fontSize: 9,
        fontFamily: 'MYRIADPRO',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 9,
        fontFamily: 'MYRIADPRO',
      ),
    ),

    /* -------------------------------- checkbox -------------------------------- */
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primaryColor;
          }
          return Colors.white;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),

    /* ------------------------------ button theme ------------------------------ */
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: const TextStyle(
          color: AppColor.grayText,
          fontSize: 16,
        )
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColor.grayBorder,
          width: 1
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
        ),
        foregroundColor: AppColor.grayText,
        textStyle: const TextStyle(
          color: AppColor.grayText,
          fontSize: 11,
          fontWeight: FontWeight.bold
        )
      )
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold
        )
      )
    ),
  );
}
