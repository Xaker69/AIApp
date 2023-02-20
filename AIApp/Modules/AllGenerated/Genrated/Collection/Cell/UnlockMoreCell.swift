import UIKit

class UnlockMoreCell: UICollectionViewCell {
    
    let unlockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.generatedUnlock(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(unlockButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        unlockButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(20.0)
            make.bottom.equalToSuperview().offset(-16.0)
        }
    }
}
