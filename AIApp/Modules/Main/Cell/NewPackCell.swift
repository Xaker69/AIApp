import UIKit
import Atributika

class NewPackCell: UICollectionViewCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.contentOffset = .zero
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Christmas Mood"
        label.font = .satoshiFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    let picsImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.choosePackCellPics()
        view.tintColor = .init(hex6: 0xA851FF)
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let picsLabel: UILabel = {
        let label = UILabel()
        label.text = "100 pics"
        label.font = .interFont(ofSize: 11, weight: .semiBold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    let getContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 48/2
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let getLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.textAlignment = .center
        
        let strike = Style("strike")
            .foregroundColor(.init(white: 0, alpha: 0.4))
            .strikethroughStyle(.single)
        
        let all = Style("all")
            .foregroundColor(.black)
            .font(.interFont(ofSize: 13, weight: .bold))
        
        label.attributedText = R.string.localizable.mainExploreButton().style(tags: [all, strike])
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addSubview(titleLabel)
        addSubview(picsImageView)
        addSubview(picsLabel)
        addSubview(getContainer)
        
        getContainer.addSubview(getLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(8.0)
            make.height.equalTo(138.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
        }
        
        picsImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(16.0)
        }
        
        picsLabel.snp.makeConstraints { make in
            make.left.equalTo(picsImageView.snp.right).offset(4.0)
            make.centerY.equalTo(picsImageView.snp.centerY)
        }
        
        getContainer.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.0)
            make.top.equalTo(collectionView.snp.bottom).offset(16.0)
            make.bottom.equalToSuperview().offset(-24.0)
        }
        
        getLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24.0)
            make.bottom.top.equalToSuperview().inset(14.0)
        }
    }
}
