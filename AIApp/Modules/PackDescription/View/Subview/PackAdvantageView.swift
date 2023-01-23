import UIKit

class PackAdvantageView: RootView {

    let imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    init(image: UIImage?, label text: String) {
        super.init(frame: .zero)
        
        imageView.image = image
        titleLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    override func setup() {
        backgroundColor = .clear
        layer.borderColor = UIColor.init(hex6: 0x272727).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 24.0
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(16.0)
            make.left.top.bottom.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
    
}
