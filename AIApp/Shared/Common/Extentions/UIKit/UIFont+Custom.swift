import UIKit

enum InterFontWeight: String {
    case bold = "-Bold"
    case extraBold = "-ExtraBold"
    case medium = "-Medium"
    case regular = "-Regular"
    case semiBold = "-SemiBold"
    case black = "-Black"
}

extension UIFont {
    class func interFont(ofSize fontSize: CGFloat, weight: InterFontWeight) -> UIFont {
        let name = "Inter" + weight.rawValue
        return UIFont(name: name, size: fontSize)!
    }
    
    class func satoshiFont(ofSize fontSize: CGFloat, weight: InterFontWeight) -> UIFont {
        let name = "Satoshi" + weight.rawValue
        return UIFont(name: name, size: fontSize)!
    }
}
