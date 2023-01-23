import IGListKit

class PackDescriptionSection: ListSectionController {
    
    private let template = PackDescriptionCell()
    
    override init() {
        super.init()
                
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        configure(cell: template)
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: PackDescriptionCell.self, for: self, at: index)
                
        return configure(cell: cell)
    }
    
    @discardableResult
    private func configure(cell: PackDescriptionCell) -> PackDescriptionCell {
        return cell
    }
    
}
