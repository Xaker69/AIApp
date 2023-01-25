import UIKit
import Atributika

class ChoosePackCell: UICollectionViewCell {
    
    let priceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .interFont(ofSize: 13, weight: .bold)
        label.text = "$10"
        label.textAlignment = .center
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.image.choosePackCellTmp()
        view.clipsToBounds = true
        
        return view
    }()
    
    let blurImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.image.choosePackCellBlur()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let subtitleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.6)
        label.text = "Increase the number of\nresponses to СV"
        label.font = .interFont(ofSize: 13, weight: .semiBold)
        label.numberOfLines = 0
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Business\nPhotos"
        label.font = .interFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    let picsCountContainer: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let picsCountImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.choosePackCellPics()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        
        return view
    }()
    
    let picsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interFont(ofSize: 11, weight: .semiBold)
        label.text = "100 pics"
        label.textAlignment = .left
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .clear
        
        addSubview(imageView)
        
        imageView.addSubview(blurImageView)
        imageView.addSubview(priceContainer)
        imageView.addSubview(subtitleLable)
        imageView.addSubview(titleLabel)
        imageView.addSubview(picsCountContainer)
        
        priceContainer.addSubview(priceLabel)
        
        picsCountContainer.addSubview(picsCountLabel)
        picsCountContainer.addSubview(picsCountImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupConstraints() {
        priceContainer.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(8.0)
            make.bottom.top.equalToSuperview().inset(6.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(4.0)
            make.right.equalToSuperview().offset(-4.0)
        }
        
        blurImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        subtitleLable.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40.0)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleLable.snp.top).offset(-4.0)
            make.left.right.equalToSuperview()
        }
        
        picsCountContainer.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        picsCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalTo(picsCountImageView.snp.right).offset(4.0)
            make.centerY.equalToSuperview()
        }
        
        picsCountImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(16.0)
        }
    }
}

class BlurGradientView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let darkBlurEffect = UIBlurEffect(style: .dark)
//        let darkBlurView = UIVisualEffectView(effect: darkBlurEffect)
//
//        addSubview(darkBlurView)
//
//        darkBlurView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Create a dark blur effect
//        let darkBlurEffect = UIBlurEffect(style: .dark)
//        // Create a clear blur effect
//        let clearBlurEffect = UIBlurEffect(style: .extraLight)
//
//        // Create the blur view and set its effect
//        let darkBlurView = UIVisualEffectView(effect: darkBlurEffect)
//        let clearBlurView = UIVisualEffectView(effect: clearBlurEffect)
//
//        // Add the blur view as a subview of your view
//        addSubview(darkBlurView)
//        addSubview(clearBlurView)
//
//         Create the gradient layer
        let gradientLayer = CAGradientLayer()
        
//         Set the colors for the gradient
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
//         Set the start and end points for the gradient
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
//         Add the gradient layer as a sublayer of your view
        layer.insertSublayer(gradientLayer, at: 0)
        
//         Set the frame for the gradient layer to be the same as the view
        gradientLayer.frame = bounds
    }
}
