
import Foundation
import PerfectHTTPServer
import PerfectHTTP

public protocol AppProtocol {
    var name: String { get }
    var config: Configuration? { get}
    var routes: Routes? { get }
    var filters: AppFilters? { get }
    init(name: String, path: String)
    func server() -> HTTPServer.Server
}
