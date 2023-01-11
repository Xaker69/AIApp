import UIKit
import SnapKit
import Atributika
import RswiftResources

class OnboardingView: RootView {

    let privacyLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        label.isEnabled = true
        label.isUserInteractionEnabled = true
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = .center
        
        let a = Style("terms")
            .underlineStyle(.single)
            .underlineColor(.white)
            .foregroundColor(.white, .normal)
            .foregroundColor(.white, .highlighted)
        
        let b = Style("privacy")
            .underlineStyle(.single)
            .underlineColor(.white)
            .foregroundColor(.white, .normal)
            .foregroundColor(.white, .highlighted)
        
        let all = Style("all")
            .paragraphStyle(paragraphStyle)
            .foregroundColor(.white.withAlphaComponent(0.4))
            .font(.interFont(ofSize: 11, weight: .medium))
        
        label.attributedText = R.string.localizable.onboardingPrivacy().style(tags: [all, a, b])
        
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.onboardingStartButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let subtitleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .foregroundColor(.white.withAlphaComponent(0.6))
            .font(.interFont(ofSize: 15, weight: .medium))
        
        label.attributedText = R.string.localizable.onboardingSubtitle().styleAll(style)
        
        return label
    }()
    
    let titleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.alignment = .center
        
        let color = Style("color")
            .foregroundColor(.init(hex6: 0xA851FF), .normal)
                
        let all = Style("all")
            .paragraphStyle(paragraphStyle)
            .foregroundColor(.white)
            .font(.satoshiFont(ofSize: 34, weight: .bold))
        
        label.attributedText = R.string.localizable.onboardingTitle().style(tags: [all, color])
        
        return label
    }()
    
    let poweredLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex6: 0x70E99F)
        label.text = R.string.localizable.onboardingPowered().uppercased()
        label.font = .interFont(ofSize: 11, weight: .extraBold)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 32
        view.contentMode = .scaleAspectFill
        view.image = R.image.onboardingTest()
        view.clipsToBounds = true
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(privacyLabel)
        addSubview(startButton)
        addSubview(subtitleLabel)
        addSubview(titleLabel)
        addSubview(poweredLabel)
        addSubview(imageView)
        
        setupContraints()
    }
    
    private func setupContraints() {
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        privacyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30.0)
            make.left.right.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(privacyLabel.snp.top).offset(-24.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(poweredLabel.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview()
        }
        
        poweredLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40.0)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4901477833)
        }
    }
    
}
