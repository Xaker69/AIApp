import IGListKit

class GeneratedPhotoSection: ListSectionController {
    
    var model: GeneratedPackModel!
    
    override init() {
        super.init()
        
        inset = .zero   
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is GeneratedPackModel)
        model = object as? GeneratedPackModel
    }
    
    override func numberOfItems() -> Int {
        return model.pack.prompt?.images?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = collectionContext!.containerSize
        return CGSize(width: size.width, height: size.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: GeneratedPhotoCell.self, for: self, at: index)
        
        let images = model.pack.prompt?.images ?? []
        let imageURL = URL(string: images[index])
        
        cell.imageView.kf.setImage(with: imageURL)
        
        return cell
    }
}
