#import "WatchPlugin.h"
#if __has_include(<watch_plugin/watch_plugin-Swift.h>)
#import <watch_plugin/watch_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "watch_plugin-Swift.h"
#endif

@implementation WatchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWatchPlugin registerWithRegistrar:registrar];
}
@end
