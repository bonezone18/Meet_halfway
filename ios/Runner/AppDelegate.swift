import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Key comes from ios/Flutter/Secrets.xcconfig via Info.plist (see Secrets.xcconfig.example).
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPIKey") as? String,
       !apiKey.isEmpty, !apiKey.hasPrefix("$(") {
      GMSServices.provideAPIKey(apiKey)
    } else {
      assertionFailure("GoogleMapsAPIKey missing: create ios/Flutter/Secrets.xcconfig")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
