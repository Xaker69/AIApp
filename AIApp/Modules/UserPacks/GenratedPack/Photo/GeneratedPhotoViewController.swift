import UIKit
import IGListKit

class GeneratedPhotoViewController: UIViewController {

    let startIndex: Int
    let pack: Pack
    var didSetStartIndex: Bool = false
    
    var mainView: GeneratedPhotoView {
        return view as! GeneratedPhotoView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    init(startIndex: Int, pack: Pack) {
        self.pack = pack
        self.startIndex = startIndex
        super.init(nibName: nil, bundle: nil)
        
        mainView.setCount(index: startIndex + 1, count: pack.prompt?.images?.count ?? 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = GeneratedPhotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didSetStartIndex {
            let point = CGPoint(x: UIScreen.main.bounds.width * CGFloat(startIndex), y: 0)
            adapter.collectionView?.setContentOffset(point, animated: false)
            didSetStartIndex = true
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

}

// MARK: - ListAdapterDataSource

extension GeneratedPhotoViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [GeneratedPackModel(pack: pack)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GeneratedPhotoSection()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension GeneratedPhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / UIScreen.main.bounds.width
        mainView.setCount(index: Int(index + 1), count: pack.prompt?.images?.count ?? 0)
    }
}
