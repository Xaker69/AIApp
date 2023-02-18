import IGListKit

protocol SingleProfileDelegate: AnyObject {
    func singleProfile(_ section: SingleProfileSection, user: User?)
}

class SingleProfileSection: ListSectionController {
    
    var model: SingleProfileModel!
    let template = SingleProfileCell()
    weak var delegate: SingleProfileDelegate?
    
    override init() {
        super.init()
        
        inset = .zero
        minimumLineSpacing = 8.0
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.singleProfile(self, user: model.user)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        configure(cell: template)
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: SingleProfileCell.self, for: self, at: index)
        
        return configure(cell: cell)
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is SingleProfileModel)
        model = object as? SingleProfileModel
    }
    
    @discardableResult
    private func configure(cell: SingleProfileCell) -> SingleProfileCell {
        if let user = model.user, let data = user.photos.last {
            cell.profileView.addImageView.isHidden = true
            cell.profileView.titleLabel.text = user.name
            cell.profileView.titleStack.addArrangedSubview(cell.profileView.subtitleLabel)
            cell.profileView.layer.borderWidth = user.isSelected ? 0 : 1
            cell.profileView.backgroundColor = user.isSelected ? UIColor(white: 1, alpha: 0.1) : .clear
            
            ImageService.setImage(from: data, to: cell.profileView.imageView)
        }
        
        return cell
    }
    
}
