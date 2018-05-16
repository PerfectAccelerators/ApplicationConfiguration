
import Foundation

/// This struct represents the configuration of
/// an application
/// example usage:
/// // path represents a json file location that have the same key names as the struct props
/// let file = File(path)
/// if file.exists == false {
///     print("Configuration file doesn't exist!")
/// }
/// do {
///     try file.open(.read, permissions: .readUser)
///     defer { file.close() }
///     let json = try file.readString()
///     let conf = try Configuration(json)
///     app.config = conf // assign it to your application's config to be used when you launch the server
/// } catch {
///     print(error)
/// }

public struct Configuration: Codable {
    /// server configuration including url and port
    let server: ServerConfiguration?
    /// logging configuration includign paths
    let logging: LoggingConfiguration?
    /// database configuration including host, user, pass,...
    public let db: DBConfiguration?
    /// ssl certificate configurations
    let ssl: SSLConfiguration?
    /// operating systems - Linux or macOS
    let os: OS?
    /// different environments such as dev, pre-production
    /// and production
    let environment: Environment?
}

/// This struct represents the server configuration
public struct ServerConfiguration: Codable {
    let baseURL: String?
    let baseDomain: String?
    let port: Int?
    let secure: Int?
}

/// configuration for logging
public struct LoggingConfiguration: Codable {
    let requestLoggingPath: String?
    let logPath: String?
}

/// database configuration that should be initialized when Configuration is initialized
/// ScantORM uses this configuration to initialize the DatabaseAdapter
/// You can use it without ScantORM if you need to
public struct DBConfiguration: Codable {
    public let name: String?
    public let host: String?
    public let port: Int?
    public let user: String?
    public let pass: String?
    public let driverType: DBDriverType
    
    public init(name: String?,
                host: String?,
                port: Int?,
                user: String?,
                pass: String?,
                driverType: DBDriverType) {
        self.name = name
        self.host = host
        self.port = port
        self.user = user
        self.pass = pass
        self.driverType = driverType
    }
}

/// Database driver type
public enum DBDriverType: Int, Codable {
    case mySQL = 1
    case postgreSQL = 2
    case sqLite = 3
}

/// SSL configuration for https server
public struct SSLConfiguration: Codable {
    let port: Int?
    let originCertificatePath: String?
    let privateKeyPath: String?
    let verifyMode: String?
}

/// operating system
public enum OS: Int, Codable {
    case linux = 1
    case macOS = 2
}

/// deployment environment
public enum Environment: Int, Codable {
    case dev = 1
    case preProd = 2
    case prod = 3
}

// MARK: Convenience initializers

extension Configuration {
    /// init configuration with Data
    public init(data: Data) throws {
        self = try JSONDecoder().decode(Configuration.self, from: data)
    }
    /// init configuration with JSON
    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    /// init configuration from a URL
    public init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    /// return json data representation of the configuration
    public func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    /// return json string representation of the configuration
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
