import Foundation

class MockArticleService: ArticleServiceProtocol {
    var articlesToReturn: [Article] = []
    var errorToThrow: NetworkError?
    
    func fetchArticles() async throws -> [Article] {
        if let error = errorToThrow {
            throw error
        }
        return articlesToReturn
    }
}
