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
    
    private func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4.0)
            make.bottom.top.equalToSuperview().inset(20.0)
        }
    }
    
}
