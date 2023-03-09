import IGListKit

class SingleGeneratedPhotoSection: ListSectionController {
    
    var model: GeneratedPhotosModel!
    
    override init() {
        super.init()
        
        inset = .zero   
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is GeneratedPhotosModel)
        model = object as? GeneratedPhotosModel
    }
    
    override func numberOfItems() -> Int {
        return model.photos.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = collectionContext!.containerSize
        return CGSize(width: size.width, height: size.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: GeneratedPhotoCell.self, for: self, at: index)
        
        let imageURL = URL(string: model.photos[index])
        cell.imageView.kf.setImage(with: imageURL)
        
        return cell
    }
}
