# Configuración de Firebase Remote Config

Este documento explica cómo configurar Firebase Remote Config para manejar todas las configuraciones de la aplicación de forma dinámica.

## 📋 Configuración Inicial

### 1. Acceder a Firebase Console
1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto
3. Ve a **Remote Config** en el menú lateral

### 2. Crear Parámetros de Configuración

Crea los siguientes parámetros en Remote Config:

#### 🗺️ **Configuraciones Principales**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `google_maps_api_key` | String | `YOUR_GOOGLE_MAPS_API_KEY_HERE` | API Key de Google Maps |
| `api_base_url` | String | `https://api.gymnestic.com` | URL base de la API |
| `enable_crashlytics` | Boolean | `true` | Habilitar Firebase Crashlytics |
| `enable_analytics` | Boolean | `true` | Habilitar Firebase Analytics |

#### 🔄 **Control de Versiones**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `min_app_version` | String | `1.0.0` | Versión mínima requerida |
| `force_update` | Boolean | `false` | Forzar actualización |
| `maintenance_mode` | Boolean | `false` | Modo mantenimiento |
| `maintenance_message` | String | `La aplicación está en mantenimiento...` | Mensaje de mantenimiento |

#### 🎛️ **Feature Flags**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `feature_flags_enable_nutrition_tracking` | Boolean | `true` | Seguimiento nutricional |
| `feature_flags_enable_social_features` | Boolean | `false` | Características sociales |
| `feature_flags_enable_premium_features` | Boolean | `true` | Características premium |
| `feature_flags_enable_trainer_chat` | Boolean | `false` | Chat con entrenador |
| `feature_flags_enable_workout_sharing` | Boolean | `true` | Compartir entrenamientos |

#### ⚙️ **Configuraciones de API**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `api_timeouts_connect_timeout` | Number | `30000` | Timeout de conexión (ms) |
| `api_timeouts_receive_timeout` | Number | `30000` | Timeout de recepción (ms) |
| `api_timeouts_send_timeout` | Number | `30000` | Timeout de envío (ms) |

#### 🎨 **Configuraciones de UI**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `ui_settings_show_onboarding` | Boolean | `true` | Mostrar onboarding |
| `ui_settings_max_trainers_per_page` | Number | `20` | Máx. entrenadores por página |
| `ui_settings_enable_dark_theme_only` | Boolean | `true` | Solo tema oscuro |

#### 💳 **Configuraciones de Suscripción**

| Parámetro | Tipo | Valor por Defecto | Descripción |
|-----------|------|-------------------|-------------|
| `subscription_settings_trial_period_days` | Number | `7` | Días de período de prueba |
| `subscription_settings_show_premium_banner` | Boolean | `true` | Mostrar banner premium |
| `subscription_settings_premium_features_preview` | Boolean | `true` | Vista previa premium |

## 🚀 Casos de Uso Comunes

### 1. **Activar/Desactivar Características**
```json
{
  "feature_flags_enable_trainer_chat": true,
  "feature_flags_enable_social_features": false
}
```

### 2. **Modo Mantenimiento**
```json
{
  "maintenance_mode": true,
  "maintenance_message": "Estamos actualizando la aplicación. Volveremos pronto."
}
```

### 3. **Forzar Actualización**
```json
{
  "min_app_version": "1.2.0",
  "force_update": true
}
```

### 4. **Cambiar URL de API**
```json
{
  "api_base_url": "https://api-staging.gymnestic.com"
}
```

### 5. **Ajustar Timeouts**
```json
{
  "api_timeouts_connect_timeout": 45000,
  "api_timeouts_receive_timeout": 60000
}
```

## 🎯 Configuraciones por Condición

### Configuración por Versión de App
- **Condición**: `app.version >= 1.2.0`
- **Valores**: Habilitar nuevas características

### Configuración por Plataforma
- **Condición**: `device.os == 'android'`
- **Valores**: Configuraciones específicas de Android

### Configuración por País
- **Condición**: `device.country in ['ES', 'MX', 'AR']`
- **Valores**: Configuraciones para países hispanohablantes

### Configuración por Porcentaje de Usuarios
- **Condición**: `percent <= 10`
- **Valores**: Características en beta para 10% de usuarios

## 🔧 Comandos Útiles

### Verificar Estado de Remote Config
```dart
// En la app, para debugging
RemoteConfigService.printAllConfig();
```

### Forzar Actualización de Configuración
```dart
await RemoteConfigService.forceRefresh();
```

### Obtener Configuración Específica
```dart
bool isFeatureEnabled = RemoteConfigService.enableTrainerChat;
String apiUrl = RemoteConfigService.apiBaseUrl;
int timeout = RemoteConfigService.connectTimeout;
```

## 📊 Monitoreo y Analytics

### Métricas Importantes
- **Fetch Success Rate**: % de actualizaciones exitosas
- **Feature Flag Usage**: Uso de características por flag
- **Error Rate**: Errores relacionados con configuración

### Alertas Recomendadas
- Configuración no se puede obtener por > 5 minutos
- Tasa de errores > 5% en configuración
- Modo mantenimiento activado por > 1 hora

## 🛡️ Seguridad

### ⚠️ **NO incluir en Remote Config:**
- Claves privadas o secrets
- Tokens de autenticación
- Información personal de usuarios
- Configuraciones de seguridad críticas

### ✅ **SÍ incluir en Remote Config:**
- URLs de API públicas
- Feature flags
- Configuraciones de UI
- Timeouts y límites
- Mensajes de usuario

## 🔄 Flujo de Desarrollo

### 1. **Desarrollo**
```json
{
  "environment": "development",
  "api_base_url": "https://api-dev.gymnestic.com",
  "enable_debug_features": true
}
```

### 2. **Staging**
```json
{
  "environment": "staging",
  "api_base_url": "https://api-staging.gymnestic.com",
  "enable_debug_features": false
}
```

### 3. **Producción**
```json
{
  "environment": "production",
  "api_base_url": "https://api.gymnestic.com",
  "enable_debug_features": false
}
```

## 📱 Ejemplo de Configuración JSON Completa

```json
{
  "google_maps_api_key": "AIzaSyBvOkBo0jlvl5Y1N9QnbDOiI2HI4yqqsD4",
  "api_base_url": "https://api.gymnestic.com",
  "enable_crashlytics": true,
  "enable_analytics": true,
  "min_app_version": "1.0.0",
  "force_update": false,
  "maintenance_mode": false,
  "maintenance_message": "La aplicación está en mantenimiento. Inténtalo más tarde.",
  
  "feature_flags_enable_nutrition_tracking": true,
  "feature_flags_enable_social_features": false,
  "feature_flags_enable_premium_features": true,
  "feature_flags_enable_trainer_chat": false,
  "feature_flags_enable_workout_sharing": true,
  
  "api_timeouts_connect_timeout": 30000,
  "api_timeouts_receive_timeout": 30000,
  "api_timeouts_send_timeout": 30000,
  
  "ui_settings_show_onboarding": true,
  "ui_settings_max_trainers_per_page": 20,
  "ui_settings_enable_dark_theme_only": true,
  
  "subscription_settings_trial_period_days": 7,
  "subscription_settings_show_premium_banner": true,
  "subscription_settings_premium_features_preview": true
}
```

¡Con esta configuración tendrás control total sobre tu aplicación sin necesidad de actualizaciones en las tiendas! 

# Configuración de Firebase Remote Config para Google Maps

## Problema Actual
La aplicación se cierra cuando accedes al mapa porque la API key de Google Maps no está configurada en Firebase Remote Config.

## Solución

### 1. Obtener API Key de Google Cloud Console

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita **Maps SDK for iOS**
4. Ve a **APIs & Services** > **Credentials**
5. Crea una nueva API Key
6. Copia la API key generada

### 2. Configurar Firebase Remote Config

#### Opción A: Usando Firebase Console (Recomendado)

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto
3. Ve a **Engage** > **Remote Config**
4. Haz clic en **Add your first parameter**
5. Configura el parámetro:
   - **Parameter key**: `google_maps_api_key`
   - **Default value**: `TU_API_KEY_AQUI`
   - **Description**: `API Key para Google Maps iOS`
6. Haz clic en **Publish changes**

#### Opción B: Usando Firebase CLI

1. Instala Firebase CLI si no lo tienes:
   ```bash
   npm install -g firebase-tools
   ```

2. Inicia sesión en Firebase:
   ```bash
   firebase login
   ```

3. Configura Remote Config:
   ```bash
   firebase remoteconfig:get > remote-config.json
   ```

4. Edita el archivo `remote-config.json`:
   ```json
   {
     "conditions": [
       {
         "name": "Default",
         "expression": "true",
         "tagColor": "BLUE"
       }
     ],
     "parameters": {
       "google_maps_api_key": {
         "defaultValue": {
           "value": "TU_API_KEY_AQUI"
         },
         "description": "API Key para Google Maps iOS"
       }
     },
     "version": {
       "versionNumber": "1",
       "updateTime": "2024-01-01T00:00:00Z",
       "updateUser": {
         "email": "tu-email@example.com"
       },
       "updateOrigin": "CONSOLE",
       "updateType": "INCREMENTAL_UPDATE"
     }
   }
   ```

5. Publica la configuración:
   ```bash
   firebase remoteconfig:set remote-config.json
   ```

### 3. Verificar Configuración

1. En Firebase Console, ve a **Remote Config**
2. Verifica que el parámetro `google_maps_api_key` esté configurado
3. Verifica que el valor no sea el placeholder

### 4. Probar en la App

1. Ejecuta la app
2. Ve al mapa
3. La app debería cargar el mapa correctamente

## Estructura de Remote Config

El proyecto ya está configurado para usar estos parámetros:

```json
{
  "google_maps_api_key": "TU_API_KEY_AQUI",
  "api_base_url": "https://api.gymnestic.com",
  "enable_crashlytics": true,
  "enable_analytics": true,
  "min_app_version": "1.0.0",
  "force_update": false,
  "maintenance_mode": false,
  "maintenance_message": "La aplicación está en mantenimiento. Inténtalo más tarde.",
  "feature_flags_enable_nutrition_tracking": true,
  "feature_flags_enable_social_features": false,
  "feature_flags_enable_premium_features": true,
  "feature_flags_enable_trainer_chat": false,
  "feature_flags_enable_workout_sharing": true,
  "api_timeouts_connect_timeout": 30000,
  "api_timeouts_receive_timeout": 30000,
  "api_timeouts_send_timeout": 30000,
  "ui_settings_show_onboarding": true,
  "ui_settings_max_trainers_per_page": 20,
  "ui_settings_enable_dark_theme_only": true,
  "subscription_settings_trial_period_days": 7,
  "subscription_settings_show_premium_banner": true,
  "subscription_settings_premium_features_preview": true
}
```

## Código de la App

La app ya está configurada para obtener la API key desde Remote Config:

```dart
// En RemoteConfigService
static String get googleMapsApiKey {
  final remoteKey = _remoteConfig?.getString('google_maps_api_key') ?? '';
  final envKey = EnvConfig.googleMapsApiKey;

  // Prioridad: Remote Config > .env > default
  if (remoteKey.isNotEmpty && remoteKey != 'YOUR_GOOGLE_MAPS_API_KEY_HERE') {
    return remoteKey;
  }
  if (envKey.isNotEmpty && envKey != 'YOUR_ACTUAL_API_KEY_HERE') {
    return envKey;
  }
  return remoteKey;
}
```

## Troubleshooting

### Error: "API key not valid"
- Verifica que la API key esté correctamente copiada en Firebase Remote Config
- Verifica que la API "Maps SDK for iOS" esté habilitada en Google Cloud Console

### Error: "This app is not authorized to use this API"
- Verifica las restricciones de tu API key en Google Cloud Console
- Asegúrate de que el Bundle ID esté configurado: `com.example.tfg`

### App se cierra sin errores
- Verifica que Remote Config esté inicializado correctamente
- Verifica que el parámetro `google_maps_api_key` esté configurado en Firebase
- Ejecuta `flutter clean` y vuelve a compilar

### Remote Config no se actualiza
- Verifica la conexión a internet
- Verifica que Firebase esté configurado correctamente
- Usa `RemoteConfigService.forceRefresh()` para forzar la actualización 