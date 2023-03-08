import UIKit
import IGListKit

class AllGeneratedViewController: UIViewController {
    
    var mainView: AllGeneratedView {
        return view as! AllGeneratedView
    }
    
    private lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = AllGeneratedView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.dataSource = self
        adapter.collectionView = mainView.collectionView
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

}

// MARK: - ListAdapterDataSource

extension AllGeneratedViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [MySinglePackModel(packs: UserManager.shared.selectedUser.packs)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = MySinglePackSection(direction: .vertical)
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - MySinglePackDelegate

extension AllGeneratedViewController: MySinglePackDelegate {
    func mySinglePack(_ section: MySinglePackSection, didSelect pack: Pack) {
        if pack.isGenerating {
            present(AttentionViewController(), animated: true)
        } else {
            let vc = AllGeneratedPhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
