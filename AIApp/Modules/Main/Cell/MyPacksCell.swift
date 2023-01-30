import UIKit

class MyPacksCell: UICollectionViewCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(collectionView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40.0)
            make.height.equalTo(198.0)
        }
    }
}
