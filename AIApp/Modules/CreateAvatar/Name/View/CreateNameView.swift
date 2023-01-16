import UIKit

class CreateNameView: RootView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.createAvatarStep("3")
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.createNameTitle()
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.createNameButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white.withAlphaComponent(0.1)
        
        return button
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.font = .satoshiFont(ofSize: 24, weight: .black)
        field.tintColor = .init(hex6: 0xA851FF)
        field.textAlignment = .center
        field.textColor = .white
        field.keyboardAppearance = .dark
        
        return field
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(backButton)
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(continueButton)
        addSubview(textField)
        
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
        
        continueButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
        }
        
        textField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(65.0)
            make.height.equalTo(35.0)
        }
    }

}
