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
    // La API key debe ser la misma que tienes en Firebase Remote Config
    if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
       let plist = NSDictionary(contentsOfFile: path),
       let apiKey = plist["API_KEY"] as? String {
      GMSServices.provideAPIKey(apiKey)
    } else {
      // Fallback: usar API key hardcodeada temporalmente
      // REEMPLAZA CON TU API KEY REAL - la misma de Firebase Remote Config
      GMSServices.provideAPIKey("AIzaSyBKDOjEk3pHQDUGhPMRdD46oLKGK6xHAXM")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
