
import Foundation
import PerfectHTTP

/// This struct represents request and response application filters.
/// You can create AppFilters and use it in Application initialization
public struct AppFilters {
    /// request filters
    var request: [(HTTPRequestFilter, HTTPFilterPriority)]?
    /// response filters
    var response: [(HTTPResponseFilter, HTTPFilterPriority)]?
    
    /// public initalizer
    public init(request: [(HTTPRequestFilter, HTTPFilterPriority)]?,
                response: [(HTTPResponseFilter, HTTPFilterPriority)]?) {
        
        self.request = request
        self.response = response
    }
}
