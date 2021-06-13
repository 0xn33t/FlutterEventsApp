import 'package:flutter/material.dart';

abstract class _AppColors{
  static final int _primaryColorInt = 0xFF475FFD;
  static final Color primaryColor = Color(_primaryColorInt);
  static final MaterialColor primarySwatch = MaterialColor(
    _primaryColorInt,
    <int, Color>{
       50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_primaryColorInt),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static final Color accentColor = Color(0xFFFBC259);
  static Color backgroundColor = Color(0xFFF7F8FA);
  static Color metaColor = Color(0xFF888888);
  static Color borderColor = Color(0xFFE5E5E5);
}

final String _fontFamily = 'Ubuntu';

final ThemeData appTheme = ThemeData(
  canvasColor: _AppColors.backgroundColor,
  primaryColor: _AppColors.primaryColor,
  primarySwatch: _AppColors.primarySwatch,
  accentColor: _AppColors.accentColor,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  fontFamily: _fontFamily,
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: _AppColors.primaryColor,
          width: 2,
        ),
      ),
    ),
    labelColor: Colors.black,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: _fontFamily,
    ),
    unselectedLabelColor: Colors.black54,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _AppColors.primaryColor,
      padding: const EdgeInsets.all(12),
      elevation: 0,
    ),
  ),
  textTheme: TextTheme(
    caption: TextStyle(color: _AppColors.metaColor)
  ),
);

final ShapeBorder modalSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(12),
    topLeft: Radius.circular(12),
  ),
);

const double mainAppPadding = 15;

extension AppColorScheme on ColorScheme {
  Color get borderColor => _AppColors.borderColor;
}


