
import Foundation
import PerfectHTTP

/// This struct represents request and response application filters.
/// You can create AppFilters and use it in Application initialization
public struct AppFilters {
    /// request filters
    var request: [(HTTPRequestFilter, HTTPFilterPriority)]?
    /// response filters
    var response: [(HTTPResponseFilter, HTTPFilterPriority)]?
}
