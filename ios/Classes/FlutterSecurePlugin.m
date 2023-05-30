#import "FlutterSecurePlugin.h"
#if __has_include(<flutter_secure/flutter_secure-Swift.h>)
#import <flutter_secure/flutter_secure-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_secure-Swift.h"
#endif

@implementation FlutterSecurePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSecurePlugin registerWithRegistrar:registrar];
}
@end
