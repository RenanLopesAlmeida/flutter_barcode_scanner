import 'package:flutter/material.dart';

class AppThemeData {
  static Color get primaryColor => const Color(0xFF4461EF);

  static Color get cancelColor => const Color(0xffc9ccdb);

  static ThemeData getDefaultTheme() {
    final mainColor = Color(Colors.purple.shade900.value);

    return ThemeData(
      primaryColor: MaterialColor(
        Colors.purple.shade900.value,
        {
          50: Color(Colors.purple.shade50.value),
          100: Color(Colors.purple.shade100.value),
          200: Color(Colors.purple.shade200.value),
          300: Color(Colors.purple.shade300.value),
          400: Color(Colors.purple.shade400.value),
          500: Color(Colors.purple.shade500.value),
          600: Color(Colors.purple.shade600.value),
          700: Color(Colors.purple.shade700.value),
          800: Color(Colors.purple.shade800.value),
          900: Color(Colors.purple.shade900.value),
        },
      ),
      colorScheme: ColorScheme(
        primary: mainColor,
        secondary: mainColor,
        background: const Color(0xFFEFF3FC),
        error: const Color(0xFFE0593C),
        surface: const Color(0xFFFFFFFF),
        onPrimary: const Color(0xFFFFFFFF),
        onSecondary: const Color(0xFFFFFFFF),
        onError: const Color(0xFFFFFFFF),
        onBackground: const Color(0xFF040404),
        onSurface: const Color(0xFF040404),
        brightness: Brightness.light,
      ),
      dividerColor: const Color.fromRGBO(0, 0, 0, 0.12),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(mainColor),
        thickness: MaterialStateProperty.all(6),
        radius: const Radius.circular(4),
      ),
    );
  }
}
