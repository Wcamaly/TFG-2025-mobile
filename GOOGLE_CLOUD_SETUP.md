# Configuración Completa de Google Cloud Console para Google Maps

## Problema Actual
- **Android**: El mapa se queda lagueado y no muestra nada
- **iOS**: La app se cierra al abrir el mapa

## Solución Completa

### 1. Configuración de Google Cloud Console

#### 1.1 Habilitar APIs Necesarias

Ve a [Google Cloud Console](https://console.cloud.google.com/) y habilita estas APIs:

**APIs Principales:**
- ✅ **Maps SDK for Android**
- ✅ **Maps SDK for iOS**
- ✅ **Places API** (para búsquedas)
- ✅ **Geocoding API** (para direcciones)
- ✅ **Directions API** (para rutas)

**APIs Adicionales (opcionales):**
- ✅ **Geolocation API** (para ubicación precisa)
- ✅ **Distance Matrix API** (para distancias)

#### 1.2 Configurar Restricciones de API Key

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en tu API key
3. Configura las restricciones:

**Application restrictions:**
- Selecciona **Android apps**
- Agrega tu package name: `com.example.tfg`
- Agrega tu SHA-1 fingerprint (ver instrucciones abajo)

- Selecciona **iOS apps**
- Agrega tu Bundle ID: `com.example.tfg`

**API restrictions:**
- Selecciona **Restrict key**
- Selecciona solo las APIs que necesitas:
  - Maps SDK for Android
  - Maps SDK for iOS
  - Places API
  - Geocoding API

### 2. Obtener SHA-1 Fingerprint para Android

Ejecuta este comando para obtener tu SHA-1:

```bash
# Para debug
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Para release (si tienes keystore personalizado)
keytool -list -v -keystore /path/to/your/keystore.jks -alias your-alias
```

### 3. Verificar Configuración de Firebase Remote Config

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto
3. Ve a **Remote Config**
4. Verifica que el parámetro `google_maps_api_key` tenga tu API key real

### 4. Verificar Configuración de Android

#### 4.1 AndroidManifest.xml

Verifica que tengas los permisos necesarios:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

#### 4.2 google-services.json

Asegúrate de que el archivo `google-services.json` esté en `android/app/` y contenga la configuración correcta.

### 5. Verificar Configuración de iOS

#### 5.1 Info.plist

Verifica que tengas los permisos necesarios:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Esta aplicación necesita acceso a tu ubicación para mostrarte entrenadores cercanos en el mapa.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Esta aplicación necesita acceso a tu ubicación para mostrarte entrenadores cercanos en el mapa.</string>
```

#### 5.2 GoogleService-Info.plist

Asegúrate de que el archivo `GoogleService-Info.plist` esté en `ios/Runner/` y contenga la configuración correcta.

### 6. Testing y Debugging

#### 6.1 Verificar API Key

Ejecuta la app y revisa los logs para verificar:

```
🗺️ Google Maps API Key obtenida: AIzaSyBKDO...
🗺️ Longitud de la API key: 39
```

#### 6.2 Verificar Ubicación

```
📍 Obteniendo ubicación actual...
📍 Ubicación obtenida: 40.4168, -3.7038
```

#### 6.3 Verificar Marcadores

```
📍 Creando marcadores para 5 entrenadores...
✅ Mapa inicializado correctamente
```

### 7. Troubleshooting

#### Error: "This app is not authorized to use this API"
- Verifica que las APIs estén habilitadas en Google Cloud Console
- Verifica las restricciones de la API key
- Verifica que el package name/Bundle ID esté correcto

#### Error: "API key not valid"
- Verifica que la API key esté correctamente copiada
- Verifica que no haya espacios extra
- Verifica que la API key esté activa

#### Android: Mapa lagueado
- Verifica que el SHA-1 fingerprint esté configurado
- Verifica que el package name esté correcto
- Verifica que la API "Maps SDK for Android" esté habilitada

#### iOS: App se cierra
- Verifica que el Bundle ID esté configurado
- Verifica que la API "Maps SDK for iOS" esté habilitada
- Verifica los permisos de ubicación

### 8. Comandos de Verificación

```bash
# Limpiar y reconstruir
cd android && ./gradlew clean && cd ..
flutter run

# Verificar logs
flutter logs
```

### 9. Configuración Final

Una vez que todo esté configurado correctamente:

1. **Ejecuta la app** en ambos dispositivos
2. **Ve al mapa** de entrenadores
3. **Verifica** que se muestre correctamente
4. **Prueba** la funcionalidad de ubicación

## Estado Esperado

Después de la configuración correcta:
- ✅ **Android**: Mapa se carga correctamente con marcadores
- ✅ **iOS**: Mapa se carga correctamente sin cerrar la app
- ✅ **Ubicación**: Se obtiene la ubicación actual
- ✅ **Marcadores**: Se muestran los entrenadores en el mapa 