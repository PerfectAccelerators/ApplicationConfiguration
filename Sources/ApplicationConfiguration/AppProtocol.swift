
import Foundation
import PerfectHTTPServer
import PerfectHTTP

/// A protocol to define Applications
/// name: application name
/// config: application configuration
/// routes: a group of routes
/// filters: application filters (request & response)
/// init: to initialize the Application
/// server to return the server object
public protocol AppProtocol {
    var name: String { get }
    var config: Configuration? { get}
    var routes: Routes? { get }
    var filters: AppFilters? { get }
    init(name: String, path: String)
    func server() -> HTTPServer.Server
}
