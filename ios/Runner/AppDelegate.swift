import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
GeneratedPluginRegistrant.register(with: self)
GMSServices.provideAPIKey("AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA")
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}