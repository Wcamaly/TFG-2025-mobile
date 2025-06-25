# Checklist de Google Cloud Console - Problema de Crash en GoogleMap

## ❌ Problema Identificado
La app se cierra exactamente cuando intenta crear el widget `GoogleMap`, incluso con la API key configurada.

## ✅ Checklist de Configuración

### 1. APIs Habilitadas (CRÍTICO)

Ve a [Google Cloud Console](https://console.cloud.google.com/) > **APIs & Services** > **Library** y habilita:

#### APIs OBLIGATORIAS:
- [ ] **Maps SDK for Android** ⭐
- [ ] **Maps SDK for iOS** ⭐
- [ ] **Places API** ⭐
- [ ] **Geocoding API** ⭐

#### APIs OPCIONALES:
- [ ] **Directions API**
- [ ] **Geolocation API**
- [ ] **Distance Matrix API**

### 2. Configuración de API Key (CRÍTICO)

Ve a **APIs & Services** > **Credentials** y configura tu API key:

#### Application Restrictions:
- [ ] **Android apps**:
  - Package name: `com.example.tfg`
  - SHA-1: `0F:95:DA:FA:13:6F:C3:DF:60:10:CE:26:03:01:8F:F4:1B:FC:C5:F1`

- [ ] **iOS apps**:
  - Bundle ID: `com.example.tfg`

#### API Restrictions:
- [ ] Selecciona **Restrict key**
- [ ] Marca estas APIs:
  - [ ] Maps SDK for Android
  - [ ] Maps SDK for iOS
  - [ ] Places API
  - [ ] Geocoding API

### 3. Verificar Firebase Remote Config

Ve a [Firebase Console](https://console.firebase.google.com/) > **Remote Config**:

- [ ] Parámetro: `google_maps_api_key`
- [ ] Valor: `AIzaSyBKDOjEk3pHQDUGhPMRdD46oLKGK6xHAXM`
- [ ] Estado: **Published**

### 4. Verificar Facturación (IMPORTANTE)

En Google Cloud Console > **Billing**:

- [ ] Proyecto tiene facturación habilitada
- [ ] No hay límites de cuota alcanzados
- [ ] API key no está en modo de prueba

### 5. Verificar Permisos de Proyecto

En Google Cloud Console > **IAM & Admin** > **IAM**:

- [ ] Tu cuenta tiene rol **Editor** o superior
- [ ] No hay políticas que bloqueen las APIs

## 🔍 Pasos de Verificación

### Paso 1: Verificar APIs Habilitadas
```bash
# En Google Cloud Console, ve a APIs & Services > Dashboard
# Deberías ver las APIs listadas como "Enabled"
```

### Paso 2: Verificar API Key
```bash
# En APIs & Services > Credentials
# Haz clic en tu API key y verifica las restricciones
```

### Paso 3: Probar API Key
Puedes probar tu API key directamente:
```
https://maps.googleapis.com/maps/api/geocode/json?address=Madrid&key=TU_API_KEY
```

### Paso 4: Verificar Facturación
```bash
# En Billing > Account details
# Verifica que el estado sea "Active"
```

## 🚨 Problemas Comunes

### Error: "This app is not authorized to use this API"
- **Solución**: Verificar que las APIs estén habilitadas
- **Solución**: Verificar restricciones de la API key

### Error: "API key not valid"
- **Solución**: Verificar que la API key esté correctamente copiada
- **Solución**: Verificar que no haya espacios extra

### Error: "Quota exceeded"
- **Solución**: Verificar facturación del proyecto
- **Solución**: Verificar límites de cuota

### Error: "Project not found"
- **Solución**: Verificar que estés en el proyecto correcto
- **Solución**: Verificar permisos de la cuenta

## 📱 Testing

Una vez configurado todo:

1. **Ejecuta la app**
2. **Ve al mapa**
3. **Deberías ver**:
   ```
   🗺️ Construyendo widget del mapa...
   🗺️ Cargando mapa de forma segura...
   ✅ Mapa cargado exitosamente en FutureBuilder
   🗺️ Creando widget GoogleMap...
   🗺️ Controlador del mapa creado exitosamente
   ```

## 🔧 Comandos de Verificación

```bash
# Limpiar y reconstruir
cd android && ./gradlew clean && cd ..
flutter run

# Verificar logs
flutter logs
```

## 📞 Soporte

Si el problema persiste después de verificar todo:

1. **Revisa los logs** de Google Cloud Console
2. **Verifica la facturación** del proyecto
3. **Contacta soporte** de Google Cloud si es necesario 