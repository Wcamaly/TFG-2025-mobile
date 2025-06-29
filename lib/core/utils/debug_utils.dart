import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class DebugUtils {
  static bool _isInitialized = false;

  /// Inicializa el filtro de logs para suprimir errores conocidos de Flutter
  static void initializeLogFilter() {
    if (_isInitialized || kReleaseMode) return;

    _isInitialized = true;

    // En lugar de interceptar dart:developer, interceptamos FlutterError
    _setupFlutterErrorHandler();
  }

  static void _setupFlutterErrorHandler() {
    // Guardar el handler original
    final originalOnError = FlutterError.onError;

    FlutterError.onError = (FlutterErrorDetails details) {
      // Lista de patrones de errores a filtrar
      final List<String> filteredPatterns = [
        'KeyUpEvent is dispatched, but the state shows that the physical key is not pressed',
        'A KeyUpEvent is dispatched',
        'HardwareKeyboard',
        'physicalKey: PhysicalKeyboardKey',
        'logicalKey: LogicalKeyboardKey',
      ];

      final errorMessage = details.toString().toLowerCase();

      // Verificar si el error contiene algún patrón filtrado
      bool shouldFilter = filteredPatterns
          .any((pattern) => errorMessage.contains(pattern.toLowerCase()));

      // Solo procesar el error si no debe ser filtrado
      if (!shouldFilter && originalOnError != null) {
        originalOnError(details);
      }
    };
  }

  /// Método para logs personalizados con diferentes niveles
  static void logInfo(String message, {String tag = 'INFO'}) {
    if (kDebugMode) {
      developer.log('[$tag] $message', level: 800);
    }
  }

  static void logWarning(String message, {String tag = 'WARNING'}) {
    if (kDebugMode) {
      developer.log('[$tag] $message', level: 900);
    }
  }

  static void logError(String message,
      {String tag = 'ERROR', Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log('[$tag] $message',
          level: 1000, error: error, stackTrace: stackTrace);
    }
  }

  /// Método para debuggear pagos y suscripciones
  static void logPayment(String message) {
    logInfo(message, tag: 'PAYMENT');
  }

  /// Método para debuggear asociaciones de estudiantes
  static void logStudentAssociation(String message) {
    logInfo(message, tag: 'STUDENT_ASSOCIATION');
  }

  /// Método para limpiar la consola en desarrollo
  static void clearConsole() {
    if (kDebugMode) {
      developer.log('\x1B[2J\x1B[0;0H'); // Clear screen ANSI codes
    }
  }

  /// Método para imprimir separadores en logs
  static void logSeparator([String title = '']) {
    if (kDebugMode) {
      final separator = '=' * 50;
      if (title.isNotEmpty) {
        developer.log('$separator $title $separator');
      } else {
        developer.log(separator);
      }
    }
  }
}
