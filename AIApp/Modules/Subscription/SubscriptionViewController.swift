import UIKit
import StoreKit
import Atributika
import SafariServices

class SubscriptionViewController: UIViewController {
    
    var mainView: SubscriptionView {
        return view as! SubscriptionView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = SubscriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let productID = "qwerty12345"
        let productsRequest = SKProductsRequest(productIdentifiers: Set([productID]))
        productsRequest.delegate = self
        productsRequest.start()
        
        mainView.trialEnableView.switcher.addTarget(self, action: #selector(switcherDidChanged), for: .valueChanged)
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        mainView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        setupClicablePrivacy()
    }
    
    @objc private func switcherDidChanged(_ sender: UISwitch) {
        let price = Style("price")
            .foregroundColor(.white)
            .font(.satoshiFont(ofSize: 18, weight: .bold))
        
        let trial = Style("trial")
            .foregroundColor(.white.withAlphaComponent(0.4))
            .font(.interFont(ofSize: 13, weight: .medium))
        
        if sender.isOn {
            mainView.priceLabel.attributedText = R.string.localizable.subscriptionPriceTrial("$4.99 / per month", " 3-day").style(tags: [price, trial])
        } else {
            mainView.priceLabel.attributedText = R.string.localizable.subscriptionPrice("$4.99 / per month").style(tags: [price])
        }
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

    private func setupClicablePrivacy() {
        mainView.privacyLabel.onClick = { [weak self] label, detection in
            switch detection.type {
            case let .tag(tag):
                if let href = tag.attributes["href"], let url = URL(string: href) {
                    self?.present(SFSafariViewController(url: url), animated: true)
                }
            default:
                break
            }
        }
    }
}

// MARK: - SKProductsRequestDelegate

extension SubscriptionViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print(transactions)
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            DispatchQueue.main.async {
//                self.mainView.priceLabel.attributedText = "Products found!".styleAll(Style())
            }
            print("Products found!")
            for product in response.products {
                print("Product: \(product.productIdentifier) \(product.localizedTitle) \(product.price.floatValue)")
            }
        } else {
            DispatchQueue.main.async {
//                self.mainView.priceLabel.attributedText = "No products found".styleAll(Style())
            }
            print("No products found")
            for product in response.invalidProductIdentifiers {
                print("Invalid product identifier: \(product)")
            }
        }
    }
}
