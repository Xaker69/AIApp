import UIKit
import IGListKit

class UploadingViewController: UIViewController {

    var mainView: UploadingView {
        return view as! UploadingView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = UploadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.bottomView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
    }
    
    @objc private func continueButtonTapped() {
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }

}

// MARK: - ListAdapterDataSource

extension UploadingViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [NewPacksModel(name: "morePacks")]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = NewPacksSection(headerType: .oneTimeOffer)
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - NewPacksDelegate

extension UploadingViewController: NewPacksDelegate {
    func newPacks(getPack index: Int) {
        
    }
}
