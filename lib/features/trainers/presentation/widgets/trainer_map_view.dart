import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/config/remote_config_service.dart';
import '../../domain/entities/trainer.dart';
import 'package:flutter/foundation.dart';

class TrainerMapView extends StatefulWidget {
  final List<Trainer> trainers;

  const TrainerMapView({
    super.key,
    required this.trainers,
  });

  @override
  State<TrainerMapView> createState() => _TrainerMapViewState();
}

class _TrainerMapViewState extends State<TrainerMapView>
    with AutomaticKeepAliveClientMixin {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _errorMessage;

  // ✅ Future que se crea una sola vez para evitar el bucle infinito
  Future<void>? _mapLoadingFuture;

  // ✅ Key único para evitar recreación de vistas
  static const Key _mapKey = Key('google_map_widget_unique');

  // ✅ Flag para controlar si el mapa ya fue creado
  bool _isMapCreated = false;

  // ✅ Flag para evitar múltiples inicializaciones
  bool _isInitializing = false;

  // ✅ Mantener el estado del widget vivo
  @override
  bool get wantKeepAlive => true;

  // Madrid como ubicación por defecto
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.4168, -3.7038), // Madrid
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    // ✅ Inicializar el Future una sola vez
    _mapLoadingFuture = _loadMapSafely();
    _initializeMapSafely();
  }

  // ✅ Inicialización segura para evitar múltiples llamadas
  Future<void> _initializeMapSafely() async {
    if (_isInitializing) {
      if (kDebugMode) {
        print('⚠️ Inicialización ya en progreso, saltando...');
      }
      return;
    }

    _isInitializing = true;
    try {
      await _initializeMap();
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _initializeMap() async {
    try {
      if (kDebugMode) {
        print('🗺️ Iniciando inicialización del mapa...');
      }

      // Validar configuración de API Key
      if (RemoteConfigService.googleMapsApiKey.isEmpty ||
          RemoteConfigService.googleMapsApiKey == 'YOUR_ACTUAL_API_KEY_HERE') {
        setState(() {
          _errorMessage =
              'Google Maps API Key no configurada.\nPor favor configura GOOGLE_MAPS_API_KEY en Firebase Remote Config';
          _isLoading = false;
        });
        return;
      }

      // Log temporal para verificar API key (remover en producción)
      if (kDebugMode) {
        print(
            '🗺️ Google Maps API Key obtenida: ${RemoteConfigService.googleMapsApiKey.substring(0, 10)}...');
        print(
            '🗺️ Longitud de la API key: ${RemoteConfigService.googleMapsApiKey.length}');
      }

      // Obtener ubicación actual
      if (kDebugMode) {
        print('📍 Obteniendo ubicación actual...');
      }
      _currentPosition = await LocationService.getCurrentLocation();

      if (kDebugMode) {
        print(
            '📍 Ubicación obtenida: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
      }

      // Crear marcadores para los trainers
      if (kDebugMode) {
        print(
            '📍 Creando marcadores para ${widget.trainers.length} entrenadores...');
      }
      _createTrainerMarkers();

      setState(() {
        _isLoading = false;
      });

      if (kDebugMode) {
        print('✅ Mapa inicializado correctamente');
      }

      // Mover la cámara a la ubicación actual
      if (_mapController != null && _currentPosition != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error al inicializar el mapa: $e');
        print('❌ Stack trace: ${StackTrace.current}');
      }
      setState(() {
        _errorMessage = 'Error al inicializar el mapa: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _createTrainerMarkers() {
    _markers = widget.trainers.map((trainer) {
      return Marker(
        markerId: MarkerId(trainer.id),
        position: LatLng(trainer.latitude, trainer.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: trainer.name,
          snippet: '⭐ ${trainer.rating} • ${trainer.specialization}',
          onTap: () {
            Navigator.pushNamed(
              context,
              '/trainer-detail',
              arguments: trainer,
            );
          },
        ),
        onTap: () {
          _showTrainerBottomSheet(trainer);
        },
      );
    }).toSet();

    // Agregar marcador de ubicación actual si está disponible
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: const InfoWindow(
            title: '📍 Tu ubicación',
            snippet: 'Estás aquí',
          ),
        ),
      );
    }

    if (kDebugMode) {
      print('🗺️ Marcadores creados: ${_markers.length}');
      print('🗺️ Entrenadores: ${widget.trainers.length}');
      print(
          '🗺️ Ubicación actual: ${_currentPosition != null ? 'Disponible' : 'No disponible'}');
    }
  }

  void _showTrainerBottomSheet(Trainer trainer) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainer.name,
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trainer.specialization,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            trainer.rating.toString(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.location_on,
                            color: AppColors.textSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              trainer.location,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/trainer-detail',
                    arguments: trainer,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Ver Perfil',
                  style: AppTextStyles.buttonMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // ✅ Requerido para AutomaticKeepAliveClientMixin

    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Inicializando mapa...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    if (kDebugMode) {
      print('🗺️ Construyendo widget del mapa...');
    }

    // ✅ Si el mapa ya fue creado, mostrar directamente el widget
    if (_isMapCreated && _mapController != null) {
      if (kDebugMode) {
        print('🗺️ Reutilizando mapa ya creado');
      }
      return _buildMapWidget();
    }

    // Usar un FutureBuilder para cargar el mapa de forma asíncrona
    return FutureBuilder<void>(
      future: _mapLoadingFuture,
      builder: (context, snapshot) {
        if (kDebugMode) {
          print('🗺️ ConnectionState: ${snapshot.connectionState}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Verificando configuración del mapa...'),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          if (kDebugMode) {
            print('❌ Error en FutureBuilder: ${snapshot.error}');
            print('❌ Stack trace completo: ${snapshot.stackTrace}');
          }

          // Mostrar error específico si es por API Key
          if (snapshot.error.toString().contains('API Key')) {
            return _buildApiKeyErrorWidget();
          }

          return _buildMapFallback();
        }

        // Si llegamos aquí, el mapa se cargó correctamente
        if (kDebugMode) {
          print('✅ Mapa cargado exitosamente en FutureBuilder');
        }

        return _buildMapWidget();
      },
    );
  }

  Future<void> _loadMapSafely() async {
    try {
      if (kDebugMode) {
        print('🗺️ Iniciando validación para carga del mapa...');
      }

      // 1. Validar que Google Maps API Key esté configurada
      if (RemoteConfigService.googleMapsApiKey.isEmpty ||
          RemoteConfigService.googleMapsApiKey == 'YOUR_ACTUAL_API_KEY_HERE' ||
          RemoteConfigService.googleMapsApiKey ==
              'YOUR_GOOGLE_MAPS_API_KEY_HERE') {
        throw Exception('API Key de Google Maps no configurada correctamente');
      }

      // 2. Validar que el widget siga mounted
      if (!mounted) {
        throw Exception('Widget disposed durante la carga');
      }

      // 3. Verificar que tenemos entrenadores para mostrar
      if (widget.trainers.isEmpty) {
        if (kDebugMode) {
          print('⚠️ No hay entrenadores para mostrar en el mapa');
        }
      }

      // 4. Pequeña pausa para evitar race conditions
      await Future.delayed(const Duration(milliseconds: 100));

      // 5. Validar nuevamente que el widget siga mounted después del delay
      if (!mounted) {
        throw Exception('Widget disposed durante la carga');
      }

      if (kDebugMode) {
        print('✅ Validación del mapa completada exitosamente');
        print(
            '✅ API Key válida: ${RemoteConfigService.googleMapsApiKey.substring(0, 10)}...');
        print('✅ Entrenadores a mostrar: ${widget.trainers.length}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error en validación del mapa: $e');
      }
      rethrow;
    }
  }

  Widget _buildMapWidget() {
    try {
      if (kDebugMode) {
        print('🗺️ Creando widget GoogleMap...');
        print('🗺️ Markers disponibles: ${_markers.length}');
        print(
            '🗺️ Posición inicial: ${_initialPosition.target.latitude}, ${_initialPosition.target.longitude}');
      }

      // Validación adicional antes de crear el widget
      if (!mounted) {
        if (kDebugMode) {
          print('❌ Widget no está mounted, cancelando creación del mapa');
        }
        return _buildMapFallback();
      }

      // Crear marcadores si no existen
      if (_markers.isEmpty) {
        _createTrainerMarkers();
      }

      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // Mapa principal
            GoogleMap(
              key: _mapKey, // ✅ Usar key único
              onMapCreated: (GoogleMapController controller) async {
                try {
                  // ✅ Evitar recreación múltiple
                  if (_isMapCreated) {
                    if (kDebugMode) {
                      print('⚠️ Mapa ya fue creado, evitando recreación');
                    }
                    return;
                  }

                  if (kDebugMode) {
                    print('🗺️ ¡Mapa creado exitosamente!');
                    print('🗺️ Controlador recibido: ${controller.toString()}');
                    print('🗺️ Marcadores disponibles: ${_markers.length}');
                  }

                  if (mounted) {
                    // ✅ Marcar como creado ANTES de cualquier operación async
                    _isMapCreated = true;
                    _mapController = controller;

                    // ✅ Actualizar estado una sola vez
                    setState(() {});

                    // ✅ Operaciones async en segundo plano
                    _configureMapAsync(controller);
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('❌ Error al configurar controlador: $e');
                  }
                }
              },
              initialCameraPosition: _initialPosition,
              markers: _markers,
              myLocationEnabled: false,
              myLocationButtonEnabled:
                  false, // Usaremos nuestro botón personalizado
              zoomControlsEnabled: false, // Usaremos controles personalizados
              mapToolbarEnabled: false,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              minMaxZoomPreference: const MinMaxZoomPreference(8.0, 18.0),
              // ✅ Configuraciones adicionales para asegurar que el mapa se muestre
              buildingsEnabled: true,
              indoorViewEnabled: true,
              trafficEnabled: false,
              onCameraMove: (CameraPosition position) {
                // Log opcional para verificar que el mapa responde
                if (kDebugMode && mounted) {
                  print(
                      '🗺️ Cámara movida a: ${position.target.latitude}, ${position.target.longitude}');
                }
              },
            ),

            // Controles flotantes personalizados
            Positioned(
              top: 16,
              right: 16,
              child: Column(
                children: [
                  // Botón de ubicación actual
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _goToCurrentLocation,
                      icon: const Icon(
                        Icons.my_location,
                        color: AppColors.primary,
                      ),
                      tooltip: 'Mi ubicación',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Controles de zoom
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _zoomIn,
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                          tooltip: 'Acercar',
                        ),
                        Container(
                          width: 24,
                          height: 1,
                          color: AppColors.textSecondary.withOpacity(0.3),
                        ),
                        IconButton(
                          onPressed: _zoomOut,
                          icon: const Icon(
                            Icons.remove,
                            color: AppColors.primary,
                          ),
                          tooltip: 'Alejar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Información flotante en la parte inferior
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${widget.trainers.length} entrenadores disponibles',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Mostrar lista de entrenadores
                        _showTrainersList();
                      },
                      child: Text(
                        'Ver Lista',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error al crear widget GoogleMap: $e');
        print('❌ Stack trace: ${StackTrace.current}');
      }
      return _buildMapFallback();
    }
  }

  // ✅ Método para aplicar tema oscuro personalizado al mapa
  Future<void> _applyDarkMapStyle(GoogleMapController controller) async {
    try {
      // ✅ Verificar que el controlador esté disponible y el widget mounted
      if (!mounted) {
        if (kDebugMode) {
          print('⚠️ Widget no mounted, saltando aplicación de tema');
        }
        return;
      }

      if (kDebugMode) {
        print('🎨 Aplicando tema oscuro al mapa...');
      }

      // ✅ Tema oscuro más simple para evitar errores
      const String darkMapStyle = '''[
        {
          "elementType": "geometry",
          "stylers": [{"color": "#212121"}]
        },
        {
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#757575"}]
        },
        {
          "elementType": "labels.text.stroke",
          "stylers": [{"color": "#212121"}]
        },
        {
          "featureType": "administrative",
          "elementType": "geometry",
          "stylers": [{"color": "#757575"}]
        },
        {
          "featureType": "administrative.country",
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#9e9e9e"}]
        },
        {
          "featureType": "road",
          "elementType": "geometry.fill",
          "stylers": [{"color": "#2c2c2c"}]
        },
        {
          "featureType": "road",
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#8a8a8a"}]
        },
        {
          "featureType": "water",
          "elementType": "geometry",
          "stylers": [{"color": "#000000"}]
        },
        {
          "featureType": "water",
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#3d3d3d"}]
        }
      ]''';

      await controller.setMapStyle(darkMapStyle);

      if (kDebugMode) {
        print('✅ Tema oscuro aplicado exitosamente');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error al aplicar tema oscuro: $e');
        print('⚠️ Intentando resetear a tema por defecto...');
      }

      // Intentar resetear a tema por defecto
      try {
        await controller.setMapStyle(null);
        if (kDebugMode) {
          print('✅ Tema resetado a por defecto');
        }
      } catch (resetError) {
        if (kDebugMode) {
          print('❌ Error al resetear tema: $resetError');
        }
      }
    }
  }

  // ✅ Configuración asíncrona del mapa para evitar bloqueos
  Future<void> _configureMapAsync(GoogleMapController controller) async {
    try {
      if (!mounted) return;

      // Aplicar tema oscuro personalizado con delay
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) {
        await _applyDarkMapStyle(controller);
      }

      // Mover a la ubicación actual si está disponible
      if (_currentPosition != null && mounted) {
        await controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      }

      if (kDebugMode) {
        print('✅ Configuración asíncrona del mapa completada');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error en configuración asíncrona: $e');
      }
    }
  }

  // ✅ Métodos para controles personalizados del mapa
  void _goToCurrentLocation() async {
    if (_mapController != null) {
      if (_currentPosition != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      } else {
        // Intentar obtener ubicación actual
        try {
          Position position = await LocationService.getCurrentLocation();
          setState(() {
            _currentPosition = position;
          });
          _createTrainerMarkers(); // Recrear marcadores con la nueva ubicación

          await _mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude),
            ),
          );
        } catch (e) {
          if (kDebugMode) {
            print('❌ Error al obtener ubicación: $e');
          }
        }
      }
    }
  }

  void _zoomIn() async {
    if (_mapController != null) {
      await _mapController!.animateCamera(CameraUpdate.zoomIn());
    }
  }

  void _zoomOut() async {
    if (_mapController != null) {
      await _mapController!.animateCamera(CameraUpdate.zoomOut());
    }
  }

  void _showTrainersList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // Header
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Entrenadores Disponibles',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lista de entrenadores
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.trainers.length,
                  itemBuilder: (context, index) {
                    final trainer = widget.trainers[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.textSecondary.withOpacity(0.2),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          trainer.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              trainer.specialization,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.warning,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trainer.rating.toString(),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.textSecondary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    trainer.location,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Ir al marcador del entrenador en el mapa
                            _goToTrainerLocation(trainer);
                          },
                          icon: const Icon(
                            Icons.map,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            '/trainer-detail',
                            arguments: trainer,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToTrainerLocation(Trainer trainer) async {
    if (_mapController != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(trainer.latitude, trainer.longitude),
          16.0,
        ),
      );

      // Mostrar el bottom sheet del entrenador después de un breve delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showTrainerBottomSheet(trainer);
        }
      });
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Mapa no disponible',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
                // ✅ Reiniciar el Future para evitar usar el anterior
                _mapLoadingFuture = _loadMapSafely();
              });
              _initializeMap();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiKeyErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.key_off,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Configuración requerida',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Google Maps API Key no está configurada.\n\nPor favor:\n1. Ve a Firebase Console\n2. Configura Remote Config\n3. Agrega GOOGLE_MAPS_API_KEY',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _errorMessage = null;
                      // ✅ Reiniciar el Future para evitar usar el anterior
                      _mapLoadingFuture = _loadMapSafely();
                    });
                    _initializeMap();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Mostrar vista de fallback directamente
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('Ver Lista'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapFallback() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.map_outlined,
                size: 32,
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrenadores Cercanos',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.trainers.length} entrenadores disponibles',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Información de ubicación
          if (_currentPosition != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.textSecondary.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tu ubicación: ${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Lista de entrenadores
          Expanded(
            child: ListView.builder(
              itemCount: widget.trainers.length,
              itemBuilder: (context, index) {
                final trainer = widget.trainers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.textSecondary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trainer.name,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              trainer.specialization,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.warning,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trainer.rating.toString(),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.textSecondary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    trainer.location,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/trainer-detail',
                            arguments: trainer,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Botón de reintento
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                  // ✅ Reiniciar el Future para evitar usar el anterior
                  _mapLoadingFuture = _loadMapSafely();
                });
                _initializeMap();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar Mapa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // ✅ Limpiar recursos del mapa de forma segura
    try {
      if (_mapController != null) {
        _mapController?.dispose();
        _mapController = null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error al limpiar controlador del mapa: $e');
      }
    }

    _isMapCreated = false;
    _isInitializing = false;
    super.dispose();
  }
}

class _TrainerMapCard extends StatelessWidget {
  final Trainer trainer;

  const _TrainerMapCard({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainer.name,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${trainer.yearsOfExperience} years experience',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.warning,
                    size: 16,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    trainer.rating.toString(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            trainer.specialization,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
