import UIKit

class AddAvatarViewController: UIViewController {

    var mainView: AddAvatarView {
        return view as! AddAvatarView
    }
    
    override func loadView() {
        view = AddAvatarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
