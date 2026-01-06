import Foundation

protocol APIClient {
    func send<T: Decodable>(_ endpoint: EndPoint, decoder: JSONDecoder) async throws -> T
}
