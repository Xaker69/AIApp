import UIKit

class SubAdvantageView: RootView {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.subStar()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        
        return label
    }()
    
    init(label text: String) {
        super.init(frame: .zero)
        
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
