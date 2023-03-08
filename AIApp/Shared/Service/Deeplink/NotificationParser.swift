import Foundation

class NotificationParser {
    static let shared = NotificationParser()

    func handleNotification(_ userInfo: [AnyHashable: Any]) -> DeeplinkType? {
        if let json = userInfo["prompt"] as? [String: Any] {
            let prompt = Prompt(json: json)
            return DeeplinkType.prompt(prompt)
        }
        
        return nil
    }
}
