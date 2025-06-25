import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'env_config.dart';

class RemoteConfigService {
  static FirebaseRemoteConfig? _remoteConfig;
  static bool _initialized = false;

  /// Inicializa Firebase Remote Config
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;

      // Configurar ajustes
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: kDebugMode
              ? const Duration(seconds: 10) // Desarrollo: 10 segundos
              : const Duration(hours: 1), // Producción: 1 hora
        ),
      );

      // Establecer valores por defecto
      await _remoteConfig!.setDefaults({
        'google_maps_api_key': 'YOUR_GOOGLE_MAPS_API_KEY_HERE',
        'api_base_url': 'https://api.gymnestic.com',
        'enable_crashlytics': true,
        'enable_analytics': true,
        'min_app_version': '1.0.0',
        'force_update': false,
        'maintenance_mode': false,
        'maintenance_message':
            'La aplicación está en mantenimiento. Inténtalo más tarde.',

        // Feature Flags
        'feature_flags_enable_nutrition_tracking': true,
        'feature_flags_enable_social_features': false,
        'feature_flags_enable_premium_features': true,
        'feature_flags_enable_trainer_chat': false,
        'feature_flags_enable_workout_sharing': true,

        // API Timeouts
        'api_timeouts_connect_timeout': 30000,
        'api_timeouts_receive_timeout': 30000,
        'api_timeouts_send_timeout': 30000,

        // UI Settings
        'ui_settings_show_onboarding': true,
        'ui_settings_max_trainers_per_page': 20,
        'ui_settings_enable_dark_theme_only': true,

        // Subscription Settings
        'subscription_settings_trial_period_days': 7,
        'subscription_settings_show_premium_banner': true,
        'subscription_settings_premium_features_preview': true,
      });

      // Intentar obtener configuración remota
      await _fetchAndActivate();

      _initialized = true;

      if (kDebugMode) {
        print('✅ Remote Config inicializado correctamente');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error inicializando Remote Config: $e');
      }
      // Continuar con valores por defecto si falla
      _initialized = true;
    }
  }

  /// Obtiene y activa la configuración remota
  static Future<bool> _fetchAndActivate() async {
    try {
      final bool updated = await _remoteConfig!.fetchAndActivate();

      if (kDebugMode) {
        print(updated
            ? '🔄 Configuración remota actualizada'
            : '✅ Configuración remota actual');
      }

      return updated;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error obteniendo configuración remota: $e');
      }
      return false;
    }
  }

  /// Fuerza la actualización de la configuración
  static Future<bool> forceRefresh() async {
    if (!_initialized || _remoteConfig == null) {
      await initialize();
    }
    return await _fetchAndActivate();
  }

  // MARK: - Configuraciones principales

  /// Google Maps API Key con fallback a .env
  static String get googleMapsApiKey {
    final remoteKey = _remoteConfig?.getString('google_maps_api_key') ?? '';
    final envKey = EnvConfig.googleMapsApiKey;

    // Prioridad: Remote Config > .env > default
    if (remoteKey.isNotEmpty && remoteKey != 'YOUR_GOOGLE_MAPS_API_KEY_HERE') {
      return remoteKey;
    }
    if (envKey.isNotEmpty && envKey != 'YOUR_ACTUAL_API_KEY_HERE') {
      return envKey;
    }
    return remoteKey;
  }

  /// URL base de la API
  static String get apiBaseUrl {
    return _remoteConfig?.getString('api_base_url') ?? EnvConfig.apiBaseUrl;
  }

  /// Configuración de crashlytics
  static bool get enableCrashlytics {
    return _remoteConfig?.getBool('enable_crashlytics') ?? true;
  }

  /// Configuración de analytics
  static bool get enableAnalytics {
    return _remoteConfig?.getBool('enable_analytics') ?? true;
  }

  /// Versión mínima requerida
  static String get minAppVersion {
    return _remoteConfig?.getString('min_app_version') ?? '1.0.0';
  }

  /// Forzar actualización
  static bool get forceUpdate {
    return _remoteConfig?.getBool('force_update') ?? false;
  }

  /// Modo mantenimiento
  static bool get maintenanceMode {
    return _remoteConfig?.getBool('maintenance_mode') ?? false;
  }

  /// Mensaje de mantenimiento
  static String get maintenanceMessage {
    return _remoteConfig?.getString('maintenance_message') ??
        'La aplicación está en mantenimiento. Inténtalo más tarde.';
  }

  // MARK: - Feature Flags

  /// Habilitar seguimiento nutricional
  static bool get enableNutritionTracking {
    return _remoteConfig?.getBool('feature_flags_enable_nutrition_tracking') ??
        true;
  }

  /// Habilitar características sociales
  static bool get enableSocialFeatures {
    return _remoteConfig?.getBool('feature_flags_enable_social_features') ??
        false;
  }

  /// Habilitar características premium
  static bool get enablePremiumFeatures {
    return _remoteConfig?.getBool('feature_flags_enable_premium_features') ??
        true;
  }

  /// Habilitar chat con entrenador
  static bool get enableTrainerChat {
    return _remoteConfig?.getBool('feature_flags_enable_trainer_chat') ?? false;
  }

  /// Habilitar compartir entrenamientos
  static bool get enableWorkoutSharing {
    return _remoteConfig?.getBool('feature_flags_enable_workout_sharing') ??
        true;
  }

  // MARK: - Configuraciones de API

  /// Timeout de conexión (ms)
  static int get connectTimeout {
    return _remoteConfig?.getInt('api_timeouts_connect_timeout') ?? 30000;
  }

  /// Timeout de recepción (ms)
  static int get receiveTimeout {
    return _remoteConfig?.getInt('api_timeouts_receive_timeout') ?? 30000;
  }

  /// Timeout de envío (ms)
  static int get sendTimeout {
    return _remoteConfig?.getInt('api_timeouts_send_timeout') ?? 30000;
  }

  // MARK: - Configuraciones de UI

  /// Mostrar onboarding
  static bool get showOnboarding {
    return _remoteConfig?.getBool('ui_settings_show_onboarding') ?? true;
  }

  /// Máximo de entrenadores por página
  static int get maxTrainersPerPage {
    return _remoteConfig?.getInt('ui_settings_max_trainers_per_page') ?? 20;
  }

  /// Solo tema oscuro
  static bool get enableDarkThemeOnly {
    return _remoteConfig?.getBool('ui_settings_enable_dark_theme_only') ?? true;
  }

  // MARK: - Configuraciones de suscripción

  /// Días de período de prueba
  static int get trialPeriodDays {
    return _remoteConfig?.getInt('subscription_settings_trial_period_days') ??
        7;
  }

  /// Mostrar banner premium
  static bool get showPremiumBanner {
    return _remoteConfig
            ?.getBool('subscription_settings_show_premium_banner') ??
        true;
  }

  /// Vista previa de características premium
  static bool get premiumFeaturesPreview {
    return _remoteConfig
            ?.getBool('subscription_settings_premium_features_preview') ??
        true;
  }

  // MARK: - Métodos auxiliares

  /// Obtiene toda la configuración como Map (para debug)
  static Map<String, dynamic> getAllConfig() {
    if (_remoteConfig == null) return {};

    final config = <String, dynamic>{};
    final allKeys = _remoteConfig!.getAll();

    for (final entry in allKeys.entries) {
      config[entry.key] = entry.value.asString();
    }

    return config;
  }

  /// Verifica si la configuración remota está disponible
  static bool get isInitialized => _initialized;

  /// Obtiene el timestamp de la última actualización
  static DateTime get lastFetchTime {
    return _remoteConfig?.lastFetchTime ?? DateTime.now();
  }

  /// Estado de la última obtención
  static RemoteConfigFetchStatus get lastFetchStatus {
    return _remoteConfig?.lastFetchStatus ?? RemoteConfigFetchStatus.noFetchYet;
  }

  /// Método para debugging - imprime toda la configuración
  static void printAllConfig() {
    if (!kDebugMode) return;

    print('🔧 === CONFIGURACIÓN REMOTE CONFIG ===');
    print('📊 Estado: ${_initialized ? "Inicializado" : "No inicializado"}');
    print('⏰ Última actualización: $lastFetchTime');
    print('🔄 Estado de fetch: $lastFetchStatus');
    print('');

    final config = getAllConfig();
    for (final entry in config.entries) {
      print('📝 ${entry.key}: ${entry.value}');
    }
    print('🔧 === FIN CONFIGURACIÓN ===');
  }
}
