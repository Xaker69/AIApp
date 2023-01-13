import UIKit

class TrialEnableView: RootView {

    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interFont(ofSize: 15, weight: .semiBold)
        label.textAlignment = .left
        label.text = R.string.localizable.subscriptionEnableTrialTitle()
        
        return label
    }()
    
    let secondaryTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.text = R.string.localizable.subscriptionEnableTrialSubtitle()
        
        return label
    }()
    
    lazy var textStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            mainTextLabel,
            secondaryTextLabel
        ])
        view.axis = .vertical
        view.spacing = 4.0
        view.distribution = .fill
        return view
    }()
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .init(hex6: 0xA851FF)
        switcher.tintColor = .white.withAlphaComponent(0.4)
        switcher.thumbTintColor = .white.withAlphaComponent(0.4)
        
        return switcher
    }()
    
    override func setup() {
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.withAlphaComponent(0.05).cgColor
        layer.cornerRadius = 12
        
        addSubview(textStack)
        addSubview(switcher)
        
        switcher.addTarget(self, action: #selector(switcherDidChanged), for: .valueChanged)
        
        setupConstraints()
    }
    
    @objc private func switcherDidChanged(_ sender: UISwitch) {
        if sender.isOn {
            secondaryTextLabel.isHidden = true
            mainTextLabel.text = R.string.localizable.subscriptionTrialEnabled()
            sender.thumbTintColor = .white
        } else {
            secondaryTextLabel.isHidden = false
            mainTextLabel.text = R.string.localizable.subscriptionEnableTrialTitle()
            switcher.thumbTintColor = .white.withAlphaComponent(0.4)
        }
    }
    
    private func setupConstraints() {
        textStack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.0)
            make.top.equalToSuperview().offset(15.0)
            make.bottom.equalToSuperview().offset(-15.0)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.height.equalTo(24.0)
        }
        
        secondaryTextLabel.snp.makeConstraints { make in
            make.height.equalTo(20.0)
        }
        
        switcher.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.0)
            make.centerY.equalToSuperview()
            make.left.equalTo(textStack.snp.right).offset(16.0)
        }
    }
    
}
