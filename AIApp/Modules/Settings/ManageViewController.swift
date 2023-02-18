import UIKit

class ManageViewController: UIViewController {

    var mainView: ManageView {
        return view as! ManageView
    }
    
    override func loadView() {
        view = ManageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func removeButtonTapped() {
        let alert = UIAlertController(title: "Do you want to delete all data? ", message: "This action cannot be undone. You’ll be logged out and your subscription will stay active", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Yes, delete all my data", style: .destructive) { [weak self] _ in
            UserManager.shared.deleteAllUsers()
            
            let vc = OnboardingViewController()
            RootNavigationController.shared.setViewControllers([vc], animated: false)
            self?.navigationController?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
