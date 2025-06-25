# 🗺️ Configuración de Google Maps

## Problema Identificado

El método `_loadMapSafely()` estaba causando crashes porque:

1. ❌ **API Key hardcodeada** - No se configuraba dinámicamente
2. ❌ **Validaciones faltantes** - No verificaba permisos ni configuración
3. ❌ **Lógica incompleta** - Solo tenía un delay sin validaciones reales
4. ❌ **Manejo de errores deficiente** - No capturaba excepciones específicas
5. ❌ **CRÍTICO: Configuración nativa faltante** - iOS y Android necesitan API key en tiempo de compilación

## Solución Implementada

### 1. **Método `_loadMapSafely()` Mejorado**

```dart
Future<void> _loadMapSafely() async {
  try {
    // 1. Validar API Key
    if (RemoteConfigService.googleMapsApiKey.isEmpty || 
        RemoteConfigService.googleMapsApiKey == 'YOUR_ACTUAL_API_KEY_HERE') {
      throw Exception('API Key de Google Maps no configurada');
    }

    // 2. Verificar permisos de ubicación
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // 3. Verificar servicios de ubicación
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // 4. Validar que el widget siga mounted
    if (!mounted) {
      throw Exception('Widget disposed durante la carga');
    }

    // 5. Registrar estado de configuración
    print('✅ Mapa configurado correctamente');
    
  } catch (e) {
    print('❌ Error: $e');
    rethrow; // Para que FutureBuilder capture el error
  }
}
```

### 2. **Configuración de API Keys**

#### **Android** (`android/app/src/main/AndroidManifest.xml`)
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="${googleMapsApiKey}"/>
```

#### **iOS** (`ios/Runner/Info.plist`)
```xml
<key>GMSApiKey</key>
<string>$(GOOGLE_MAPS_API_KEY)</string>
```

#### **iOS** (`ios/Runner/AppDelegate.swift`) - **CRÍTICO**
```swift
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // OBLIGATORIO: Configurar API key antes de usar Google Maps
    GMSServices.provideAPIKey("TU_API_KEY_AQUI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 3. **Configuración en Firebase Remote Config**

1. Ve a **Firebase Console** → **Remote Config**
2. Agrega la clave: `GOOGLE_MAPS_API_KEY`
3. Valor: Tu API key de Google Maps
4. Publica los cambios

### 4. **Configuración de Variables de Entorno**

#### **Para Android** (`android/app/build.gradle.kts`)
```kotlin
android {
    defaultConfig {
        // Otras configuraciones...
        manifestPlaceholders["googleMapsApiKey"] = 
            project.findProperty("GOOGLE_MAPS_API_KEY") ?: "YOUR_API_KEY_HERE"
    }
}
```

#### **Para iOS** (`ios/Runner.xcodeproj`)
En Build Settings → User-Defined Settings:
- Clave: `GOOGLE_MAPS_API_KEY`
- Valor: Tu API key

### 5. **Archivo `.env`**
```env
GOOGLE_MAPS_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Beneficios de la Solución

✅ **Validación robusta** - Verifica configuración antes de inicializar  
✅ **Manejo de errores específicos** - Mensajes claros para cada tipo de error  
✅ **Permisos verificados** - Solicita permisos de ubicación correctamente  
✅ **Prevención de crashes** - Validaciones exhaustivas  
✅ **UI mejorada** - Indicadores de carga y estados de error  
✅ **Debugging avanzado** - Logs detallados para diagnosticar problemas  

## Pasos para Obtener Google Maps API Key

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un proyecto o selecciona uno existente
3. Habilita **Maps SDK for Android** y **Maps SDK for iOS**
4. Ve a **Credenciales** → **Crear credenciales** → **Clave de API**
5. Restringe la clave por aplicación (recomendado para producción)
6. Copia la clave y configúrala según las instrucciones arriba

## Debugging

Para verificar que funciona correctamente, revisa los logs:

```
🗺️ Iniciando carga segura del mapa...
✅ API Key válida: AIzaSyXXXX...
✅ Permisos de ubicación: granted
✅ Servicios de ubicación: true
✅ Entrenadores a mostrar: 5
✅ Mapa cargado de forma segura
```

Si ves errores como:
- `❌ API Key de Google Maps no configurada` → Configurar Remote Config
- `❌ Permisos de ubicación denegados` → Verificar permisos en dispositivo
- `❌ Widget disposed` → Problema de ciclo de vida del widget 