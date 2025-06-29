import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider para el tema actual
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

class AppTheme {
  // Colores principales para tema oscuro
  static const Color primaryDark = Color(0xFFFF4B4B);
  // Color naranja más suave para tema claro
  static const Color primaryLight = Color(0xFFFF8A50);

  static const Color secondary = Color(0xFF2A2A2A);
  static const Color error = Color(0xFFFF3B3B);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);

  // Tema oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: secondary,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF1E1E1E),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: Colors.white, // Fondo completamente blanco
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: Color(0xFF6B6B6B), // Gris más suave para secondary
        surface: Colors.white,
        background: Colors.white, // Fondo completamente blanco
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A1A1A),
        onBackground: Color(0xFF1A1A1A),
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF1A1A1A),
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight, // Color naranja más suave
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

// Clase helper para colores que se adaptan al tema
class AdaptiveColors {
  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppTheme.primaryDark
        : AppTheme.primaryLight;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  static Color surface(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color textPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onBackground;
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFB3B3B3)
        : const Color(0xFF666666);
  }

  static Color surfaceLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2C2C2C)
        : const Color(0xFFFAFAFA);
  }

  static Color divider(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2F2F2F)
        : const Color(0xFFE0E0E0);
  }

  static Color cardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;
  }

  static Color inputBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFF5F5F5);
  }
}
