import UIKit

class ChoosePackViewController: UIViewController {

    var mainView: ChoosePackView {
        return view as! ChoosePackView
    }
    
    override func loadView() {
        view = ChoosePackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func continueButtonTapped() {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
