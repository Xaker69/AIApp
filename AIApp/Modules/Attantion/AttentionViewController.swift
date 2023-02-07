import UIKit

class AttentionViewController: UIViewController {
    
    var dismissCompletion: (() -> ())?
    
    var mainView: AttentionView {
        return view as! AttentionView
    }
    
    override func loadView() {
        view = AttentionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        mainView.secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.mainView.setupContent(isGranted: settings.authorizationStatus == .authorized)
            }
        }
    }
    
    @objc private func mainButtonTapped() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(appSettings)
                    }
                }
                
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
                    self.closeScreen()
                }
                
            default:
                self.closeScreen()
            }
        }
    }
    
    @objc private func secondaryButtonTapped() {
        closeScreen()
    }
    
    private func closeScreen() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.dismissCompletion?()
            }
        }
    }
    
}
