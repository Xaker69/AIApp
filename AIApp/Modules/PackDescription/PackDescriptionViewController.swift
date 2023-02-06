import UIKit
import IGListKit

class PackDescriptionViewController: UIViewController {

    var mainView: PackDescriptionView {
        return view as! PackDescriptionView
    }
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = PackDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.paymentView.getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func getButtonTapped() {
        let vc = UploadingViewController()
        
        navigationController?.setViewControllers([vc], animated: true)
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

// MARK: - UIScrollViewDelegate

extension PackDescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 464.0 {
            UIView.animate(withDuration: 0.2) {
                self.mainView.paymentView.layer.shadowColor = UIColor.clear.cgColor
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.mainView.paymentView.layer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
            }
        }
    }
}
