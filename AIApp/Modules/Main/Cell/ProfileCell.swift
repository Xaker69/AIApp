import UIKit

class ProfileCell: UICollectionViewCell {
    
    // TODO: - replace all on collection with profile view
    let containreView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let profileView: ProfileView = {
        let view = ProfileView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear    
        
        addSubview(containreView)
        
        containreView.addSubview(profileView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containreView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(-16.0)
        }
    }
}
