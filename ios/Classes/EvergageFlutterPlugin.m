#import "EvergageFlutterPlugin.h"
#if __has_include(<evergage_flutter/evergage_flutter-Swift.h>)
#import <evergage_flutter/evergage_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "evergage_flutter-Swift.h"
#endif

@implementation EvergageFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEvergageFlutterPlugin registerWithRegistrar:registrar];
}
@end
