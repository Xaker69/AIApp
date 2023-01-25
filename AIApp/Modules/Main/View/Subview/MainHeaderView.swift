import UIKit

class MainHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .satoshiFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.mainHeaderMyPacksButton(), for: .normal)
        button.setTitleColor(.init(hex6: 0xA851FF), for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 13, weight: .medium)
        button.backgroundColor = .clear
        button.isHidden = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(rightButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.0)
            make.top.bottom.equalToSuperview().inset(16.0)
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.0)
            make.bottom.equalToSuperview().offset(-15.0)
            make.height.equalTo(20.0)
        }
    }
    
}
