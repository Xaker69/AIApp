import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

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
        window?.rootViewController = RootNavigationController(rootViewController: UploadPhotosViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

func randomColor() -> UIColor {
  let red = CGFloat.random(in: 0...1)
  let green = CGFloat.random(in: 0...1)
  let blue = CGFloat.random(in: 0...1)
  return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

