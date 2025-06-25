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

class _TrainerMapViewState extends State<TrainerMapView> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _errorMessage;

  // Madrid como ubicación por defecto
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.4168, -3.7038), // Madrid
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
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
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: trainer.name,
          snippet: trainer.specialization,
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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: 'Tu ubicación',
            snippet: 'Estás aquí',
          ),
        ),
      );
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

    // Usar un FutureBuilder para cargar el mapa de forma asíncrona
    return FutureBuilder<void>(
      future: _loadMapSafely(),
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
        print('🗺️ Iniciando carga segura del mapa...');
      }

      // 1. Validar que Google Maps API Key esté configurada
      if (RemoteConfigService.googleMapsApiKey.isEmpty ||
          RemoteConfigService.googleMapsApiKey == 'YOUR_ACTUAL_API_KEY_HERE' ||
          RemoteConfigService.googleMapsApiKey ==
              'YOUR_GOOGLE_MAPS_API_KEY_HERE') {
        throw Exception('API Key de Google Maps no configurada correctamente');
      }

      // 2. Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('⚠️ Permisos de ubicación denegados');
          }
          // Continuar sin ubicación actual
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('⚠️ Permisos de ubicación denegados permanentemente');
        }
        // Continuar sin ubicación actual
      }

      // 3. Verificar que el servicio de ubicación esté habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('⚠️ Servicios de ubicación deshabilitados');
        }
        // Continuar sin ubicación actual
      }

      // 4. Simular tiempo de carga para evitar race conditions
      await Future.delayed(const Duration(milliseconds: 200));

      // 5. Validar que el widget siga mounted
      if (!mounted) {
        throw Exception('Widget disposed durante la carga');
      }

      // 6. Verificar que tenemos entrenadores para mostrar
      if (widget.trainers.isEmpty) {
        if (kDebugMode) {
          print('⚠️ No hay entrenadores para mostrar en el mapa');
        }
      }

      if (kDebugMode) {
        print('✅ Mapa cargado de forma segura');
        print(
            '✅ API Key válida: ${RemoteConfigService.googleMapsApiKey.substring(0, 10)}...');
        print('✅ Permisos de ubicación: $permission');
        print('✅ Servicios de ubicación: $serviceEnabled');
        print('✅ Entrenadores a mostrar: ${widget.trainers.length}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error en carga segura del mapa: $e');
        print('❌ Stack trace: ${StackTrace.current}');
      }

      // Re-lanzar la excepción para que el FutureBuilder la capture
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

      return Container(
        child: GoogleMap(
          key: const Key('google_map_widget'),
          onMapCreated: (GoogleMapController controller) {
            try {
              if (kDebugMode) {
                print('🗺️ ¡Mapa creado exitosamente!');
              }
              if (mounted) {
                setState(() {
                  _mapController = controller;
                });

                // Mover a la ubicación actual si está disponible
                if (_currentPosition != null) {
                  controller.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                    ),
                  );
                }
              }
            } catch (e) {
              if (kDebugMode) {
                print('❌ Error al configurar controlador: $e');
              }
            }
          },
          initialCameraPosition: _initialPosition,
          markers: _markers.isNotEmpty ? _markers : <Marker>{},
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          onCameraMove: (CameraPosition position) {
            // Log opcional para verificar que el mapa responde
            if (kDebugMode && mounted) {
              print(
                  '🗺️ Cámara movida a: ${position.target.latitude}, ${position.target.longitude}');
            }
          },
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
    _mapController?.dispose();
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
