#import "BatteryInfoPlugin.h"
#if __has_include(<battery_info/battery_info-Swift.h>)
#import <battery_info/battery_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "battery_info-Swift.h"
#endif

@implementation BatteryInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBatteryInfoPlugin registerWithRegistrar:registrar];
}
@end
