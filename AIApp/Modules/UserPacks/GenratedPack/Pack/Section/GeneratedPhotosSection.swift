import IGListKit
import Kingfisher

protocol GeneratedPackDelegate: AnyObject {
    func generatedPack(_ controller: GeneratedPackSection, didSelect index: Int)
}

class GeneratedPackSection: ListSectionController {
    
    weak var delegate: GeneratedPackDelegate?
    var model: GeneratedPackModel!
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 16.0, left: 20.0, bottom: 40.0, right: 20.0)
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is GeneratedPackModel)
        model = object as? GeneratedPackModel
    }
    
    override func numberOfItems() -> Int {
        return model.pack.prompt?.images?.count ?? 0
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.generatedPack(self, didSelect: index)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = (collectionContext!.containerSize.width - 5 - 20 - 20) / 2
        
        return CGSize(width: width, height: width * 190/165)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: GeneratedPhotoCell.self, for: self, at: index)
        
        let images = model.pack.prompt?.images ?? []
        let imageURL = URL(string: images[index])
        
        cell.imageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
}
