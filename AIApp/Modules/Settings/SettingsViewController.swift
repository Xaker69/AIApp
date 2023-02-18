import UIKit

class SettingsViewController: UIViewController {

    var mainView: SettingsView {
        return view as! SettingsView
    }
    
    var dataSource = [
        SettingsModel(type: .restore),
        SettingsModel(type: .feedback),
        SettingsModel(type: .privacy),
        SettingsModel(type: .terms),
        SettingsModel(type: .manage)
    ]
    
    override func loadView() {
        view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        mainView.versionLabel.text = R.string.localizable.settingsVersion(version, build)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func handleSelection(cell type: SettingsModel.SettingType) {
        switch type {
        case .manage:
            navigationController?.pushViewController(ManageViewController(), animated: true)
            
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.description(), for: indexPath) as! SettingsCell
        
        cell.iconImageView.image = dataSource[indexPath.row].image
        cell.titleLabel.text = dataSource[indexPath.row].title
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        handleSelection(cell: dataSource[indexPath.row].type)
    }    
}
