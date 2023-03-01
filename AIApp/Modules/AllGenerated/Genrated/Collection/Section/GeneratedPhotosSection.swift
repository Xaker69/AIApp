import IGListKit
import Kingfisher

protocol GeneratedPhotosDelegate: AnyObject {
    func generatedPhotos(_ controller: GeneratedPhotosSection, didSelect index: Int)
}

class GeneratedPhotosSection: ListSectionController {
    
    weak var delegate: GeneratedPhotosDelegate?
    let user = UserManager.shared.users[0]
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 16.0, left: 20.0, bottom: 40.0, right: 20.0)
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
    
    override func numberOfItems() -> Int {
        return user.photos.count
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.generatedPhotos(self, didSelect: index)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = (collectionContext!.containerSize.width - 5 - 20 - 20) / 2
        
        return CGSize(width: width, height: width * 190/165)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: GeneratedPhotoCell.self, for: self, at: index)
        
        ImageService.setImage(from: user.photos[index], to: cell.imageView)
        
        return cell
    }
    
}