import UIKit

class UploadingView: RootView {
    
    let bottomView = UploadingBottomView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.contentOffset = .zero
        view.contentInsetAdjustmentBehavior = .never
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(collectionView)
        addSubview(bottomView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
}
