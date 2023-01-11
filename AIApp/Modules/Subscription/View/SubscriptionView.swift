import UIKit
import Atributika

class SubscriptionView: RootView {

    var isGradientDidSet: Bool = false
    let buttonGradientView = UIView()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.close(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.subscriptionRestore(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .clear
        
        return button
    }()
        
    let privacyLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.textAlignment = .center
        
        let all = Style("all")
            .foregroundColor(.white.withAlphaComponent(0.4))
            .font(.interFont(ofSize: 12, weight: .medium))
        
        label.attributedText = R.string.localizable.subscriptionPrivacy().style(tags: [all, Style("privacy"), Style("privacy"), Style("support")])
        
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.subscriptionContinue(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 11
        button.layer.cornerCurve = .continuous
        button.backgroundColor = .white
        
        return button
    }()
    
    let titleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.01
        
        let all = Style("all")
            .font(.satoshiFont(ofSize: 24, weight: .bold))
            .foregroundColor(.white)
            .paragraphStyle(paragraphStyle)
        
        let color = Style("color")
            .foregroundColor(.init(hex6: 0xA851FF))
        
        label.attributedText = R.string.localizable.subscriptionTitle().style(tags: [color, all])
        
        return label
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(closeButton)
        addSubview(restoreButton)
        addSubview(privacyLabel)
        addSubview(buttonGradientView)
        addSubview(continueButton)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if buttonGradientView.bounds != .zero && !isGradientDidSet {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.init(hex6: 0x6495FF).cgColor,
                UIColor.init(hex6: 0xC53EF4).cgColor,
                UIColor.init(hex6: 0xFFA94B).cgColor,
                UIColor.init(hex6: 0xFBD066).cgColor
            ]
            gradientLayer.frame = buttonGradientView.bounds
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.cornerRadius = 13
            gradientLayer.cornerCurve = .continuous

            buttonGradientView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
        
    func setGradientBorder(for view: UIView, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20.0)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-40.0)
            make.left.right.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.bottom.equalTo(privacyLabel.snp.top).offset(-29.0)
            make.height.equalTo(58.0)
        }
        
        buttonGradientView.snp.makeConstraints { make in
            make.center.equalTo(continueButton.snp.center)
            make.left.right.equalToSuperview().inset(17.0)
            make.height.equalTo(58.0 + 6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(60.0)
            make.left.right.equalToSuperview()
        }
    }
}
