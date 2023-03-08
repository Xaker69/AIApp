import Foundation

class DeeplinkParser {
    static let shared = DeeplinkParser()
    
    func parseDeepLink(_ url: URL) -> DeeplinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        let pathComponents = components.path.components(separatedBy: "api/").last?.components(separatedBy: "/")
        
        switch pathComponents?.first {
        default:
            break
        }
        
        
        return nil
    }
}
