import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/config/remote_config_service.dart';
import '../../domain/entities/trainer.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

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
  // ✅ Controlador como Completer siguiendo la documentación oficial
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Position? _currentPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _errorMessage;

  // Madrid como ubicación por defecto
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.4168, -3.7038),
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
          _errorMessage = 'Google Maps API Key no configurada';
          _isLoading = false;
        });
        return;
      }

      // Obtener ubicación actual
      try {
        _currentPosition = await LocationService.getCurrentLocation();
        if (kDebugMode) {
          print(
              '📍 Ubicación obtenida: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ No se pudo obtener ubicación: $e');
        }
      }

      // Crear marcadores
      _createTrainerMarkers();

      setState(() {
        _isLoading = false;
      });

      if (kDebugMode) {
        print('✅ Mapa inicializado correctamente');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error al inicializar el mapa: $e');
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
                child: const Text(
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

  // ✅ Método para ir a la ubicación actual simplificado
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (_currentPosition != null) {
      await controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }

  // ✅ Métodos para controlar el zoom
  Future<void> _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.zoomOut());
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
            Text('Cargando mapa...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    // ✅ Diseño con mapa 60% y lista 40%
    return Scaffold(
      body: Column(
        children: [
          // ========== MAPA (60% de la pantalla) ==========
          Expanded(
            flex: 6, // 60% de la pantalla
            child: Stack(
              children: [
                // Mapa principal
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                      if (kDebugMode) {
                        print('✅ Controlador del mapa configurado');
                      }
                    }
                  },
                  initialCameraPosition: _currentPosition != null
                      ? CameraPosition(
                          target: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          zoom: 14.0,
                        )
                      : _initialPosition,
                  markers: _markers,
                  // ✅ Configuraciones básicas y estables
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false, // Usamos botón personalizado
                  zoomControlsEnabled: false, // Usamos controles personalizados
                  mapType: MapType.normal,
                  minMaxZoomPreference: const MinMaxZoomPreference(10.0, 18.0),
                ),

                // Controles de zoom en la parte superior derecha
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(
                    children: [
                      // Botón zoom in
                      FloatingActionButton(
                        onPressed: _zoomIn,
                        heroTag: "zoom_in",
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.primary,
                        mini: true,
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 8),
                      // Botón zoom out
                      FloatingActionButton(
                        onPressed: _zoomOut,
                        heroTag: "zoom_out",
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.primary,
                        mini: true,
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),

                // Botón de ubicación actual en la parte inferior derecha del mapa
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: _goToCurrentLocation,
                    heroTag: "location",
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    mini: true,
                    child: const Icon(Icons.my_location),
                  ),
                ),

                // Información flotante en la parte superior
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.trainers.length} entrenadores',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ========== LISTA DE ENTRENADORES (40% de la pantalla) ==========
          Expanded(
            flex: 4, // 40% de la pantalla
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Header de la lista
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${widget.trainers.length}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lista scrolleable de entrenadores
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.trainers.length,
                      itemBuilder: (context, index) {
                        final trainer = widget.trainers[index];
                        return _buildTrainerListItem(trainer);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                          onPressed: () async {
                            Navigator.pop(context);
                            // Ir al marcador del entrenador en el mapa
                            final GoogleMapController controller =
                                await _controller.future;
                            await controller.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                LatLng(trainer.latitude, trainer.longitude),
                                16.0,
                              ),
                            );
                            // Mostrar bottom sheet después de un delay
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              if (mounted) {
                                _showTrainerBottomSheet(trainer);
                              }
                            });
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

  // ✅ Widget para cada item de la lista de entrenadores
  Widget _buildTrainerListItem(Trainer trainer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/trainer-detail',
            arguments: trainer,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Avatar del entrenador
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

              // Información del entrenador
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre y rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trainer.name,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.warning,
                              size: 16,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              trainer.rating.toString(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Especialización
                    Text(
                      trainer.specialization,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Ubicación y experiencia
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.textSecondary,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            trainer.location,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${trainer.yearsOfExperience} años',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Botón para ir al marcador en el mapa
              InkWell(
                onTap: () async {
                  // Mover el mapa a la ubicación del entrenador
                  final GoogleMapController controller =
                      await _controller.future;
                  await controller.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(trainer.latitude, trainer.longitude),
                      16.0,
                    ),
                  );

                  // Mostrar bottom sheet después de un breve delay
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      _showTrainerBottomSheet(trainer);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.map,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
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
