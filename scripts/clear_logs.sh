#!/bin/bash

# Script para limpiar logs de desarrollo y reiniciar la aplicación

echo "🧹 Clearing Flutter logs and cache..."

# Limpiar logs de Flutter
flutter logs --clear

# Limpiar cache de build
flutter clean

# Obtener dependencias
flutter pub get

# Reiniciar la aplicación
echo "🚀 Restarting application..."
flutter run --hot

echo "✅ Logs cleared and app restarted!" 