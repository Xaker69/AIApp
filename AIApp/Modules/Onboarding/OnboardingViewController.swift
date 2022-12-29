import UIKit

class OnboardingViewController: UIViewController {

    var mainView: OnboardingView {
        return view as! OnboardingView
    }
    
    override func loadView() {
        view = OnboardingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}
