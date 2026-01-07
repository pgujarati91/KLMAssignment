import Foundation

protocol ArticleServiceProtocol {
    func fetchArticles() async throws -> [Article]
}

final class ArticleService: ArticleServiceProtocol {
    private let client: APIClient
    private let dataManager: DataManagerProtocol
    
    init(client: APIClient = DefaultAPIClient(), dataManager: DataManagerProtocol = DataManager.shared) {
        self.client = client
        self.dataManager = dataManager
    }
    
    func fetchArticles() async throws -> [Article] {
        do {
            let endPoint: EndPoint = .articles
            
            let articleResponse : ArticleModel =  try await client.send(endPoint, decoder: JSONDecoder())
            
            try await dataManager.saveOrUpdateArticle(articleResponse.results)
            
            return articleResponse.results
            
        }catch {
            return try await dataManager.fetchArticlesFromCoreData()
        }
    }
}
