import UIKit

class UploadingBottomView: RootView {

    var isGradientDidSet: Bool = false
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.uploadingContinue(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.alpha = 0
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.uploadingBottomTitle()
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.uploadingBottomSubititle()
        label.font = .interFont(ofSize: 13, weight: .regular)
        label.textColor = .init(white: 1, alpha: 0.6)
        label.textAlignment = .center
        
        return label
    }()
    
    let progressContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hex6: 0x272727).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 24/2
        
        return view
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .bar
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8/2
        view.progress = 0
        view.clipsToBounds = true
        view.progressTintColor = .white
        view.trackTintColor = .init(white: 1, alpha: 0.05)
        view.layer.sublayers![1].cornerRadius = 8/2
        view.subviews[1].clipsToBounds = true
        
        return view
    }()
    
    let completeImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.uploadComplete()
        view.alpha = 0
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        layer.cornerRadius = 25
        layer.cornerCurve = .continuous
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(continueButton)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(progressContainer)
        addSubview(completeImageView)
        
        progressContainer.addSubview(progressView)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds != .zero && !isGradientDidSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = UIScreen.main.scale
        layer.masksToBounds = false
    }
    
    func animateCompleteLoad() {
        progressContainer.snp.remakeConstraints { make in
            make.width.equalTo(32.0)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.layoutIfNeeded()
            self.progressContainer.alpha = 0
            self.completeImageView.alpha = 1
            self.completeImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.progressContainer.removeFromSuperview()
                self.completeImageView.removeFromSuperview()
                self.titleLabel.removeFromSuperview()
                self.subtitleLabel.removeFromSuperview()
                
                self.continueButton.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(16.0)
                    make.left.right.equalToSuperview().inset(20.0)
                    make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16.0)
                    make.height.equalTo(56.0)
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                    self.continueButton.alpha = 1
                }
            }
        }

    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(16.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(6.0)
        }
        
        progressContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
        }
        
        completeImageView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20.0)
            make.size.equalTo(32.0/2.0)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(8.0)
            make.height.equalTo(8.0)
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.height.equalTo(56.0)
        }
    }

}
