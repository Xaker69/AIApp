import IGListKit

protocol MySinglePackDelegate: AnyObject {
    func mySinglePack(_ section: MySinglePackSection, didSelect pack: Pack)
}

class MySinglePackSection: ListSectionController {
    
    weak var delegate: MySinglePackDelegate?
    var model: MySinglePackModel!
    
    init(direction: UICollectionView.ScrollDirection) {
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        
        switch direction {
        case .horizontal:
            minimumLineSpacing = 8.0
            minimumInteritemSpacing = 0.0
            
        case .vertical:
            minimumLineSpacing = 16
            minimumInteritemSpacing = 8.0
            
        default:
            break
        }
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is MySinglePackModel)
        model = object as? MySinglePackModel
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.mySinglePack(self, didSelect: model.pack)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width/2 - 20 - 4
        let ratio = 198.0/165.0
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: MySinglePackCell.self, for: self, at: index)
        
        let imageURL = URL(string: model.pack.previewImage)
        
        cell.setTitle(model.pack.name)
        cell.imageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
}
