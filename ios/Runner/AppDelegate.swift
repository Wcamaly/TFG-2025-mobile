import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // CRÍTICO: Configurar Google Maps API Key antes de registrar plugins
    // Usar la API key desde Info.plist que se configura con variables de entorno
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String {
      print("🗺️ iOS: Configurando Google Maps con API Key: \(String(apiKey.prefix(10)))...")
      GMSServices.provideAPIKey(apiKey)
    } else {
      print("❌ iOS: No se pudo obtener la API Key de Google Maps desde Info.plist")
      print("❌ iOS: Verifica que GOOGLE_MAPS_API_KEY esté configurada en las variables de entorno")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
