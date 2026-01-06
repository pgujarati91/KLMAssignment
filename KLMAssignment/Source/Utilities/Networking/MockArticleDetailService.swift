import Foundation
@testable import KLMAssignment

class MockArticleDetailService: ArticleDetailServiceProtocol {
    
    var articleDetailToReturn: Article?
    var errorToThrow: Error?
    
    func fetchArticleDetail(id: Int) async throws -> Article? {
        if let error = errorToThrow {
            throw error
        }
        return articleDetailToReturn
    }
    
    func fetchArticleDetailFromDataManager(id: Int) async throws -> Article? {
        if let error = errorToThrow {
            throw error
        }
        return articleDetailToReturn
    }
}
