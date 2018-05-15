
import Foundation

public struct Configuration: Codable {
    let server: ServerConfiguration?
    let logging: LoggingConfiguration?
    public let db: DBConfiguration?
    let ssl: SSLConfiguration?
    let os: OS?
    let environment: Environment?
}

public struct ServerConfiguration: Codable {
    let baseURL: String?
    let baseDomain: String?
    let port: Int?
    let secure: Int?
}

public struct LoggingConfiguration: Codable {
    let requestLoggingPath: String?
    let logPath: String?
}

public struct DBConfiguration: Codable {
    public let name: String?
    public let host: String?
    public let port: Int?
    public let user: String?
    public let pass: String?
    public let driverType: DBDriverType
}

public enum DBDriverType: Int, Codable {
    case MySQL = 1
    case PostgreSQL = 2
}

public struct SSLConfiguration: Codable {
    let port: Int?
    let originCertificatePath: String?
    let privateKeyPath: String?
    let verifyMode: String?
}

public enum OS: Int, Codable {
    case linux = 1
    case macOS = 2
}

public enum Environment: Int, Codable {
    case dev = 1
    case preProd = 2
    case prod = 3
}

// MARK: Convenience initializers

extension Configuration {
    
    public init(data: Data) throws {
        self = try JSONDecoder().decode(Configuration.self, from: data)
    }
    
    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    public init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    public func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
