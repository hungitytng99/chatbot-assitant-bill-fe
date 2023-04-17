import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        downLoadFile()
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func downLoadFile() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "path_folder_download_plugin_flutter",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if(call.method == "downLoadFile"){
                if let args = call.arguments as? Dictionary<String, Any>,
                   let url = args["url"] as? String {
                    let myWebsite = URL(string: url)
                    let file = NSData(contentsOf: myWebsite!)
                    let activityViewController = UIActivityViewController(activityItems: [file!], applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.window?.rootViewController?.view
                    controller.present(activityViewController, animated: true, completion: nil)
                    activityViewController.resignFirstResponder()
                    result(100)
                } else {
                    result(FlutterError.init(code: "bad args", message: nil, details: nil))
                }
            }
        })
    }
    
}
