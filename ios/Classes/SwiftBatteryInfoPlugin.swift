import Flutter
import UIKit

public class SwiftBatteryInfoPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?

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

  public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = eventSink
    UIDevice.current.isBatteryMonitoringEnabled = true
    sendBatteryStateEvent()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(AppDelegate.onBatteryStateDidChange),
      name: UIDevice.batteryStateDidChangeNotification,
      object: nil)
    return nil
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    guard device.batteryState != .unknown  else {
      result(FlutterError(code: MyFlutterErrorCode.unavailable,
                          message: "Battery info unavailable",
                          details: nil))
      return
    }
    result(Int(device.batteryLevel * 100))
  }

  private func sendBatteryStateEvent() {
    guard let eventSink = eventSink else {
      return
    }

    switch UIDevice.current.batteryState {
    case .full:
      eventSink(BatteryState.charging)
    case .charging:
      eventSink(BatteryState.charging)
    case .unplugged:
      eventSink(BatteryState.discharging)
    default:
      eventSink(FlutterError(code: MyFlutterErrorCode.unavailable, message: "Charging status unavailable", details: nil))
    }
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self)
    eventSink = nil
    return nil
  }
}
