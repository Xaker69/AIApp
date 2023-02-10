import UIKit

class ProfileView: RootView {

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 49/2
        view.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = nil
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 48/2
        
        return view
    }()
    
    let addImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.profileCellAdd()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.mainAddProfile()
        label.font = .interFont(ofSize: 14, weight: .semiBold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.mainManyPacks("0")
        label.font = .interFont(ofSize: 12, weight: .regular)
        label.textColor = .init(white: 1, alpha: 0.6)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        view.axis = .vertical
        view.spacing = 4
        
        return view
    }()
    
    override func setup() {
        layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 80/2
        
        addSubview(containerView)
        addSubview(titleStack)
        
        containerView.addSubview(addImageView)
        containerView.addSubview(imageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(16.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1.0)
        }
        
        addImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
            make.size.equalTo(24.0)
        }
        
        titleStack.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0 * 2)
            make.centerY.equalToSuperview()
        }
    }
}
