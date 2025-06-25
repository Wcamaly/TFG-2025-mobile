import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  // API Configuration
  static const String apiBaseUrl = 'https://api.gymnestic.com';

  // Google Maps API Key - TEMPORAL PARA PRUEBAS
  // IMPORTANTE: Esta debe coincidir con la configurada en Android/iOS
  static const String googleMapsApiKey =
      'AIzaSyBKDOjEk3pHQDUGhPMRdD46oLKGK6xHAXM';

  // Firebase Configuration
  static const bool enableCrashlytics = true;
  static const bool enableAnalytics = true;

  // App Configuration
  static const String appName = 'Gymnestic';
  static const String appVersion = '1.0.0';

  // Feature Flags
  static const bool enableNutritionTracking = true;
  static const bool enableSocialFeatures = false;
  static const bool enablePremiumFeatures = true;
  static const bool enableTrainerChat = false;
  static const bool enableWorkoutSharing = true;

  // API Timeouts (milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  static String get firebaseApiKey {
    return dotenv.env['FIREBASE_API_KEY'] ?? '';
  }

  static bool get isProduction {
    return dotenv.env['ENVIRONMENT'] == 'production';
  }

  static bool get isDevelopment {
    return dotenv.env['ENVIRONMENT'] == 'development' ||
        dotenv.env['ENVIRONMENT'] == null;
  }

  /// Inicializa las variables de entorno
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      // Si no se puede cargar el archivo .env, usar valores por defecto
      print('Warning: Could not load .env file: $e');
    }
  }

  /// Valida que las variables de entorno críticas estén configuradas
  static void validateConfig() {
    if (googleMapsApiKey.isEmpty ||
        googleMapsApiKey == 'YOUR_ACTUAL_API_KEY_HERE') {
      throw Exception(
          'Google Maps API Key not configured. Please set GOOGLE_MAPS_API_KEY in your .env file');
    }
  }
}
