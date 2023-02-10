import UIKit

class CreateNameViewController: UIViewController {

    let selectedImages: [UIImage]
    let gender: String
    
    var mainView: CreateNameView {
        return view as! CreateNameView
    }
    
    init(selectedImages: [UIImage], gender: String) {
        self.selectedImages = selectedImages
        self.gender = gender
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CreateNameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.textField.delegate = self
        mainView.textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        mainView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.textField.becomeFirstResponder()
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardFrameChanged(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let rect = frame.cgRectValue
        let height = rect.height
        
        mainView.continueButton.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
            make.bottom.equalToSuperview().offset(-16 - height)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.layoutIfNeeded()
        }
    }
    
    @objc private func textFieldDidChanged(_ sender: UITextField) {
        if let count = sender.text?.count, count > 0 {
            mainView.continueButton.isEnabled = true
            
            UIView.animate(withDuration: 0.2) {
                self.mainView.continueButton.alpha = 1
            }
        } else {
            mainView.continueButton.isEnabled = false
            
            UIView.animate(withDuration: 0.2) {
                self.mainView.continueButton.alpha = 0.1
            }
        }
    }
    
    @objc private func continueButtonTapped() {
        let name = mainView.textField.text ?? ""
        PersonManager.shared.createPerson(images: selectedImages, gender: gender, name: name)
        
        let vc = ChoosePackViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private methods
    
}

// MARK: - UITextFieldDelegate

extension CreateNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        continueButtonTapped()
        return true
    }
}
