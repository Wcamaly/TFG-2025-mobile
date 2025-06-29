import 'package:geocoding/geocoding.dart';

class PlacesService {
  /// Obtiene las coordenadas de una dirección usando geocoding
  static Future<Map<String, double>?> getCoordinatesFromAddress(
      String address) async {
    try {
      if (address.isEmpty) return null;

      final locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final location = locations.first;
        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
        };
      }

      return null;
    } catch (e) {
      print('Error getting coordinates from address: $e');
      return null;
    }
  }

  /// Obtiene la dirección desde coordenadas usando reverse geocoding
  static Future<String?> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      }

      return null;
    } catch (e) {
      print('Error getting address from coordinates: $e');
      return null;
    }
  }

  /// Obtiene sugerencias de direcciones basadas en el texto de entrada
  static Future<List<String>> getAddressSuggestions(String input) async {
    try {
      if (input.isEmpty) return [];

      final locations = await locationFromAddress(input);

      return locations.map((location) {
        return '${location.latitude}, ${location.longitude}';
      }).toList();
    } catch (e) {
      print('Error getting address suggestions: $e');
      return [];
    }
  }
}
