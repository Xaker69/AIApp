import UIKit
import IGListKit

class PackDescriptionViewController: UIViewController {

    var mainView: PackDescriptionView {
        return view as! PackDescriptionView
    }
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    
    override func loadView() {
        view = PackDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - ListAdapterDataSource

extension PackDescriptionViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let models: [ListDiffable] = [
            PackDescriptionModel(title: ""),
            PackImageExampleModel(images: [UIImage()])
        ]
        
        return models
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is PackDescriptionModel:
            return PackDescriptionSection()
            
        case is PackImageExampleModel:
            return PackImageExampleSection()
            
        default:
            preconditionFailure("Unknown object type")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
