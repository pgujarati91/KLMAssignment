import Foundation

protocol ArticleDetailServiceProtocol {
    func fetchArticleDetailFromDataManager(id: Int) async throws -> Article?
}

final class ArticleDetailService: ArticleDetailServiceProtocol {
    private let client: APIClient
    private let dataManager: DataManagerProtocol
    
    init(client: APIClient = DefaultAPIClient(), dataManager: DataManagerProtocol = DataManager.shared ) {
        self.client = client
        self.dataManager = dataManager
    }
    
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
