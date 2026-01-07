import Foundation
import SwiftUI
internal import Combine

enum LoadingState: Equatable {
    case idle
    case loading
    case loaded([Article])
    case error(NetworkError)
    case empty
}

@MainActor
final class ArticleViewModel: ObservableObject {
    
    private let articleService: ArticleServiceProtocol
    @Published private(set) var loadingState: LoadingState = .idle
    @Published var error: NetworkError?
    @Published var article: [Article] = []
    
    init(service: ArticleServiceProtocol = ArticleService()) {
        self.articleService = service
    }
    
    func getAllArticles() async {
        loadingState = .loading
        do {
            let articles = try await articleService.fetchArticles()
            
            loadingState = articles.isEmpty ? .empty : .loaded(articles)
            
            self.article = articles
            
        } catch {
            let networkError = error as? NetworkError ?? .noData
            loadingState = .error(networkError)
        }
    }
}
