import 'package:flutter/material.dart';
import 'app_color.dart';

final String _fontFamily = 'Ubuntu';

final ThemeData appTheme = ThemeData(
  canvasColor: AppColors.backgroundColor,
  primaryColor: AppColors.primaryColor,
  primarySwatch: AppColors.primarySwatch,
  accentColor: AppColors.accentColor,
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
          color: AppColors.primaryColor,
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
      primary: AppColors.primaryColor,
      padding: const EdgeInsets.all(12),
      elevation: 0,
    ),
  ),
);

final ShapeBorder appBarShape = Border(
  bottom: BorderSide(
    width: 0.5,
    color: AppColors.appBarBottomColor,
  ),
);

final ShapeBorder modalSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(12),
    topLeft: Radius.circular(12),
  ),
);

const double mainAppPadding = 15;
