# Configuración de Google Maps para iOS

## Problema Actual
La aplicación se cierra cuando intentas acceder al mapa porque la API key de Google Maps no está configurada correctamente.

## Solución

### 1. Obtener API Key de Google Cloud Console

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita las siguientes APIs:
   - **Maps SDK for iOS**
   - **Places API** (opcional, para búsquedas)
   - **Geocoding API** (opcional, para direcciones)

### 2. Crear API Key

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en **+ CREATE CREDENTIALS** > **API Key**
3. Copia la API key generada

### 3. Configurar la API Key en el Proyecto

#### Opción A: Configuración Directa (Recomendada para desarrollo)

Edita el archivo `lib/core/config/env_config.dart`:

```dart
static const String googleMapsApiKey = 'TU_API_KEY_AQUI';
```

#### Opción B: Configuración en Info.plist (Para producción)

Edita el archivo `ios/Runner/Info.plist`:

```xml
<key>GMSApiKey</key>
<string>TU_API_KEY_AQUI</string>
```

### 4. Restricciones de Seguridad (Recomendado)

En Google Cloud Console, configura restricciones para tu API key:

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en tu API key
3. En **Application restrictions**, selecciona **iOS Apps**
4. Agrega tu Bundle ID: `com.example.tfg`
5. En **API restrictions**, selecciona las APIs que necesitas

### 5. Verificar Configuración

1. Ejecuta `flutter clean`
2. Ejecuta `flutter pub get`
3. Ejecuta `flutter run`

## Archivos a Modificar

- `lib/core/config/env_config.dart` - API key principal
- `ios/Runner/Info.plist` - Configuración iOS (opcional)

## Notas Importantes

- **Nunca subas tu API key real a Git**
- Usa variables de entorno en producción
- Configura restricciones de seguridad en Google Cloud Console
- La API key debe tener habilitada la API "Maps SDK for iOS"

## Troubleshooting

### Error: "This app is not authorized to use this API"
- Verifica que la API "Maps SDK for iOS" esté habilitada
- Verifica las restricciones de tu API key

### Error: "API key not valid"
- Verifica que la API key esté correctamente copiada
- Verifica que no haya espacios extra

### App se cierra sin errores
- Verifica que la API key esté configurada en ambos archivos
- Ejecuta `flutter clean` y vuelve a compilar 