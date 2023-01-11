import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SubscriptionViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

