import 'package:geocoding/geocoding.dart';

class AddressAutocompleteService {
  // Lista de ciudades principales del mundo para sugerencias locales
  static const List<String> _majorWorldCities = [
    'New York, USA',
    'London, UK',
    'Tokyo, Japan',
    'Paris, France',
    'Sydney, Australia',
    'Toronto, Canada',
    'Berlin, Germany',
    'Rome, Italy',
    'Madrid, Spain',
    'Barcelona, Spain',
    'Amsterdam, Netherlands',
    'Vienna, Austria',
    'Prague, Czech Republic',
    'Budapest, Hungary',
    'Warsaw, Poland',
    'Moscow, Russia',
    'Istanbul, Turkey',
    'Dubai, UAE',
    'Singapore, Singapore',
    'Hong Kong, China',
    'Seoul, South Korea',
    'Bangkok, Thailand',
    'Mumbai, India',
    'Delhi, India',
    'Cairo, Egypt',
    'Cape Town, South Africa',
    'Rio de Janeiro, Brazil',
    'São Paulo, Brazil',
    'Buenos Aires, Argentina',
    'Mexico City, Mexico',
    'Lima, Peru',
    'Santiago, Chile',
    'Bogotá, Colombia',
    'Caracas, Venezuela',
    'Quito, Ecuador',
    'La Paz, Bolivia',
    'Asunción, Paraguay',
    'Montevideo, Uruguay',
    'Havana, Cuba',
    'Kingston, Jamaica',
    'Port-au-Prince, Haiti',
    'Santo Domingo, Dominican Republic',
    'San Juan, Puerto Rico',
    'Panama City, Panama',
    'San José, Costa Rica',
    'Managua, Nicaragua',
    'Tegucigalpa, Honduras',
    'San Salvador, El Salvador',
    'Guatemala City, Guatemala',
    'Belmopan, Belize',
  ];

  /// Obtiene sugerencias de direcciones basadas en el texto de entrada
  static Future<List<AddressSuggestion>> getAddressSuggestions(
      String input) async {
    if (input.isEmpty) return [];

    final suggestions = <AddressSuggestion>[];

    try {
      // 1. Si el input parece ser una dirección completa, intentar geocoding directo primero
      if (_isCompleteAddress(input)) {
        final directSuggestions = await _getDirectGeocodingSuggestions(input);
        suggestions.addAll(directSuggestions);

        // Si encontramos resultados directos, devolverlos prioritariamente
        if (suggestions.isNotEmpty) {
          return suggestions.take(5).toList();
        }
      }

      // 2. Buscar en ciudades principales del mundo
      final citySuggestions = _getCitySuggestions(input);
      suggestions.addAll(citySuggestions);

      // 3. Buscar usando geocoding global para términos parciales
      final geocodingSuggestions = await _getGeocodingSuggestions(input);
      suggestions.addAll(geocodingSuggestions);

      // 4. Si el input no es una dirección completa, intentar variaciones
      if (!_isCompleteAddress(input) && input.length > 3) {
        final variationSuggestions = await _getVariationSuggestions(input);
        suggestions.addAll(variationSuggestions);
      }

      // Eliminar duplicados y limitar resultados
      final uniqueSuggestions = suggestions.toSet().toList();
      return uniqueSuggestions.take(10).toList();
    } catch (e) {
      // Si falla el geocoding, devolver solo sugerencias locales
      return _getCitySuggestions(input);
    }
  }

  /// Verifica si el input parece ser una dirección completa
  static bool _isCompleteAddress(String input) {
    // Una dirección completa típicamente tiene:
    // - Número de calle
    // - Múltiples comas (separando calle, ciudad, provincia, país)
    // - Longitud significativa
    return input.contains(',') &&
        input.length > 15 &&
        (input.contains(RegExp(r'\d+')) || input.split(',').length >= 3);
  }

  /// Obtiene sugerencias de ciudades principales del mundo
  static List<AddressSuggestion> _getCitySuggestions(String input) {
    final lowercaseInput = input.toLowerCase();
    return _majorWorldCities
        .where((city) => city.toLowerCase().contains(lowercaseInput))
        .map((city) => AddressSuggestion(
              displayText: city,
              fullAddress: city,
              type: AddressSuggestionType.city,
            ))
        .toList();
  }

  /// Obtiene sugerencias usando geocoding global
  static Future<List<AddressSuggestion>> _getGeocodingSuggestions(
      String input) async {
    try {
      final locations = await locationFromAddress(input);

      return locations.take(5).map((location) {
        return AddressSuggestion(
          displayText:
              '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
          fullAddress: input,
          latitude: location.latitude,
          longitude: location.longitude,
          type: AddressSuggestionType.coordinates,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Obtiene sugerencias de geocoding directo para direcciones completas
  static Future<List<AddressSuggestion>> _getDirectGeocodingSuggestions(
      String input) async {
    try {
      final locations = await locationFromAddress(input);

      if (locations.isNotEmpty) {
        return locations.take(3).map((location) {
          return AddressSuggestion(
            displayText: input,
            fullAddress: input,
            latitude: location.latitude,
            longitude: location.longitude,
            type: AddressSuggestionType.address,
          );
        }).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  /// Obtiene sugerencias de variaciones para términos parciales
  static Future<List<AddressSuggestion>> _getVariationSuggestions(
      String input) async {
    try {
      // Intentar con diferentes formatos de dirección global
      final variations = [
        '$input, Argentina',
        '$input, Buenos Aires, Argentina',
        '$input, Spain',
        '$input, USA',
        '$input, UK',
        '$input, Canada',
        '$input, Australia',
        '$input, Germany',
        '$input, France',
        '$input, Italy',
        '$input, Japan',
        '$input, China',
        '$input, India',
        '$input, Brazil',
        '$input, Mexico',
      ];

      final suggestions = <AddressSuggestion>[];

      for (final variation in variations) {
        try {
          final locations = await locationFromAddress(variation);
          if (locations.isNotEmpty) {
            final location = locations.first;
            suggestions.add(AddressSuggestion(
              displayText: variation,
              fullAddress: variation,
              latitude: location.latitude,
              longitude: location.longitude,
              type: AddressSuggestionType.address,
            ));

            // Limitar a 3 sugerencias por variación para evitar demasiadas
            if (suggestions.length >= 3) break;
          }
        } catch (e) {
          // Continuar con la siguiente variación
        }
      }

      return suggestions;
    } catch (e) {
      return [];
    }
  }

  /// Obtiene coordenadas de una dirección usando geocoding global
  static Future<Map<String, double>?> getCoordinatesFromAddress(
      String address) async {
    try {
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
      return null;
    }
  }

  /// Obtiene la dirección desde coordenadas usando reverse geocoding global
  static Future<String?> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final components = <String>[];

        if (placemark.street != null && placemark.street!.isNotEmpty) {
          components.add(placemark.street!);
        }
        if (placemark.locality != null && placemark.locality!.isNotEmpty) {
          components.add(placemark.locality!);
        }
        if (placemark.country != null && placemark.country!.isNotEmpty) {
          components.add(placemark.country!);
        }

        return components.join(', ');
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}

/// Modelo para representar una sugerencia de dirección
class AddressSuggestion {
  final String displayText;
  final String fullAddress;
  final double? latitude;
  final double? longitude;
  final AddressSuggestionType type;

  const AddressSuggestion({
    required this.displayText,
    required this.fullAddress,
    this.latitude,
    this.longitude,
    required this.type,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddressSuggestion &&
        other.displayText == displayText &&
        other.fullAddress == fullAddress;
  }

  @override
  int get hashCode {
    return displayText.hashCode ^ fullAddress.hashCode;
  }

  @override
  String toString() {
    return 'AddressSuggestion(displayText: $displayText, fullAddress: $fullAddress, type: $type)';
  }
}

/// Tipos de sugerencias de dirección
enum AddressSuggestionType {
  city,
  address,
  coordinates,
}
