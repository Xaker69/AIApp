import UIKit

class SubscriptionViewController: UIViewController {
    
    var mainView: SubscriptionView {
        return view as! SubscriptionView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = SubscriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
