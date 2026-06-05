import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let screenTimeChannel = FlutterMethodChannel(name: "com.focuslock.focus_lock/screentime",
                                              binaryMessenger: controller.binaryMessenger)
    
    if #available(iOS 16.0, *) {
        ScreenTimeManager.shared.methodChannel = screenTimeChannel
        
        screenTimeChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          if call.method == "requestAuthorization" {
              ScreenTimeManager.shared.requestAuthorization()
              result(true)
          } else {
              result(FlutterMethodNotImplemented)
          }
        })
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
