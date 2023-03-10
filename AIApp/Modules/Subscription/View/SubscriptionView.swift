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
        
        let terms = Style("terms")
            .foregroundColor(.white.withAlphaComponent(0.4), .normal)
            .foregroundColor(.white.withAlphaComponent(0.4), .highlighted)
        
        let privacy = Style("privacy")
            .foregroundColor(.white.withAlphaComponent(0.4), .normal)
            .foregroundColor(.white.withAlphaComponent(0.4), .highlighted)
        
        let support = Style("support")
            .foregroundColor(.white.withAlphaComponent(0.4), .normal)
            .foregroundColor(.white.withAlphaComponent(0.4), .highlighted)
        
        label.attributedText = R.string.localizable.subscriptionPrivacy().style(tags: [all, terms, privacy, support])
        
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
    
    lazy var advatageStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            SubAdvantageView(label: R.string.localizable.subscriptionFirstAdvatage(), imageTint: .init(hex6: 0x70E99F)),
            SubAdvantageView(label: R.string.localizable.subscriptionSecondAdvatage(), imageTint: .init(hex6: 0x70E99F)),
            SubAdvantageView(label: R.string.localizable.subscriptionThirdAdvatage(), imageTint: .init(hex6: 0x70E99F)),
            SubAdvantageView(label: R.string.localizable.subscriptionFourthAdvatage(), imageTint: .init(hex6: 0x70E99F))
        ])
        view.distribution = .fillEqually
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    let priceLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.textAlignment = .center
        
        let price = Style("price")
            .foregroundColor(.white)
            .font(.satoshiFont(ofSize: 18, weight: .bold))
        
        label.attributedText = R.string.localizable.subscriptionPrice("$4.99 / per month").style(tags: [price])
        
        return label
    }()
    
    let priceSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.4)
        label.font = .interFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.text = R.string.localizable.subscriptionPriceSubtitle()
        
        return label
    }()
    
    let trialEnableView: TrialEnableView = {
        let view = TrialEnableView()
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(closeButton)
        addSubview(restoreButton)
        addSubview(privacyLabel)
        addSubview(buttonGradientView)
        addSubview(continueButton)
        addSubview(titleLabel)
        addSubview(advatageStack)
        addSubview(priceLabel)
        addSubview(priceSubtitleLabel)
        addSubview(trialEnableView)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if buttonGradientView.bounds != .zero && !isGradientDidSet {
            setGradientBorder()
        }
    }
        
    private func setGradientBorder() {
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
        
        advatageStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(40.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(advatageStack.snp.bottom).offset(48.0)
        }
        
        priceSubtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(2.0)
        }
        
        trialEnableView.snp.makeConstraints { make in
            make.top.equalTo(priceSubtitleLabel.snp.bottom).offset(24.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(78.0)
        }
    }
}
