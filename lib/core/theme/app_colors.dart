import 'package:flutter/material.dart';

class AppColors {
  // Colores principales - versión adaptativa
  static const primaryDark = Color(0xFFFF4B4B);
  static const primaryLight =
      Color(0xFFFF8A50); // Naranja más suave para tema claro
  static const secondary = Color(0xFF2A2A2A);

  // Colores para tema oscuro
  static const backgroundDark = Color(0xFF121212);
  static const surfaceDark = Color(0xFF1E1E1E);
  static const surfaceLightDark = Color(0xFF2C2C2C);
  static const textPrimaryDark = Colors.white;
  static const textSecondaryDark = Color(0xFFB3B3B3);
  static const dividerDark = Color(0xFF2F2F2F);
  static const inputBackgroundDark = Color(0xFF2A2A2A);

  // Colores para tema claro
  static const backgroundLight = Colors.white;
  static const surfaceLight = Colors.white;
  static const surfaceLightLight = Color(0xFFFAFAFA);
  static const textPrimaryLight = Color(0xFF1A1A1A);
  static const textSecondaryLight = Color(0xFF666666);
  static const dividerLight = Color(0xFFE0E0E0);
  static const inputBackgroundLight = Color(0xFFF5F5F5);

  // Colores de estado (iguales en ambos temas)
  static const error = Color(0xFFFF3B3B);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB300);

  // Colores on (texto/iconos encima de los colores principales)
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.white;
  static const onError = Colors.white;

  // Propiedades estáticas para compatibilidad con código existente (tema oscuro por defecto)
  static const primary = primaryDark;
  static const background = backgroundDark;
  static const backgroundDark_old = Color(0xFF0A0A0A);
  static const surface = surfaceDark;
  static const surfaceDark_old = Color(0xFF1A1A1A);
  static const surfaceLight_old = surfaceLightDark;
  static const textPrimary = textPrimaryDark;
  static const textSecondary = textSecondaryDark;
  static const onBackground = textPrimaryDark;
  static const onSurface = textPrimaryDark;
  static const divider = dividerDark;
  static const cardBackground = surfaceDark;
  static const inputBackground = inputBackgroundDark;
}

// Clase helper para obtener colores adaptativos según el tema actual
class AppColorsAdaptive {
  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.primaryDark
        : AppColors.primaryLight;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
  }

  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
  }

  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
  }

  static Color surfaceLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceLightDark
        : AppColors.surfaceLightLight;
  }

  static Color divider(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.dividerDark
        : AppColors.dividerLight;
  }

  static Color inputBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.inputBackgroundDark
        : AppColors.inputBackgroundLight;
  }
}
