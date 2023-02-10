import IGListKit

protocol SingleProfileDelegate: AnyObject {
    func singleProfile(_ section: SingleProfileSection, person: Person?)
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
        delegate?.singleProfile(self, person: model.person)
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
        if let person = model.person, let firstData = person.photos.last, let data = firstData {
            cell.profileView.addImageView.isHidden = true
            cell.profileView.imageView.image = UIImage(data: data)
            cell.profileView.titleLabel.text = person.name
            cell.profileView.titleStack.addArrangedSubview(cell.profileView.subtitleLabel)
        }
        
        return cell
    }
    
}
