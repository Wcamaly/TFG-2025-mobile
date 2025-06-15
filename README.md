# TFG-2025-Mobile

Aplicación móvil desarrollada en Flutter para el Trabajo de Fin de Grado 2025.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (última versión estable)
- [Android Studio](https://developer.android.com/studio) (para desarrollo Android)
- [Xcode](https://developer.apple.com/xcode/) (para desarrollo iOS, solo en macOS)
- [VS Code](https://code.visualstudio.com/) (opcional, pero recomendado)

## Configuración del Entorno

1. Clona el repositorio:
```bash
git clone https://github.com/tu-usuario/TFG-2025-mobile.git
cd TFG-2025-mobile
```

2. Instala las dependencias:
```bash
flutter pub get
```

## Ejecutar la Aplicación

### Android

#### Usando Emulador
1. Abre Android Studio
2. Inicia un emulador Android desde AVD Manager
3. Ejecuta la aplicación:
```bash
flutter run
```

#### En Dispositivo Físico
1. Activa el modo desarrollador en tu dispositivo Android
2. Conecta tu dispositivo vía USB
3. Ejecuta:
```bash
flutter run
```

#### Generar APK
Para generar un archivo APK instalable:
```bash
flutter build apk
```
El APK se generará en `build/app/outputs/flutter-apk/app-release.apk`

### iOS

#### Usando Simulador
1. Abre un simulador iOS:
```bash
open -a Simulator
```
2. Ejecuta la aplicación:
```bash
flutter run
```

#### En Dispositivo Físico
1. Abre el proyecto en Xcode:
```bash
open ios/Runner.xcworkspace
```
2. Configura tu equipo de desarrollo en Xcode
3. Conecta tu dispositivo iOS
4. Selecciona tu dispositivo en Xcode y ejecuta la aplicación

## Estructura del Proyecto

La aplicación sigue una arquitectura feature-first combinada con los principios de Clean Architecture:

```
lib/
├── features/           # Características principales de la aplicación
│   ├── authentication/ # Feature de autenticación
│   │   ├── data/      # Implementación de repositorios y fuentes de datos
│   │   ├── domain/    # Entidades, casos de uso e interfaces de repositorios
│   │   └── presentation/ # UI y lógica de presentación (providers, widgets)
│   │
│   ├── dashboard/     # Feature del dashboard principal
│   ├── nutrition/     # Feature de nutrición
│   ├── onboarding/    # Feature de onboarding
│   ├── trainer/       # Feature de entrenador
│   └── workouts/      # Feature de entrenamientos
│
├── core/              # Funcionalidades centrales y configuración
│   ├── routes/        # Configuración de navegación
│   ├── theme/         # Temas y estilos de la aplicación
│   ├── error/         # Manejo de errores
│   └── di/           # Configuración de inyección de dependencias
│
└── main.dart         # Punto de entrada de la aplicación

test/                 # Tests
├── features/         # Tests organizados por features
└── core/            # Tests de funcionalidades core

assets/              # Recursos estáticos
├── images/         # Imágenes
├── fonts/          # Fuentes
└── icons/          # Iconos
```

### Arquitectura por Features

Cada feature sigue la arquitectura limpia con tres capas principales:

#### 1. Presentation
- Widgets de UI
- Providers de estado (usando Riverpod)
- Controllers de la lógica de presentación

#### 2. Domain
- Entidades de negocio
- Casos de uso
- Interfaces de repositorios

#### 3. Data
- Implementaciones de repositorios
- Modelos de datos
- Fuentes de datos (API, local storage)

### Core

El directorio `core` contiene funcionalidades compartidas:
- Configuración de rutas con GoRouter
- Temas y estilos globales
- Manejo centralizado de errores
- Configuración de dependencias

### Convenciones de Código

- Nombres de archivos: snake_case
- Nombres de clases: PascalCase
- Nombres de variables y funciones: camelCase
- Providers: Sufijo con Provider (AuthProvider)
- Controllers: Sufijo con Controller (AuthController)
- Estados: Sufijo con State (AuthState)
- Repositorios: Sufijo con Repository (AuthRepository)
- Casos de uso: Sufijo con UseCase (LoginUseCase)

### Gestión de Estado

La aplicación utiliza Riverpod para la gestión del estado. Los providers se organizan por features y siguen estas convenciones:

- StateNotifierProvider: Para estados complejos con lógica de negocio
- StateProvider: Para estados simples
- FutureProvider: Para operaciones asíncronas
- Provider: Para dependencias y computaciones

### Inyección de Dependencias

Riverpod maneja la inyección de dependencias de manera nativa:
- Cada feature declara sus propios providers
- Los providers globales se declaran en core/di
- Se utiliza el patrón repository para el acceso a datos
- Los providers son fácilmente sobrescribibles para testing
