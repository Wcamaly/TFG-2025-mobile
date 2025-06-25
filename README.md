# Gymnestic - App de Fitness

Una aplicación móvil moderna para fitness y entrenamiento personal, construida con Flutter y siguiendo principios de Clean Architecture.

## 🚀 Características

- **Autenticación completa** con email/password y Google Sign-In
- **Dashboard personalizado** con estadísticas de entrenamiento
- **Mapa de entrenadores** con Google Maps
- **Seguimiento nutricional** con planes de comidas
- **Sistema de entrenamientos** con ejercicios detallados
- **Tema oscuro** moderno y elegante
- **Internacionalización** (Español/Inglés)
- **Firebase Integration** con Remote Config y Crashlytics

## 📱 Capturas de Pantalla

[Capturas de pantalla aquí]

## 🛠️ Tecnologías

- **Flutter** 3.16+
- **Dart** 3.2+
- **Firebase** (Remote Config, Crashlytics, Analytics)
- **Google Maps** para iOS y Android
- **Riverpod** para gestión de estado
- **Clean Architecture** con Domain-Driven Design

## 📋 Requisitos

- Flutter 3.16.0 o superior
- Dart 3.2.0 o superior
- iOS 14.0+ / Android API 21+
- Cuenta de Google Cloud para Maps API
- Proyecto Firebase configurado

## 🔧 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/tfg-2025-mobile.git
cd tfg-2025-mobile
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Configurar Firebase

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Descarga los archivos de configuración:
   - `google-services.json` para Android
   - `GoogleService-Info.plist` para iOS
3. Colócalos en las carpetas correspondientes

### 4. Configurar Google Maps

#### Opción A: Script Automático (Recomendado)

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Ejecutar script de configuración
node scripts/setup_remote_config.js
```

#### Opción B: Configuración Manual

1. Obtén una API key de [Google Cloud Console](https://console.cloud.google.com/)
2. Habilita **Maps SDK for iOS** y **Maps SDK for Android**
3. Ve a [Firebase Console](https://console.firebase.google.com/) > **Remote Config**
4. Agrega el parámetro `google_maps_api_key` con tu API key

### 5. Ejecutar la aplicación

```bash
flutter run
```

## 🗂️ Estructura del Proyecto

```
lib/
├── core/                    # Código compartido
│   ├── config/             # Configuraciones
│   ├── di/                 # Inyección de dependencias
│   ├── error/              # Manejo de errores
│   ├── network/            # Servicios de red
│   ├── providers/          # Providers globales
│   ├── routes/             # Configuración de rutas
│   ├── services/           # Servicios compartidos
│   ├── theme/              # Temas y estilos
│   └── widgets/            # Widgets reutilizables
├── features/               # Características de la app
│   ├── authentication/     # Autenticación
│   ├── dashboard/          # Dashboard principal
│   ├── nutrition/          # Nutrición
│   ├── onboarding/         # Onboarding
│   ├── profile/            # Perfil de usuario
│   ├── splash/             # Pantalla de carga
│   ├── subscriptions/      # Suscripciones
│   ├── trainer/            # Entrenadores
│   ├── trainers/           # Búsqueda de entrenadores
│   └── workouts/           # Entrenamientos
└── main.dart               # Punto de entrada
```

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** con **Domain-Driven Design**:

- **Domain Layer**: Entidades, casos de uso y repositorios
- **Data Layer**: Implementaciones de repositorios y fuentes de datos
- **Presentation Layer**: UI, providers y widgets

### Patrones Utilizados

- **Repository Pattern**: Para acceso a datos
- **Use Case Pattern**: Para lógica de negocio
- **Provider Pattern**: Para gestión de estado
- **Dependency Injection**: Para inyección de dependencias

## 🔑 Configuración de APIs

### Google Maps

La API key de Google Maps se configura a través de **Firebase Remote Config**:

1. Obtén una API key de Google Cloud Console
2. Configúrala en Firebase Remote Config como `google_maps_api_key`
3. La app la obtendrá automáticamente al inicializar

### Firebase

- **Remote Config**: Para configuración dinámica
- **Crashlytics**: Para reportes de errores
- **Analytics**: Para métricas de uso

## 🧪 Testing

```bash
# Ejecutar tests unitarios
flutter test

# Ejecutar tests de widgets
flutter test test/widget_test.dart
```

## 📦 Build

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## 🚀 Deployment

### Android

1. Genera un keystore para firmar la app
2. Configura las credenciales en `android/app/build.gradle`
3. Ejecuta `flutter build appbundle --release`
4. Sube el archivo a Google Play Console

### iOS

1. Configura certificados en Xcode
2. Ejecuta `flutter build ios --release`
3. Archiva y sube a App Store Connect

## 📚 Documentación

- [Configuración de Google Maps](GOOGLE_MAPS_SETUP.md)
- [Configuración de Firebase Remote Config](FIREBASE_REMOTE_CONFIG_SETUP.md)
- [Guía de Arquitectura](ARCHITECTURE.md)

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 👨‍💻 Autor

**Tu Nombre** - [tu-email@example.com](mailto:tu-email@example.com)

## 🙏 Agradecimientos

- Flutter team por el framework
- Firebase team por las herramientas
- Comunidad de desarrolladores Flutter