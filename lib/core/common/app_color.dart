import 'package:flutter/material.dart' show Color, Colors, MaterialColor;

class AppColors{

  // Primary Color
  static final int _primaryColorInt = 0xFF475ffd;
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

  // Accent Color
  static final int _accentColorInt = 0xFFfbc259;
  static final Color accentColor = Color(_accentColorInt);

  // Secondary Color
  static final int _secondaryColorInt = 0xFF0f121b;
  static final Color secondaryColor = Color(_secondaryColorInt);

  // AppBar Bottom Color
  static final int _appBarBottomColorInt = 0xFFe9e9e9;
  static final Color appBarBottomColor = Color(_appBarBottomColorInt);

  // List Separator
  static final int _listSeparatorColorInt = 0xFFe9e9e9;
  static final Color listSeparatorColor = Color(_listSeparatorColorInt);

  static Color backgroundColor = Color(0xFFf7f8fa);
  static Color fontColor = Colors.black;
  static Color metaColor = Color(0xFF888888);
  static Color borderColor = Color(0xFFe5e5e5);
}