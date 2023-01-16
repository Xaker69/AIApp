import UIKit
import SafariServices

class UploadPhotosViewController: UIViewController {

    var mainView: UploadPhotosView {
        return view as! UploadPhotosView
    }
    
    override func loadView() {
        view = UploadPhotosView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.boxButton.addTarget(self, action: #selector(boxButtonTapped), for: .touchUpInside)
        mainView.uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        
        setupClicablePrivacy()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func boxButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        mainView.uploadButton.isEnabled.toggle()
        
        mainView.uploadButton.alpha = mainView.uploadButton.isEnabled ? 1.0 : 0.1
    }
    
    @objc private func uploadButtonTapped() {
        let vc = SelectGenderViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupClicablePrivacy() {
        mainView.privacyLabel.onClick = { [weak self] label, detection in
            switch detection.type {
            case let .tag(tag):
                if let href = tag.attributes["href"], let url = URL(string: href) {
                    self?.present(SFSafariViewController(url: url), animated: true)
                }
            default:
                break
            }
        }
    }
    
}
