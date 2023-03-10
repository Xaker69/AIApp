import UIKit
import Atributika

class MySinglePackCell: UICollectionViewCell {
    
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex6: 0x2F2F2F)
        
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex6: 0x4D4D4D)
        
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .init(hex6: 0x272727)
        view.clipsToBounds = true
        
        return view
    }()
    
    let gradientImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.mySinglePackGradient()
        
        return view
    }()
    
    let titleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .font(.satoshiFont(ofSize: 15, weight: .bold))
            .foregroundColor(.white)
            
        label.attributedText = "Oil Painting".styleAll(style)
        
        return label
    }()
    
    let generatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Generating..."
        label.font = .interFont(ofSize: 13, weight: .semiBold)
        label.textColor = .white
        label.isHidden = true
        
        return label
    }()
    
    let generatingImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.mySinglePackGenerating()
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(firstView)
        contentView.addSubview(secondView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.addSubview(gradientImageView)
        imageView.addSubview(generatingLabel)
        imageView.addSubview(generatingImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        paragraphStyle.alignment = .center
        
        let style = Style()
            .paragraphStyle(paragraphStyle)
            .font(.satoshiFont(ofSize: 15, weight: .bold))
            .foregroundColor(.white)
        
        titleLabel.attributedText = text.styleAll(style)
    }
    
    private func setupConstraints() {
        firstView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(4.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom)
            make.height.equalTo(4.0)
            make.left.right.equalToSuperview().inset(8.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(secondView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16.0)
            make.left.right.equalToSuperview().inset(12.0)
        }

        gradientImageView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        generatingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(generatingImageView.snp.centerY)
            make.left.equalTo(generatingImageView.snp.right).offset(8.0)
        }
        
        generatingImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.0)
            make.top.equalToSuperview().offset(10.0)
            make.size.equalTo(16.0)
        }
    }
    
}
