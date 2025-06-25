import 'package:flutter/foundation.dart';
import 'remote_config_service.dart';

/// Helper para configurar Google Maps con la API key correcta
class MapsConfigHelper {
  /// Obtiene la API key configurada
  static String get apiKey => RemoteConfigService.googleMapsApiKey;

  /// Verifica si la configuración de Google Maps es válida
  static bool get isConfigured {
    final apiKey = RemoteConfigService.googleMapsApiKey;
    return apiKey.isNotEmpty &&
        apiKey != 'YOUR_ACTUAL_API_KEY_HERE' &&
        apiKey != 'YOUR_GOOGLE_MAPS_API_KEY_HERE' &&
        apiKey.length > 30; // Las API keys de Google tienen ~39 caracteres
  }

  /// Valida la configuración y lanza excepción si no es válida
  static void validateConfiguration() {
    if (!isConfigured) {
      throw Exception('Google Maps API Key no configurada correctamente.\n'
          'Configuración actual: "${RemoteConfigService.googleMapsApiKey}"\n'
          'Por favor configura GOOGLE_MAPS_API_KEY en Firebase Remote Config');
    }

    if (kDebugMode) {
      print('🗺️ API Key configurada: ${apiKey.substring(0, 10)}...');
      print('🗺️ Longitud de API Key: ${apiKey.length}');
    }
  }

  /// Información para debugging
  static Map<String, dynamic> get debugInfo => {
        'apiKey':
            isConfigured ? '${apiKey.substring(0, 10)}***' : 'NO_CONFIGURADA',
        'length': apiKey.length,
        'isValid': isConfigured,
        'source': 'Firebase Remote Config',
      };

  /// Mensaje de error detallado para mostrar al usuario
  static String get errorMessage => '''
Google Maps no está configurado correctamente.

PASOS PARA SOLUCIONAR:
1. Ve a Firebase Console → Remote Config
2. Agrega la clave: GOOGLE_MAPS_API_KEY  
3. Valor: Tu API Key de Google Cloud Console
4. Publica los cambios

CONFIGURACIÓN NATIVA REQUERIDA:
• Android: ${apiKey.substring(0, 10)}... en AndroidManifest.xml
• iOS: ${apiKey.substring(0, 10)}... en AppDelegate.swift

Estado actual: ${isConfigured ? 'CONFIGURADA' : 'NO CONFIGURADA'}
''';
}
