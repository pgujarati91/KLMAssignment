
import Foundation
import SwiftUI

final class DefaultAPIClient: APIClient {
    
    private let session: NetworkSessionProtocol
    
    init(session: NetworkSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func send<T: Decodable>(_ endpoint: EndPoint, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let request = try endpoint.makeURLRequest()
       
        let (data, response) = try await session.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.serverError(statusCode: http.statusCode)
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error: \(error)")
            throw NetworkError.decodingError(error)
        }
    }
}
