import UIKit

class SelectGenderViewController: UIViewController {

    var mainView: SelectGenderView {
        return view as! SelectGenderView
    }
    
    override func loadView() {
        view = SelectGenderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.femaleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        mainView.maleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private actions

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func genderButtonTapped(_ sender: UIButton) {
        mainView.maleButton.isSelected = false
        mainView.femaleButton.isSelected = false
        
        mainView.maleButton.titleLabel?.font = .interFont(ofSize: 15, weight: .medium)
        mainView.femaleButton.titleLabel?.font = .interFont(ofSize: 15, weight: .medium)
        
        sender.isSelected = true
        sender.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        
        let vc = CreateNameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
