import UIKit

class ManageView: RootView {

    let headerView: UIView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.settingsManageData()
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.settingsRemoveData(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x101010)
        
        addSubview(headerView)
        addSubview(removeButton)
        addSubview(separatorView)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(backButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.0)
            make.left.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(-16.0)
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(60.0)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(removeButton.snp.bottom)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(1.0)
        }
    }
    
}
