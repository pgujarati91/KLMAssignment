import Foundation

class MockArticleService: ArticleServiceProtocol {
    var articlesToReturn: [Article] = []
    var errorToThrow: Error?
    var shouldFailCache = false
    
    func fetchArticles() async throws -> [Article] {
        
        try await Task.sleep(for: .milliseconds(200))
        
        if let error = errorToThrow {
            throw error
        }
        return articlesToReturn
    }
}

extension MockArticleService {
    static func successMock() -> MockArticleService {
        let mock = MockArticleService()
        mock.articlesToReturn = [
            Article(id: 1,
                    title: "Test 1",
                    url: nil,
                    imageURL: nil,
                    newsSite: "Test",
                    summary: "Summary"),
            Article(id: 2,
                    title: "Test 2",
                    url: nil,
                    imageURL: nil,
                    newsSite: "Test",
                    summary: "Summary")
        ]
        return mock
    }
    
    static func emptyMock() -> MockArticleService {
        return MockArticleService()
    }
    
    static func errorMock() -> MockArticleService {
        let mock = MockArticleService()
        mock.errorToThrow = NetworkError.noData
        return mock
    }
}
