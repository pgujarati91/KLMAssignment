import Foundation
import SwiftUI
internal import Combine

@MainActor
final class ArticleViewModel: ObservableObject {
    
    private let articleService: ArticleServiceProtocol
    @Published var isLoading = false
    @Published var error: NetworkError?
    @Published var article: [Article] = []
    
    init(service: ArticleServiceProtocol = ArticleService()) {
        self.articleService = service
    }
    
    func getAllArticles() async {
        isLoading = true
        do {
            let article = try await articleService.fetchArticles()
            self.article = article
            self.error = nil    
        }catch let error {
            self.error = error as? NetworkError
            self.article = []
        }
        isLoading = false
    }
}
