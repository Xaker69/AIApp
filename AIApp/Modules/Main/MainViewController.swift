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
        
        if let persons = PersonManager.shared.getPersons() {
            profileModel = ProfilesModel(persons: Array(persons))
        } else {
            profileModel = ProfilesModel(persons: [])
        }
        
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
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
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

// MARK: -
extension MainViewController: ProfileSectionDelegate {
    func profileSection(_ controller: ProfilesSection, didSelect person: Person?) {
        if let person = person {
            
        } else {
            navigationController?.pushViewController(AddAvatarViewController(), animated: true)
        }
    }
}
