import UIKit

class ActionsView: RootView {
    
    let instButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.actionInst(), for: .normal)
    
        return button
    }()
    
    let twitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.actionTwitter(), for: .normal)
        return button
    }()
    
    let fbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.actionFb(), for: .normal)

        return button
    }()
    
    let otherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.actionOther(), for: .normal)

        return button
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            instButton,
            twitButton,
            fbButton,
            otherButton
        ])
        view.axis = .horizontal
        view.spacing = 16.0
        view.distribution = .fillEqually
        
        return view
    }()
    
    override func setup() {
        
        addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        instButton.snp.makeConstraints { make in
            make.size.equalTo(48.0)
        }
        
        twitButton.snp.makeConstraints { make in
            make.size.equalTo(48.0)
        }
        
        fbButton.snp.makeConstraints { make in
            make.size.equalTo(48.0)
        }
        
        otherButton.snp.makeConstraints { make in
            make.size.equalTo(48.0)
        }
    }
    
}
