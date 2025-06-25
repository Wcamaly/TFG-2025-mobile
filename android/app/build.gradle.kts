plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

// Load environment variables from .env file
val envFile = rootProject.file("../.env")
val envProperties = Properties()

if (envFile.exists()) {
    envFile.inputStream().use { stream ->
        envProperties.load(stream)
    }
}

// Function to get environment variable with fallback
fun getEnvVar(name: String, fallback: String = ""): String {
    return envProperties.getProperty(name) 
        ?: System.getenv(name) 
        ?: fallback
}

android {
    namespace = "com.example.tfg"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.tfg"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Pass environment variables to AndroidManifest.xml
        // TEMPORAL: Usando API key hardcodeada - reemplaza con tu API key real
        manifestPlaceholders["googleMapsApiKey"] = getEnvVar("GOOGLE_MAPS_API_KEY", "AIzaSyBKDOjEk3pHQDUGhPMRdD46oLKGK6xHAXM")
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
