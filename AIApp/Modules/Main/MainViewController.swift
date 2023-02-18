import UIKit
import IGListKit

class MainViewController: UIViewController {

    var profileModel: ProfilesModel!
    
    var mainView: MainView {
        return view as! MainView
    }
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        profileModel = ProfilesModel(users: UserManager.shared.users)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
    }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        
        present(vc, animated: true)
    }
}

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            profileModel,
            MyPacksModel(name: "myPacks"),
            NewPacksModel(name: "morePacks")
        ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ProfilesModel:
            let section = ProfilesSection()
            section.delegate = self
            
            return section
            
        case is MyPacksModel:
            let section = MyPacksSection()
            section.delegate = self
            
            return section
            
        case is NewPacksModel:
            let section = NewPacksSection(headerType: .title)
            section.delegate = self
            
            return section
            
        default:
            preconditionFailure("Unknown object type")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}

// MARK: - NewPacksDelegate

extension MainViewController: NewPacksDelegate {
    func newPacks(getPack index: Int) {
        navigationController?.pushViewController(UploadingViewController(), animated: true)
    }
    
    func newPacks(didSelect index: Int) {
        navigationController?.pushViewController(PackDescriptionViewController(), animated: true)
    }
}

// MARK: - MyPacksDelegate

extension MainViewController: MyPacksDelegate {
    func myPacks(_ section: MyPacksSection, didSelect packIndex: Int) {
        let vc = AllGeneratedPhotosViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}

// MARK: - ProfileSectionDelegate

extension MainViewController: ProfileSectionDelegate {
    func profileSection(_ controller: ProfilesSection, didSelect user: User?) {
        if let user = user {
            UserManager.shared.selectUser(user: user)
            adapter.reloadData()
        } else {
            navigationController?.pushViewController(AddAvatarViewController(), animated: true)
        }
    }
}
