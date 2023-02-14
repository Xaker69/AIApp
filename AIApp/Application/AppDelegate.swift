import UIKit
import FirebaseCore
import FirebaseFirestore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let rootVC: UIViewController
        if let persons = PersonManager.shared.getPersons(), persons.count > 0 {
            rootVC = MainViewController()
        } else {
            rootVC = OnboardingViewController()
        }
                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootNavigationController(rootViewController: UploadingViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let apnsDeviceToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("💙 Device token:", apnsDeviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        
        return .noData
    }

}

func randomColor() -> UIColor {
  let red = CGFloat.random(in: 0...1)
  let green = CGFloat.random(in: 0...1)
  let blue = CGFloat.random(in: 0...1)
  return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

