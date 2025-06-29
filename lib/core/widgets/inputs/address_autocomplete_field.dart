import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';
import '../../config/env_config.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Widget personalizado para autocompletado de direcciones usando Google Places API
///
/// Este widget proporciona:
/// - Autocompletado de direcciones de todo el mundo
/// - Obtención automática de coordenadas
/// - UI personalizada que coincide con el diseño de la app
/// - Soporte multilenguaje
/// - Validación integrada
class AddressAutocompleteField extends StatefulWidget {
  /// Controlador del campo de texto
  final TextEditingController controller;

  /// Etiqueta del campo
  final String label;

  /// Icono del campo
  final IconData icon;

  /// Función de validación opcional
  final String? Function(String?)? validator;

  /// Callback que se ejecuta cuando se obtienen coordenadas
  final Function(Map<String, double>)? onCoordinatesObtained;

  const AddressAutocompleteField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.onCoordinatesObtained,
  });

  @override
  State<AddressAutocompleteField> createState() =>
      _AddressAutocompleteFieldState();
}

class _AddressAutocompleteFieldState extends State<AddressAutocompleteField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Manejar cambios de foco si es necesario
  }

  /// Maneja la selección de una sugerencia de dirección
  void _onSuggestionClick(Place placeDetails) {
    // Actualizar el controlador con la dirección formateada
    widget.controller.text =
        placeDetails.formattedAddress ?? placeDetails.name ?? '';

    // Si tenemos coordenadas, notificar
    if (widget.onCoordinatesObtained != null &&
        placeDetails.lat != null &&
        placeDetails.lng != null) {
      widget.onCoordinatesObtained!({
        'latitude': placeDetails.lat!,
        'longitude': placeDetails.lng!,
      });
    }

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('profile.coordinatesObtainedFromAutocomplete'.tr()),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddressAutocompleteTextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          validator: widget.validator,
          mapsApiKey: EnvConfig.googleMapsApiKey,
          onSuggestionClick: _onSuggestionClick,
          language: context.locale.languageCode,
          componentCountry:
              null, // Sin restricción de país, autocompletado global
          type: AutoCompleteType.address,
          // Personalización del dropdown y sugerencias
          suggestionsOverlayDecoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          hoverColor: AppColors.primary.withOpacity(0.08),
          selectionColor: AppColors.primary.withOpacity(0.15),
          buildItem: (suggestion, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                suggestion.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: 'profile.addressAutocompletePlaceholder'.tr(),
            prefixIcon: Icon(widget.icon, color: AppColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: AppColors.textSecondary.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
