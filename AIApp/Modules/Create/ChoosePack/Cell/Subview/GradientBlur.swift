import UIKit

class GradientBlur: RootView {
        
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }()
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 0.3)
        layer.endPoint = CGPoint(x: 0, y: 0.7)
        
        return layer
    }()
    
    override func setup() {
        clipsToBounds = true
        layer.mask = gradientLayer
        
        addSubview(blurView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func setupConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
