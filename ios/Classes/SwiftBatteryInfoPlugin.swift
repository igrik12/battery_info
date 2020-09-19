import Flutter
import UIKit

//Describes the current charging state of the device battery
enum BatteryState {
  static let charging = "charging"
  static let discharging = "discharging"
}

//Custom error code for the responce
enum CustomFlutterErrorCode {
  static let unavailable = "UNAVAILABLE"
}
/*
Reponsible for the retrieval of the device battery charging state and level.
Supports both single API call and stream.
*/
public class SwiftBatteryInfoPlugin: NSObject, FlutterPlugin {
  let generator = BatteryInfoGenerator()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.igrik12.battery_info/channel", binaryMessenger: registrar.messenger())
    let instance = SwiftBatteryInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let eventChannel = FlutterEventChannel(name: "com.igrik12.battery_info/stream", binaryMessenger: registrar.messenger())                                                                                
    eventChannel.setStreamHandler(SwiftStreamHandler())
  }

  // Handles the API call from the flutter side through the Method Channel to retrive battery information (level and charging status)
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let batteryInfo = generator.generate()
    
    if let level = batteryInfo["batteryLevel"] as? Int{
      if(level < 0){
        result(FlutterError(
          code: CustomFlutterErrorCode.unavailable,
          message: "Battery level unavailable",
          details: nil))
      }
    }

    if let status = batteryInfo["batteryStatus"] as? String{
      if(status == CustomFlutterErrorCode.unavailable){
        result(FlutterError(
          code: CustomFlutterErrorCode.unavailable,
          message: "Battery status unavailable",
          details: nil))
      }
    }    
    result(batteryInfo)
  }
}

/*
Stream handler for the device battery information retrieval.
*/
class SwiftStreamHandler: NSObject, FlutterStreamHandler {
  let generator = BatteryInfoGenerator()
  var eventSink: FlutterEventSink?

  // Entry point for the stream subscription, pushing battery events to the stream sink
  public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = eventSink
    let batteryInfo = generator.generate()

    if let level = batteryInfo["batteryLevel"] as? Int{
      if(level < 0){
        eventSink(FlutterError(
          code: CustomFlutterErrorCode.unavailable,
          message: "Battery level unavailable",
          details: nil))
        return nil
      }
    }

    if let status = batteryInfo["batteryStatus"] as? String{
      if(status == CustomFlutterErrorCode.unavailable){
        eventSink(FlutterError(
          code: CustomFlutterErrorCode.unavailable,
          message: "Battery status unavailable",
          details: nil))
        return nil
      }
    }   

    eventSink(batteryInfo)
    return nil
  }

  /*
  Disposal of the stream sink resources
  */
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
} 

/*
  Responsible for the gereration of the battery information by calling UIDevice API 
*/
struct BatteryInfoGenerator{
    let device: UIDevice

    init(){
      device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
    }

    private func getBatteryState() -> String {
      switch device.batteryState {
        case .full:
          return BatteryState.charging
        case .charging:
          return BatteryState.charging
        case .unplugged:
          return BatteryState.discharging
        default:
          return CustomFlutterErrorCode.unavailable
        }
    }

    private func getBatteryLevel() -> Int {
      Int(device.batteryLevel * 100)
    }
    // Generates the battery information
    func generate() -> Dictionary<String, Any>{
      var batteryInfo: [String: Any] = [:]
      batteryInfo["batteryLevel"] = getBatteryLevel()
      batteryInfo["batteryStatus"] = getBatteryState()
      return batteryInfo
    }
}
