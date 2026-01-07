import Foundation
internal import Combine

@MainActor
final class ArticleDetailViewModel: ObservableObject {
    
    private let service: ArticleDetailServiceProtocol
    @Published var isLoading = false
    @Published var error: NetworkError?
    @Published var articleDetail: Article?
    
    init(service: ArticleDetailServiceProtocol = ArticleDetailService()) {
        self.service = service
    }

    func getArticleByIdFromDataManager(by id: Int) async  {
        do {
            let articleDetail = try await service.fetchArticleDetailFromDataManager(id: id)
            self.articleDetail = articleDetail
        }catch {
            self.error = .decodingError(error)
        }
    }
}
    
