import DebugManager
import SwiftyBeaver

func logDebug(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
    let message = message.map({ "\($0 ?? "nil")" }).joined(separator: " ")
    DebugService.shared.debugger.log(level: .debug, message: message, file: file, function: function, line: line)
}

func logVerbose(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
    let message = message.map({ "\($0 ?? "nil")" }).joined(separator: " ")
    DebugService.shared.debugger.log(level: .verbose, message: message, file: file, function: function, line: line)
}

func logInfo(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
    let message = message.map({ "\($0 ?? "nil")" }).joined(separator: " ")
    DebugService.shared.debugger.log(level: .info, message: message, file: file, function: function, line: line)
}

func logWarning(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
    let message = message.map({ "\($0 ?? "nil")" }).joined(separator: " ")
    DebugService.shared.debugger.log(level: .warning, message: message, file: file, function: function, line: line)
}

func logError(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
    let message = message.map({ "\($0 ?? "nil")" }).joined(separator: " ")
    DebugService.shared.debugger.log(level: .error, message: message, file: file, function: function, line: line)
}

class DebugService: NSObject {
    
    static let shared = DebugService()
    
    private let port = 8080
    let customDestination = SBPlatformDestination(appID: "0G8N9r", appSecret: "2fzaqfe9gbrizlmbzimqb7Ckmik0rzwj", encryptionKey: "yagsyPf8dknKRfzivcx4pxbniO0nhjca")
    
    private(set) lazy var debugger: DebugManager = {
        return DebugManager(destinations: [.console, .file(), .web(port: port), .custom(customDestination)])
    }()

}
