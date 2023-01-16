import UIKit

class CreateNameViewController: UIViewController {

    var mainView: CreateNameView {
        return view as! CreateNameView
    }
    
    override func loadView() {
        view = CreateNameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.textField.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
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
    
}
