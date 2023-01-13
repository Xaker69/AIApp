import UIKit

class AddAvatarView: RootView {
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.text = R.string.localizable.addAvatarTitle()
        label.textAlignment = .center
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .interFont(ofSize: 15, weight: .medium)
        label.text = R.string.localizable.addAvatarSubtitle()
        label.textAlignment = .center
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.addButton(), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    override func setup() {
       
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(addButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(96.0)
            make.left.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(96.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(136.0)
        }
    }

}
