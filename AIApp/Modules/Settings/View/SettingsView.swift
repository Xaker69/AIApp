import UIKit

class SettingsView: RootView {

    let headerView: UIView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.settingsTitle()
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.close(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.description())
        view.backgroundColor = .clear
        view.separatorStyle = .none
        
        return view
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .interFont(ofSize: 15, weight: .regular)
        label.textColor = .init(white: 1, alpha: 0.4)
        
        return label
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x101010)
        
        addSubview(headerView)
        addSubview(tableView)
        addSubview(versionLabel)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(closeButton)
        
        setupConstraints()
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.0)
            make.left.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(-16.0)
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(65*5)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(20.0)
        }
    }
}
