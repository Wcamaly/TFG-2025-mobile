import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static const double _defaultLatitude = 40.4168; // Madrid
  static const double _defaultLongitude = -3.7038;

  /// Obtiene la ubicación actual del usuario
  static Future<Position> getCurrentLocation() async {
    try {
      // Verificar si los servicios de ubicación están habilitados
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Los servicios de ubicación están deshabilitados
        return Position(
          latitude: _defaultLatitude,
          longitude: _defaultLongitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      }

      // Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permisos denegados
          return _getDefaultPosition();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permisos denegados permanentemente
        return _getDefaultPosition();
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      // En caso de error, devolver ubicación por defecto
      return _getDefaultPosition();
    }
  }

  /// Solicita permisos de ubicación
  static Future<bool> requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Verifica si los permisos de ubicación están concedidos
  static Future<bool> hasLocationPermission() async {
    try {
      final status = await Permission.location.status;
      return status == PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Calcula la distancia entre dos puntos en kilómetros
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  /// Devuelve una posición por defecto (Madrid)
  static Position _getDefaultPosition() {
    return Position(
      latitude: _defaultLatitude,
      longitude: _defaultLongitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}
