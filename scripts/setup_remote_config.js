#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🔧 Configurando Firebase Remote Config...\n');

// Verificar si Firebase CLI está instalado
try {
  execSync('firebase --version', { stdio: 'pipe' });
} catch (error) {
  console.error('❌ Firebase CLI no está instalado.');
  console.log('📦 Instálalo con: npm install -g firebase-tools');
  process.exit(1);
}

// Verificar si el usuario está logueado
try {
  execSync('firebase projects:list', { stdio: 'pipe' });
} catch (error) {
  console.log('🔐 Iniciando sesión en Firebase...');
  try {
    execSync('firebase login', { stdio: 'inherit' });
  } catch (loginError) {
    console.error('❌ Error al iniciar sesión en Firebase');
    process.exit(1);
  }
}

// Obtener la configuración actual
console.log('📥 Obteniendo configuración actual...');
try {
  execSync('firebase remoteconfig:get > remote-config.json', { stdio: 'pipe' });
} catch (error) {
  console.log('📝 Creando configuración inicial...');
  
  // Crear configuración inicial
  const initialConfig = {
    conditions: [
      {
        name: "Default",
        expression: "true",
        tagColor: "BLUE"
      }
    ],
    parameters: {
      google_maps_api_key: {
        defaultValue: {
          value: "YOUR_GOOGLE_MAPS_API_KEY_HERE"
        },
        description: "API Key para Google Maps iOS"
      },
      api_base_url: {
        defaultValue: {
          value: "https://api.gymnestic.com"
        },
        description: "URL base de la API"
      },
      enable_crashlytics: {
        defaultValue: {
          value: "true"
        },
        description: "Habilitar Crashlytics"
      },
      enable_analytics: {
        defaultValue: {
          value: "true"
        },
        description: "Habilitar Analytics"
      },
      min_app_version: {
        defaultValue: {
          value: "1.0.0"
        },
        description: "Versión mínima de la app"
      },
      force_update: {
        defaultValue: {
          value: "false"
        },
        description: "Forzar actualización"
      },
      maintenance_mode: {
        defaultValue: {
          value: "false"
        },
        description: "Modo mantenimiento"
      },
      maintenance_message: {
        defaultValue: {
          value: "La aplicación está en mantenimiento. Inténtalo más tarde."
        },
        description: "Mensaje de mantenimiento"
      },
      feature_flags_enable_nutrition_tracking: {
        defaultValue: {
          value: "true"
        },
        description: "Habilitar seguimiento nutricional"
      },
      feature_flags_enable_social_features: {
        defaultValue: {
          value: "false"
        },
        description: "Habilitar características sociales"
      },
      feature_flags_enable_premium_features: {
        defaultValue: {
          value: "true"
        },
        description: "Habilitar características premium"
      },
      feature_flags_enable_trainer_chat: {
        defaultValue: {
          value: "false"
        },
        description: "Habilitar chat con entrenador"
      },
      feature_flags_enable_workout_sharing: {
        defaultValue: {
          value: "true"
        },
        description: "Habilitar compartir entrenamientos"
      },
      api_timeouts_connect_timeout: {
        defaultValue: {
          value: "30000"
        },
        description: "Timeout de conexión (ms)"
      },
      api_timeouts_receive_timeout: {
        defaultValue: {
          value: "30000"
        },
        description: "Timeout de recepción (ms)"
      },
      api_timeouts_send_timeout: {
        defaultValue: {
          value: "30000"
        },
        description: "Timeout de envío (ms)"
      },
      ui_settings_show_onboarding: {
        defaultValue: {
          value: "true"
        },
        description: "Mostrar onboarding"
      },
      ui_settings_max_trainers_per_page: {
        defaultValue: {
          value: "20"
        },
        description: "Máximo de entrenadores por página"
      },
      ui_settings_enable_dark_theme_only: {
        defaultValue: {
          value: "true"
        },
        description: "Solo tema oscuro"
      },
      subscription_settings_trial_period_days: {
        defaultValue: {
          value: "7"
        },
        description: "Días de período de prueba"
      },
      subscription_settings_show_premium_banner: {
        defaultValue: {
          value: "true"
        },
        description: "Mostrar banner premium"
      },
      subscription_settings_premium_features_preview: {
        defaultValue: {
          value: "true"
        },
        description: "Vista previa de características premium"
      }
    },
    version: {
      versionNumber: "1",
      updateTime: new Date().toISOString(),
      updateUser: {
        email: "script@example.com"
      },
      updateOrigin: "CONSOLE",
      updateType: "INCREMENTAL_UPDATE"
    }
  };
  
  fs.writeFileSync('remote-config.json', JSON.stringify(initialConfig, null, 2));
}

// Leer la configuración
const configPath = path.join(process.cwd(), 'remote-config.json');
let config;

try {
  config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
} catch (error) {
  console.error('❌ Error al leer remote-config.json');
  process.exit(1);
}

// Solicitar API key
const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('🔑 Ingresa tu Google Maps API Key: ', (apiKey) => {
  if (!apiKey || apiKey.trim() === '') {
    console.log('⚠️ No se proporcionó API key. Usando placeholder.');
    apiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';
  }

  // Actualizar la API key
  if (!config.parameters) {
    config.parameters = {};
  }
  
  config.parameters.google_maps_api_key = {
    defaultValue: {
      value: apiKey.trim()
    },
    description: "API Key para Google Maps iOS"
  };

  // Incrementar versión
  if (config.version) {
    config.version.versionNumber = String(parseInt(config.version.versionNumber) + 1);
    config.version.updateTime = new Date().toISOString();
  }

  // Guardar configuración actualizada
  fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
  console.log('💾 Configuración guardada en remote-config.json');

  // Mostrar instrucciones para configuración manual
  console.log('\n📋 Configuración de Firebase Remote Config:');
  console.log('==============================================');
  console.log('1. Ve a [Firebase Console](https://console.firebase.google.com/)');
  console.log('2. Selecciona tu proyecto');
  console.log('3. Ve a Engage > Remote Config');
  console.log('4. Haz clic en "Add your first parameter" o "+"');
  console.log('5. Configura el parámetro:');
  console.log('   - Parameter key: google_maps_api_key');
  console.log('   - Default value: ' + apiKey.trim());
  console.log('   - Description: API Key para Google Maps iOS');
  console.log('6. Haz clic en "Publish changes"');
  console.log('');
  console.log('🔑 Tu API Key: ' + apiKey.trim());
  console.log('');
  console.log('📱 Después de configurar, ejecuta la app para probar Google Maps');
  console.log('');

  // Limpiar archivo temporal
  try {
    fs.unlinkSync(configPath);
    console.log('🧹 Archivo temporal eliminado');
  } catch (error) {
    console.log('⚠️ No se pudo eliminar el archivo temporal');
  }

  console.log('\n🎉 Configuración completada!');
  console.log('📱 Ejecuta la app para probar Google Maps');
  
  rl.close();
}); 