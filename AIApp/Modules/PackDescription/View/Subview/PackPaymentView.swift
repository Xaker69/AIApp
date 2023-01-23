import UIKit
import Atributika
class PackPaymentView: RootView {
    
    var isGradientDidSet: Bool = false
    let buttonGradientView = UIView()
    
    let titleLabel: AttributedLabel = {
        let label = AttributedLabel()
        
        let strike = Style("strike")
            .strikethroughStyle(.single)
            .foregroundColor(.init(hex6: 0x6F6F6F))
            .font(.interFont(ofSize: 15, weight: .bold))
        
        let all = Style("all")
            .font(.interFont(ofSize: 15, weight: .bold))
            .foregroundColor(.white)
        
        label.attributedText = R.string.localizable.packDescriptionPayment().style(tags: [all, strike])
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.packDescPayment()
        
        return view
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.packDescriptionPaymentButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 11
        button.layer.cornerCurve = .continuous
        button.backgroundColor = .white
        
        return button
    }()
    
    lazy var textStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, imageView])
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillProportionally
        view.alignment = .center
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        layer.cornerRadius = 25
        layer.cornerCurve = .continuous
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(textStack)
        addSubview(buttonGradientView)
        addSubview(getButton)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if buttonGradientView.bounds != .zero && !isGradientDidSet {
            setupShadow()
            setGradientBorder()
        }
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = UIScreen.main.scale
        layer.masksToBounds = false
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
        textStack.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24.0)
        }
        
        getButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.bottom.equalTo(textStack.snp.top).offset(-24.0)
            make.height.equalTo(58.0)
            make.top.equalToSuperview().offset(16.0)
        }
        
        buttonGradientView.snp.makeConstraints { make in
            make.center.equalTo(getButton.snp.center)
            make.left.right.equalToSuperview().inset(17.0)
            make.height.equalTo(58.0 + 6)
        }
    }
}
