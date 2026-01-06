import Foundation

protocol ArticleDetailServiceProtocol {
    func fetchArticleDetail(id: Int) async throws -> Article?
    func fetchArticleDetailFromDataManager(id: Int) async throws -> Article?
}

final class ArticleDetailService: ArticleDetailServiceProtocol {
    private let client: APIClient
    private let dataManager: DataManagerProtocol
    
    init(client: APIClient = DefaultAPIClient(), dataManager: DataManagerProtocol = DataManager.shared ) {
        self.client = client
        self.dataManager = dataManager
    }
    
    func fetchArticleDetail(id: Int) async throws -> Article? {
        do {
            let endPoint: EndPoint = .article(id: id)
            
            let articleDetail: Article = try await client.send(endPoint, decoder: JSONDecoder())
            
            return articleDetail
        }catch {
            
            return try await fetchArticleDetailFromDataManager(id: id)
        }
    }
    
    // Fetch data from local database
    func fetchArticleDetailFromDataManager(id: Int) async throws -> Article? {
        do {
            guard let articleDetail = try await dataManager.fetchArticleDetailById(id: id) else {
                return nil
            }
            return articleDetail
        }catch {
            return nil
        }
    }
}
