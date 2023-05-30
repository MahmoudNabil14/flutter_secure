import Flutter
import UIKit

public class SwiftFlutterSecurePlugin: NSObject, FlutterPlugin, FlutterSecurePlatformAPI {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let messenger = registrar.messenger()
        let api = SwiftFlutterSecurePlugin()
        FlutterSecurePlatformAPISetup.setUp(binaryMessenger: messenger, api: api);
        
    }
}
