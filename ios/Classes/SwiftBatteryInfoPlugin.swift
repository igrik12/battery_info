import Flutter
import UIKit

public class SwiftBatteryInfoPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.igrik12.battery_info/channel", binaryMessenger: registrar.messenger())
    
    let eventChannel = FlutterEventChannel(name: "com.igrik12.battery_info/stream", binaryMessenger: messenger!)                                                                                
    eventChannel.setStreamHandler(SwiftBatteryInfoPlugin())

    let instance = SwiftBatteryInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
