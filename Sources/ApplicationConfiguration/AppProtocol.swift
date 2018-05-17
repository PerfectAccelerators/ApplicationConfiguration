
import Foundation
import PerfectHTTPServer
import PerfectHTTP

/**
 A protocol to define Applications.
 It is already implemented by Application.
 - see also: Application
*/
public protocol AppProtocol {
    /// application name
    var name: String { get }
    /// application configuration
    var config: Configuration? { get}
    /// a group of routes
    var routes: Routes? { get }
    /// application filters (request & response)
    var filters: AppFilters? { get }
    /// initialize the Application
    init(name: String, path: String)
    /// to return the server object
    func server() -> HTTPServer.Server
}
