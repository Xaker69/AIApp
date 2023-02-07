import UIKit

class UploadingBottomView: RootView {

    var isGradientDidSet: Bool = false
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.uploadingContinue(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        
        return button
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        layer.cornerRadius = 25
        layer.cornerCurve = .continuous
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(continueButton)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds != .zero && !isGradientDidSet {
            setupShadow()
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
    
    private func setupConstraints() {
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
        }
    }

}
