import UIKit
import IGListKit

class AllGeneratedPhotosViewController: UIViewController {

    var mainView: AllGeneratedPhotosView {
        return view as! AllGeneratedPhotosView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = AllGeneratedPhotosView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
}

// MARK: - ListAdapterDataSource

extension AllGeneratedPhotosViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            GeneratedPhotosModel(photos: [UIImage()]),
            UnlockMoreModel(desctioption: "UnlockMoreModel")
        ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GeneratedPhotosModel:
            return GeneratedPhotosSection()
            
        case is UnlockMoreModel:
            return UnlockMoreSection()
            
        default:
            preconditionFailure("Unknown object type")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
