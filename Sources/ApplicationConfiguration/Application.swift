
import PerfectCRUD
import PerfectLib
import PerfectHTTPServer
import PerfectHTTP

public struct Application: AppProtocol {
    
    public var name: String
    public var routes: Routes?
    public var config: Configuration?
    public var filters: AppFilters?
    
    public init(name: String, path: String) {
        self.init(name: name, path: path, routes: nil, filters: nil)
        self.name = name
    }
    
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
