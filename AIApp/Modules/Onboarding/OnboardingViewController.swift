import UIKit
import Kingfisher
import Atributika
import SafariServices

class OnboardingViewController: UIViewController {

    var mainView: OnboardingView {
        return view as! OnboardingView
    }
    
    override func loadView() {
        view = OnboardingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        loadImage()
        setupClicablePrivacy()
    }
    
    // MARK: Private actions
    
    @objc private func startButtonTapped() {
        let vc = AddAvatarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Private methods
    
    private func loadImage() {
        PackManager.shared.getImageUrl(for: .onboardingImage) { [weak self] url in
            self?.mainView.imageView.kf.setImage(with: url, placeholder: R.image.onboardingTest())
        }
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
