import UIKit
import IGListKit

class MainViewController: UIViewController {

    var profileModel = ProfilesModel(users: UserManager.shared.users)
    var myPacksModel = MyPacksModel(user: UserManager.shared.selectedUser)
    var newPacksModel = CloudManager.shared.packs.enumerated().map { NewPacksModel(pack: $1, needHeader: $0 == 0) }
    
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
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(packsDidLoaded), name: .packsDidLoaded, object: nil)
    }
    
    @objc private func settingsButtonTapped() {
        let navVC = UINavigationController(rootViewController: SettingsViewController())
        navVC.navigationBar.isHidden = true
        
        present(navVC, animated: true)
    }
    
    //TODO: Нужно сделать метод который обновляет модели новых паков и своих паков и уже обновлять с анимацией мб
    
    @objc private func packsDidLoaded() {
        newPacksModel = CloudManager.shared.packs.enumerated().map { NewPacksModel(pack: $1, needHeader: $0 == 0) }
        adapter.reloadData()
    }
}

// MARK: - ListAdapterDataSource

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ListDiffable] = [profileModel]
        
        if !UserManager.shared.selectedUser.packs.isEmpty {
            objects.append(myPacksModel)
        }
        
        objects.append(contentsOf: newPacksModel)
        
        return objects
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
    
    func newPacks(didSelect pack: Pack) {
        let vc = PackDescriptionViewController(pack: pack)        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - MyPacksDelegate

extension MainViewController: MyPacksDelegate {
    func myPacks(_ section: MyPacksSection, didSelect pack: Pack) {
        let vc = AllGeneratedPhotosViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    func myPacks(needShowAllPacks section: MyPacksSection) {
        let navVc = RootNavigationController(rootViewController: AllGeneratedViewController())
        navVc.modalPresentationStyle = .fullScreen
        
        present(navVc, animated: true)
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
