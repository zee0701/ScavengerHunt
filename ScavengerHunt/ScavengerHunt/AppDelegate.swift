
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        return true
    }
    
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //connectToFcm()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //FIRMessaging.messaging().disconnect()
        //print("Disconnected from FCM.")
    }
    
}





