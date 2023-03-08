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
        return model.packs.count
    }
    
    override func didSelectItem(at index: Int) {
        let pack = model.packs[index]
        delegate?.mySinglePack(self, didSelect: pack)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 165, height: 198.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: MySinglePackCell.self, for: self, at: index)
        
        let pack = model.packs[index]
        let imageURL = URL(string: pack.previewImage)
        
        cell.setTitle(pack.name)
        cell.imageView.kf.setImage(with: imageURL)
        cell.generatingLabel.isHidden = !pack.isGenerating
        cell.generatingImageView.isHidden = !pack.isGenerating
        
        return cell
    }
    
}
