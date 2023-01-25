import UIKit
import Atributika

class PackDescriptionCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.choosePackCellTmp()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
//    let blurView: UIVisualEffectView = {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//
//        return view
//    }()
    
    let maskBlurView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.packDescFade()
        
        return view
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
    
    let descriptionLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.32
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .foregroundColor(.white)
            .font(.interFont(ofSize: 15, weight: .medium))
        
        let text = "Boost your job search or improve your business profile by creating high-quality photos for CV or LinkedIn.  Including the right photos in your resume can lead to a greater number of responses"
        
        label.attributedText = text.styleAll(style)
        
        return label
    }()
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            PackAdvantageView(image: R.image.packDescColorIcon(), label: "10 Different Angles"),
            PackAdvantageView(image: R.image.packDescNotebook(), label: "Perfect for CV"),
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillProportionally
        
        return view
    }()
    
    lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            PackAdvantageView(image: R.image.packDescFlash(), label: "Boost you job search")
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillProportionally

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        
//        imageView.addSubview(blurView)
        imageView.addSubview(maskBlurView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(picsCountContainer)
        
        picsCountContainer.addSubview(picsCountLabel)
        picsCountContainer.addSubview(picsCountImageView)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0.4)
//        gradient.endPoint = CGPoint(x: 0, y: 0.8)
//        gradient.frame = maskBlurView.bounds
//
//        maskBlurView.layer.mask = gradient
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
//        blurView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        maskBlurView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(49.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
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
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(imageView.snp.bottom).offset(16.0)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24.0)
            make.centerX.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
