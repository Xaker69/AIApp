import UIKit

class SingleProfileCell: UICollectionViewCell {
    
    let profileView: ProfileView = {
        let view = ProfileView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileView.layer.borderWidth = 1
        profileView.backgroundColor = .clear
        profileView.imageView.image = nil
        profileView.addImageView.isHidden = false
        profileView.subtitleLabel.isHidden = true
        profileView.titleLabel.text = R.string.localizable.mainAddProfile()
    }
    
    private func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4.0)
            make.bottom.top.equalToSuperview().inset(20.0)
        }
    }
    
}
