import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   let factory = AirPlayViewFactory(messenger: registrar(forPlugin: "airplay_view")!.messenger())
   registrar(forPlugin: "airplay_view")!.register(factory, withId: "airplay_view")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

}
