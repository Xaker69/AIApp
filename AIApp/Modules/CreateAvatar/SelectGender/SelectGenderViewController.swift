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
        mainView.femaleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDown)
        mainView.femaleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDragOutside)
        mainView.femaleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDragInside)
        
        mainView.maleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        mainView.maleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDown)
        mainView.maleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDragOutside)
        mainView.maleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchDragInside)
    }
    
    // MARK: - Private actions

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func genderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15) {
            sender.layer.borderColor = UIColor(white: 1, alpha: 0.1).cgColor
        }
        
        let vc = CreateNameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func genderButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15) {
            if sender.isHighlighted {
                sender.layer.borderColor = UIColor.white.cgColor
            } else {
                sender.layer.borderColor = UIColor(white: 1, alpha: 0.1).cgColor
            }
        }
    }
}
