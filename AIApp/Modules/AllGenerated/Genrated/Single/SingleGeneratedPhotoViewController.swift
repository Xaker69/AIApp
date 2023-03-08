import UIKit
import IGListKit

class SingleGeneratedPhotoViewController: UIViewController {

    let startIndex: Int
    let photos: [String]
    var didSetStartIndex: Bool = false
    
    var mainView: SingleGeneratedPhotoView {
        return view as! SingleGeneratedPhotoView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    init(startIndex: Int, count: Int, photos: [String]) {
        self.photos = photos
        self.startIndex = startIndex
        super.init(nibName: nil, bundle: nil)
        
        mainView.setCount(index: startIndex + 1, count: count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = SingleGeneratedPhotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let point = CGPoint(x: UIScreen.main.bounds.width * CGFloat(startIndex), y: 0)
//        adapter.collectionView?.setContentOffset(point, animated: true)
//        adapter.collectionView?.scrollToItem(at: IndexPath(item: startIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let point = CGPoint(x: UIScreen.main.bounds.width * CGFloat(startIndex), y: 0)
//        adapter.collectionView?.setContentOffset(point, animated: true)
//        adapter.collectionView?.scrollToItem(at: IndexPath(item: startIndex, section: 0), at: .centeredHorizontally, animated: false)
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

extension SingleGeneratedPhotoViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [GeneratedPhotosModel(photos: photos)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SingleGeneratedPhotoSection()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension SingleGeneratedPhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / UIScreen.main.bounds.width
        mainView.setCount(index: Int(index + 1), count: 100)
    }
}
