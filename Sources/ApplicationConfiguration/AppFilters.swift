
import Foundation
import PerfectHTTP

public struct AppFilters {
    var request: [(HTTPRequestFilter, HTTPFilterPriority)]?
    var response: [(HTTPResponseFilter, HTTPFilterPriority)]?
}
