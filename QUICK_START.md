# 🚀 Inicio Rápido - Gymnestic

## ✅ Errores Solucionados

### 1. ❌ Error de Asset de Google
**Problema**: `Unable to load asset: "assets/icons/google.png"`
**✅ Solucionado**: Reemplazado por ícono nativo de Flutter

### 2. ❌ Error de Google Maps iOS
**Problema**: `PlatformException(unregistered_view_type, A UIKitView widget is trying to create a PlatformView with an unregistered type: < plugins.flutter.dev/google_maps_ios >`
**✅ Solucionado**: Configuración actualizada para iOS

## 🗺️ Para Usar Google Maps (OPCIONAL)

Si quieres usar el mapa real de Google Maps:

### Opción 1: Variables de Entorno (.env)
```bash
# Crear archivo .env en la raíz del proyecto
echo "GOOGLE_MAPS_API_KEY=tu_api_key_aqui" > .env
```

### Opción 2: Firebase Remote Config
1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto → Remote Config
3. Agrega parámetro: `google_maps_api_key` = `tu_api_key_aqui`

### Obtener API Key de Google Maps
1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Habilita **Maps SDK for Android** y **Maps SDK for iOS**
3. Crea una **API Key**
4. Configúrala con restricciones de tu app

## 🏃‍♂️ Ejecutar la App

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en iOS
flutter run -d ios

# Ejecutar en Android
flutter run -d android
```

## 🎯 Estado Actual

✅ **Funcionando:**
- Autenticación completa
- Onboarding con persistencia
- Dashboard con navegación
- Búsqueda de trainers (vista lista)
- Suscripciones con pago simulado
- Sistema de configuración híbrido (.env + Remote Config)
- Tema oscuro completo
- Internacionalización (ES/EN)

⚠️ **Requiere configuración:**
- Google Maps API Key (opcional, usa simulador por defecto)

🔧 **Configuraciones disponibles vía Remote Config:**
- URLs de API
- Feature flags
- Timeouts
- Modo mantenimiento
- Control de versiones
- Configuraciones de UI

## 📱 Navegación de la App

1. **Splash** → **Onboarding** (solo primera vez)
2. **Login/Register** → **Dashboard**
3. **Dashboard** tiene 4 tabs:
   - **Home**: Resumen y estadísticas
   - **Trainers**: Búsqueda de entrenadores
   - **Workouts**: Entrenamientos del usuario
   - **Nutrition**: Seguimiento nutricional
4. **Perfil**: Accesible tocando la foto en la esquina superior derecha

## 🛠️ Si hay problemas:

```bash
# Limpiar proyecto
flutter clean
flutter pub get

# Verificar configuración (en la app)
RemoteConfigService.printAllConfig();
```

¡La app está lista para usar! 🎉 