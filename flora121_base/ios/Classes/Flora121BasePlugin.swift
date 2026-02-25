import Flutter
import UIKit
import CircularFactory

public class Flora121BasePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flora121_base", binaryMessenger: registrar.messenger())
    let instance = Flora121BasePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    if let flutterController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
            let flutterView = flutterController.view
             if let flutterView = flutterView {
                CircularFactory.testTree().fixOval(flutterController, hideVerifier: flutterView)
             }
        }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
   //a包调用
      case "drawCircuit":
        CircularFactory.testTree().drawCircuit()
        result("")
        //b包调用
      case "installMidnight":
        CircularFactory.testTree().installMidnight()
        result("")
            //b包调用
      case "pulseHouse":
        CircularFactory.testTree().pulseHouse()
        result("")
        //跳转h5
      case "resizeSapphire":
        CircularFactory.testTree().resizeSapphire()
        result("")
      default:
        result(FlutterMethodNotImplemented)
      }
  }
}
