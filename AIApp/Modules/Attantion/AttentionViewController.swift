import UIKit

class AttentionViewController: UIViewController {

    var mainView: AttentionView {
        return view as! AttentionView
    }
    
    override func loadView() {
        view = AttentionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
    }
    
    @objc private func mainButtonTapped() {
        dismiss(animated: true)
    }
    
}
