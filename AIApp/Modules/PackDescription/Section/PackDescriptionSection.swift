import IGListKit

class PackDescriptionSection: ListSectionController {
    
    private let template = PackDescriptionCell()
    private var model: PackDescriptionModel!
    
    override init() {
        super.init()
                
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is PackDescriptionModel)
        model = object as? PackDescriptionModel
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
        
        let imageURL = URL(string: model.image)
        
        cell.imageView.kf.setImage(with: imageURL) { _ in
            cell.setNeedsLayout()
        }
        
        cell.layoutIfNeeded()
        
        return configure(cell: cell)
    }
    
    @discardableResult
    private func configure(cell: PackDescriptionCell) -> PackDescriptionCell {
        cell.setSubtitle(model.description)
        cell.titleLabel.text = model.title
        
        return cell
    }
    
}
