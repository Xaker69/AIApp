import UIKit
import IGListKit

protocol NewPacksDelegate: AnyObject {
    func newPacks(getPack index: Int)
}

class NewPacksSection: ListSectionController {

    let template = NewPackCell()
    
    weak var delegate: NewPacksDelegate?
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        supplementaryViewSource = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        configure(cell: template, index: index)
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
    override func numberOfItems() -> Int {
        return 10
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: NewPackCell.self, for: self, at: index)
        
        return configure(cell: cell, index: index)
    }
    
    @objc private func getPackTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        delegate?.newPacks(getPack: index)
    }
    
    @discardableResult
    private func configure(cell: NewPackCell, index: Int) -> NewPackCell {
        adapter.collectionView = cell.collectionView
        adapter.dataSource = self
        
        cell.getContainer.tag = index
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getPackTapped))
        cell.getContainer.addGestureRecognizer(gesture)
        
        return cell
    }
    
}

// MARK: - ListSupplementaryViewSource

extension NewPacksSection: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let view = collectionContext!.dequeue(ofKind: UICollectionView.elementKindSectionHeader, for: self, of: MainHeaderView.self, at: index)
        view.titleLabel.text = R.string.localizable.mainHeaderExplore()
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 56.0)
    }
    
}

// MARK: - ListAdapterDataSource

extension NewPacksSection: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [NewPackExampleModel(images: [UIImage()])]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return NewPackExampleSection()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}
