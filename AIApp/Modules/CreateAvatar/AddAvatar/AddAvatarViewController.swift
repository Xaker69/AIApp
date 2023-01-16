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

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentSubscriptionVC()
    }
    
    @objc private func addButtonTapped() {
        let vc = UploadPhotosViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func presentSubscriptionVC() {
        let vc = SubscriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
}
