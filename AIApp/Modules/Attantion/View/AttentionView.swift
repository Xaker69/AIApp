import UIKit
import Atributika

class AttentionView: RootView {
    
    let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        
        return view
    }()
    
    let containerView = UIView()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.attentionGrantedImage()
        
        return view
    }()
    
    let titleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 0.99
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .font(.satoshiFont(ofSize: 24, weight: .bold))
            .foregroundColor(.white)
        
        let text = "Your photos are\nbeing processed"
        label.attributedText = text.styleAll(style)
        
        return label
    }()
    
    let subtitleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.32
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .font(.interFont(ofSize: 15, weight: .medium))
            .foregroundColor(.init(white: 1, alpha: 0.6))
        
        label.attributedText = R.string.localizable.attentionDeniedSubtitle().styleAll(style)
        
        return label
    }()
    
    let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Okay", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 48/2
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 32, bottom: 14, right: 32)
        
        return button
    }()
    
    let secondaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.attentionSecondaryButton(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 13, weight: .semiBold)
        button.backgroundColor = .clear
        
        return button
    }()
    
    override func setup() {
        addSubview(blurView)
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(mainButton)
        containerView.addSubview(secondaryButton)
        
        setupConstraints()
    }
    
    func setupContent(isGranted: Bool) {
        let subtitle = isGranted ?
        R.string.localizable.attentionGrantedSubtitle() :
        R.string.localizable.attentionDeniedSubtitle()
        
        let mainButtonTitle = isGranted ?
        R.string.localizable.attentionGrantedButton() :
        R.string.localizable.attentionDeniedButton()
        
        let image = isGranted ?
        R.image.attentionGrantedImage() :
        R.image.attentionNotGrantedImage()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.32
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .font(.interFont(ofSize: 15, weight: .medium))
            .foregroundColor(.init(white: 1, alpha: 0.6))
        
        subtitleLabel.attributedText = subtitle.styleAll(style)
        secondaryButton.isHidden = isGranted
        mainButton.setTitle(mainButtonTitle, for: .normal)
        imageView.image = image
        
        if isGranted {
            secondaryButton.removeFromSuperview()
            mainButton.snp.makeConstraints { make in
                make.top.equalTo(subtitleLabel.snp.bottom).offset(24.0)
                make.height.equalTo(48.0)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        } else {
            mainButton.snp.makeConstraints { make in
                make.top.equalTo(subtitleLabel.snp.bottom).offset(24.0)
                make.height.equalTo(48.0)
                make.centerX.equalToSuperview()
            }
            
            secondaryButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.height.equalTo(48.0)
                make.left.right.equalToSuperview().inset(90.0)
                make.top.equalTo(mainButton.snp.bottom).offset(8.0)
            }
        }
        
        layoutIfNeeded()
    }
    
    private func setupConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(64.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview().inset(40.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
        }
    }
}
