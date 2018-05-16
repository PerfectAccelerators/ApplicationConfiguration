
import PerfectCRUD
import PerfectLib
import PerfectHTTPServer
import PerfectHTTP

/// This struct represnts an Application
/// with its configuration, routes and filters
/// You could use this application or create another
/// Application object that complies with AppProtocol
public struct Application: AppProtocol {
    
    public var name: String
    public var routes: Routes?
    public var config: Configuration?
    public var filters: AppFilters?
    /// init with only name and configuration file path
    /// - parameter name: application name
    /// - parameter path: confuration file path - a json file that represents the configs such as:
    /// {
    ///     "server": {
    ///         "baseURL": "localhost:8181",
    ///         "baseDomain": "localhost",
    ///         "port": 8181,
    ///         "secure": 0
    ///     },
    ///     "os": 2,
    ///     "environment": 1,
    ///     "ssl": {
    ///         "port": 443,
    ///         "originCertificatePath": "",
    ///         "privateKeyPath": "",
    ///         "verifyMode": "peer"
    ///     },
    ///     "logging": {
    ///         "requestLoggingPath": "./perfectRequests.log",
    ///         "logPath": "./perfect.log"
    ///     },
    ///     "db": {
    ///         "name": "perfect",
    ///         "host": "localhost",
    ///         "port": 3306,
    ///         "user": "",
    ///         "pass": "",
    ///         "driverType": 1
    ///     }
    /// }
    public init(name: String, path: String) {
        self.init(name: name, path: path, routes: nil, filters: nil)
        self.name = name
    }
    /// init with name, path, routes and filters
    /// - parameter name: application name
    /// - parameter path: confuration file path - a json file that represents the configs
    /// - parameter routes: a group of routes
    /// - parameter filters: application filters (request & response)
    public init(name: String,
                path: String,
                routes: Routes?,
                filters: AppFilters?) {
        
        self.name = name
        let file = File(path)
        if file.exists == false {
            print("Configuration file doesn't exist!")
        }
        do {
            try file.open(.read, permissions: .readUser)
            defer { file.close() }
            let json = try file.readString()
            let conf = try Configuration(json)
            self.config = conf
        } catch {
            print(error)
        }
        
        if let rts = routes {
            self.routes = rts
        } else {
            self.routes = nil
        }
        
        if let fltrs = filters {
            self.filters = fltrs
        } else {
            self.filters = nil
        }
    }
    /// return configured server
    public func server() -> HTTPServer.Server {
        
        let port = config?.server?.port ?? 8181
        let httpServer = HTTPServer.Server.server(name: name,
                                                  port: port,
                                                  routes: routes!,
                                                  requestFilters: filters?.request ?? [],
                                                  responseFilters: filters?.response ?? [])
        return httpServer
    }
}
