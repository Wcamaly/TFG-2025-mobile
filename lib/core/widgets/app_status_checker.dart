import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../config/remote_config_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppStatusChecker extends StatefulWidget {
  final Widget child;

  const AppStatusChecker({
    super.key,
    required this.child,
  });

  @override
  State<AppStatusChecker> createState() => _AppStatusCheckerState();
}

class _AppStatusCheckerState extends State<AppStatusChecker> {
  bool _isChecking = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAppStatus();
  }

  Future<void> _checkAppStatus() async {
    try {
      // Verificar modo mantenimiento
      if (RemoteConfigService.maintenanceMode) {
        setState(() {
          _errorMessage = RemoteConfigService.maintenanceMessage;
          _isChecking = false;
        });
        return;
      }

      // Verificar versión mínima requerida
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final minVersion = RemoteConfigService.minAppVersion;

      if (_isVersionLower(currentVersion, minVersion)) {
        setState(() {
          _errorMessage = RemoteConfigService.forceUpdate
              ? 'Debes actualizar la aplicación para continuar.'
              : 'Hay una nueva versión disponible. Te recomendamos actualizar.';
          _isChecking = false;
        });
        return;
      }

      // Todo está bien, continuar
      setState(() {
        _isChecking = false;
      });
    } catch (e) {
      // En caso de error, permitir continuar
      setState(() {
        _isChecking = false;
      });
    }
  }

  bool _isVersionLower(String current, String minimum) {
    final currentParts = current.split('.').map(int.parse).toList();
    final minimumParts = minimum.split('.').map(int.parse).toList();

    // Asegurar que ambas listas tengan la misma longitud
    while (currentParts.length < minimumParts.length) {
      currentParts.add(0);
    }
    while (minimumParts.length < currentParts.length) {
      minimumParts.add(0);
    }

    for (int i = 0; i < currentParts.length; i++) {
      if (currentParts[i] < minimumParts[i]) {
        return true;
      } else if (currentParts[i] > minimumParts[i]) {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      final isForceUpdate = RemoteConfigService.forceUpdate;
      final isMaintenanceMode = RemoteConfigService.maintenanceMode;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isMaintenanceMode
                      ? Icons.build_outlined
                      : Icons.system_update_outlined,
                  size: 80,
                  color:
                      isMaintenanceMode ? AppColors.warning : AppColors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  isMaintenanceMode
                      ? 'Mantenimiento'
                      : 'Actualización Disponible',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (!isMaintenanceMode) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implementar apertura de store
                        // launch('https://apps.apple.com/app/id123456789');
                        // launch('https://play.google.com/store/apps/details?id=com.example.tfg');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Actualizar Ahora',
                        style: AppTextStyles.buttonLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (!isForceUpdate) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                      },
                      child: Text(
                        'Continuar sin actualizar',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
                if (isMaintenanceMode) ...[
                  ElevatedButton(
                    onPressed: _checkAppStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Reintentar',
                      style: AppTextStyles.buttonLarge,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }
}
