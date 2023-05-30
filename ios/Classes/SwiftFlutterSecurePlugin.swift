import Flutter
import UIKit
import DTTJailbreakDetection

public class SwiftFlutterSecurePlugin: NSObject, FlutterPlugin, FlutterSecurePlatformAPI {
    
    func isRooted() throws -> Bool {
        return DTTJailbreakDetection.isJailbroken()
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let messenger = registrar.messenger()
        let api = SwiftFlutterSecurePlugin()
        FlutterSecurePlatformAPISetup.setUp(binaryMessenger: messenger, api: api);
        
    }
}
