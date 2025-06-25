# Configuración de Variables de Entorno y Remote Config
R
Este proyecto utiliza un sistema híbrido de configuración que combina variables de entorno locales (.env) con Firebase Remote Config para máxima flexibilidad y seguridad.

## 🏗️ Arquitectura de Configuración

### Prioridad de Configuración:
1. **Firebase Remote Config** (Dinámico, sin necesidad de actualizar la app)
2. **Variables de entorno (.env)** (Local, para desarrollo)
3. **Valores por defecto** (Hardcoded en el código)

## 📋 Configuración Inicial

### 1. Crear archivo `.env`

Crea un archivo `.env` en la raíz del proyecto (mismo nivel que `pubspec.yaml`):

```bash
# En la raíz del proyecto
touch .env
```

### 2. Configurar variables en `.env`

Agrega el siguiente contenido al archivo `.env`:

```env
# Google Maps API Key (REQUERIDA para desarrollo)
GOOGLE_MAPS_API_KEY=tu_api_key_real_aqui

# Configuración de entorno
ENVIRONMENT=development

# APIs adicionales (opcionales)
FIREBASE_API_KEY=tu_firebase_key_aqui
API_BASE_URL=https://api-dev.gymnestic.com

# Configuración de debug
DEBUG_MODE=true
LOG_LEVEL=verbose
```

### 3. Configurar Firebase Remote Config

Sigue la guía completa en `FIREBASE_REMOTE_CONFIG_SETUP.md` para configurar Remote Config.

## 🗺️ Obtener Google Maps API Key

### Paso 1: Google Cloud Console
1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita las siguientes APIs:
   - **Maps SDK for Android**
   - **Maps SDK for iOS**
   - **Places API** (opcional)

### Paso 2: Crear API Key
1. Ve a **Credenciales** → **Crear credenciales** → **Clave de API**
2. Copia la API Key generada
3. **IMPORTANTE**: Restringe la API Key por aplicación para seguridad

### Paso 3: Configurar restricciones
Para **Android**:
- Tipo de restricción: **Aplicaciones de Android**
- Nombre del paquete: `com.example.tfg`
- Huella digital SHA-1: (obtener con `keytool`)

Para **iOS**:
- Tipo de restricción: **Aplicaciones de iOS**
- ID del paquete: `com.example.tfg`

## 🔧 Uso en el Código

### Variables de Entorno (.env)
```dart
import 'package:your_app/core/config/env_config.dart';

// Obtener valores del .env
String apiKey = EnvConfig.googleMapsApiKey;
bool isDev = EnvConfig.isDevelopment;
```

### Firebase Remote Config
```dart
import 'package:your_app/core/config/remote_config_service.dart';

// Obtener valores de Remote Config (con fallback a .env)
String apiKey = RemoteConfigService.googleMapsApiKey;
String apiUrl = RemoteConfigService.apiBaseUrl;
bool isFeatureEnabled = RemoteConfigService.enableTrainerChat;
```

## 🚨 Seguridad

### ⚠️ NUNCA hagas commit del archivo `.env`
El archivo `.env` está incluido en `.gitignore` para evitar exponer credenciales.

### ✅ Buenas prácticas:
- Usa `.env` solo para desarrollo local
- Usa Remote Config para configuraciones de producción
- Usa diferentes API Keys para desarrollo y producción
- Restringe las API Keys por aplicación
- Rota las API Keys periódicamente

## 🛠️ Troubleshooting

### Error: "Google Maps API Key no configurada"
1. **Para desarrollo**: Verifica que el archivo `.env` existe y contiene `GOOGLE_MAPS_API_KEY`
2. **Para producción**: Configura `google_maps_api_key` en Firebase Remote Config
3. Reinicia la aplicación después de cambiar la configuración

### Error: "Map failed to load"
1. Verifica que la API Key es válida
2. Asegúrate de que las APIs están habilitadas en Google Cloud
3. Verifica las restricciones de la API Key

### Comandos útiles:
```bash
# Verificar que el archivo .env existe
ls -la | grep .env

# Ver contenido del .env (cuidado con las credenciales)
cat .env

# Limpiar y reconstruir
flutter clean
flutter pub get

# Verificar configuración de Remote Config (en la app)
RemoteConfigService.printAllConfig();
```

## 🔄 Flujo de Configuración por Entorno

### 1. **Desarrollo Local**
- Usa archivo `.env` con configuraciones de desarrollo
- Remote Config como fallback
- Debug habilitado

### 2. **Staging/Testing**
- Remote Config con configuraciones de staging
- `.env` como fallback para casos específicos
- Debug limitado

### 3. **Producción**
- Completamente gestionado por Remote Config
- `.env` no se incluye en el build de producción
- Sin debug

## 📊 Ventajas del Sistema Híbrido

### 🏠 **Variables de Entorno (.env)**
✅ **Ventajas:**
- Control total en desarrollo
- No requiere conexión a internet
- Configuración inmediata
- Ideal para secrets locales

❌ **Desventajas:**
- Requiere rebuild para cambios
- No funciona en producción
- Riesgo de exposición si se commitea

### ☁️ **Firebase Remote Config**
✅ **Ventajas:**
- Cambios sin actualizar la app
- Configuración por segmentos de usuarios
- A/B testing integrado
- Rollback inmediato

❌ **Desventajas:**
- Requiere conexión a internet
- Latencia en la primera carga
- Dependencia de Firebase

## 🎯 Casos de Uso Recomendados

### Usar `.env` para:
- Desarrollo local
- API Keys de desarrollo
- Configuraciones específicas del desarrollador
- Secrets que no deben estar en Remote Config

### Usar Remote Config para:
- URLs de API de producción
- Feature flags
- Configuraciones de UI
- Timeouts y límites
- Mensajes de usuario
- Control de versiones
- Modo mantenimiento

## 🔄 Ejemplo de Configuración Completa

### `.env` (Desarrollo)
```env
# Desarrollo local
GOOGLE_MAPS_API_KEY=AIzaSyDev_Key_For_Development_Only
ENVIRONMENT=development
API_BASE_URL=http://localhost:3000
DEBUG_MODE=true
```

### Remote Config (Producción)
```json
{
  "google_maps_api_key": "AIzaSyProd_Key_For_Production",
  "api_base_url": "https://api.gymnestic.com",
  "maintenance_mode": false,
  "feature_flags_enable_trainer_chat": true
}
```

¡Con esta configuración híbrida tienes lo mejor de ambos mundos: control local para desarrollo y flexibilidad remota para producción! 