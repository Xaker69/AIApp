import UIKit
import FirebaseCore
import FirebaseFirestore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.registerForRemoteNotifications()
        FirebaseApp.configure()
        
        CloudManager.shared.loadPacks()
        
        let rootVC: UIViewController
        if UserManager.shared.users.count > 0 {
            rootVC = MainViewController()
        } else {
            rootVC = OnboardingViewController()
        }
              
        let navVC = RootNavigationController.shared
        navVC.setViewControllers([rootVC], animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let apnsDeviceToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        UserSettings.deviceToken = apnsDeviceToken
        print("💙 Device token:", apnsDeviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❤️ fail to register remote notification error: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        
        print("💙 didReceiveRemoteNotification userInfo \(userInfo)")
        
        return .noData
    }

}
