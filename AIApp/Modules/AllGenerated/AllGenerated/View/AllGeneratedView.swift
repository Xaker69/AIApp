import UIKit

class AllGeneratedView: RootView {

    let headerView: UIView = UIView()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.close(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "All Loren’s packs"
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(headerView)
        addSubview(collectionView)
        
        headerView.addSubview(closeButton)
        headerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
                
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

}
