import Foundation

protocol ArticleServiceProtocol {
    func fetchArticles() async throws -> [Article]
}

final class ArticleService: ArticleServiceProtocol {
    private let client: APIClient
    private let persistenceManager: DataManagerProtocol
    
    init(client: APIClient = DefaultAPIClient(), persistenceManager: DataManagerProtocol = DataManager.shared) {
        self.client = client
        self.persistenceManager = persistenceManager
    }
    
    func fetchArticles() async throws -> [Article] {
        do {
            let endPoint: EndPoint = .articles
            
            let articleResponse : ArticleModel =  try await client.send(endPoint, decoder: JSONDecoder())
            
            try await persistenceManager.saveArticleList(articleResponse.results)
            
            return articleResponse.results
        }catch {
            return try await persistenceManager.fetchArticlesFromCoreData()
        }
    }
    
    
}
