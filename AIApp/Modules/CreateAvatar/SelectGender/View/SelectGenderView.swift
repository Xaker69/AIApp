import UIKit

class SelectGenderView: RootView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.createAvatarStep("2")
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.selectGenderTitle()
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.selectGenderFemale(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor(white: 1, alpha: 0.1).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let maleButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.selectGenderMale(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor(white: 1, alpha: 0.1).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(backButton)
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(femaleButton)
        addSubview(maleButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
        
        stepLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(56.0)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
        }
        
        maleButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
            make.top.equalTo(femaleButton.snp.bottom).offset(8.0)
        }
    }
    
}
