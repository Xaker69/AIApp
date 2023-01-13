import UIKit
import StoreKit
import Atributika

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
