import Foundation

enum DeeplinkType {
    case prompt(_ prompt: Prompt)
}

class DeepLinkManager {
    static let shared = DeepLinkManager()

    private var deeplinkType: DeeplinkType?

    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
        deeplinkType = DeeplinkParser.shared.parseDeepLink(url)
        return deeplinkType != nil
    }
    
    func handleRemoteNotification(_ notification: [AnyHashable: Any]) {
        deeplinkType = NotificationParser.shared.handleNotification(notification)
    }
    
    func checkDeepLink() {
        guard let deeplinkType = deeplinkType else { return }

        DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
        
        // reset deeplink after handling
        self.deeplinkType = nil // (1)
    }
}
