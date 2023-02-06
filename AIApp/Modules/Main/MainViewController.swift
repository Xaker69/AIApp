import UIKit
import IGListKit

class MainViewController: UIViewController {

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
    }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        
        present(vc, animated: true)
    }
}

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            ProfileModel(name: "profile"),
            MyPacksModel(name: "myPacks"),
            NewPacksModel(name: "morePacks")
        ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ProfileModel:
            return ProfileSection()
            
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
