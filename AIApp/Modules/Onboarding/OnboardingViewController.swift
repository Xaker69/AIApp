import UIKit
import Kingfisher

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
    
    private func loadImage() {
        CloudManager.shared.getImageUrl(for: .onboardingImage) { [weak self] url in
            self?.mainView.imageView.kf.setImage(with: url, placeholder: R.image.onboardingTest())
        }
    }
}
