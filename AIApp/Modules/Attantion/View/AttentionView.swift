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
        view.image = R.image.attentionProcessed()
        
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
        
        let text = "It may take about 15-20 minutes. We'll send a notification when it's done"
        label.attributedText = text.styleAll(style)
        
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
    
    override func setup() {
        addSubview(blurView)
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(mainButton)
        
        setupConstraints()
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
        
        mainButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24.0)
            make.height.equalTo(48.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
