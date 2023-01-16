import UIKit

class SubAdvantageView: RootView {

    enum ImageType {
        case green
        case red
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        
        return label
    }()
    
    init(type: ImageType = .green, label text: String, imageTint color: UIColor? = .green) {
        super.init(frame: .zero)
        
        titleLabel.text = text
    
        switch type {
        case .green:
            imageView.tintColor = color
            imageView.image = R.image.starGood()
            
        case .red:
            imageView.image = R.image.starBad()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    override func setup() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8.0)
            make.centerY.equalToSuperview()
        }
    }
}
