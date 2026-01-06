import Foundation

enum EndPoint {
    case articles
    case article(id: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.spaceflightnewsapi.net/v4/")!
    }
    
    var method: HTTPMethod { .GET }
    
    var headers: [String: String] { [:] }
    
    var path: String {
        switch self {
        case .articles:
            return "articles/"
        case .article(let id):
            return "article/\(id)"
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        
        let components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        
        guard let url = components.url else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        return request
    }
}
