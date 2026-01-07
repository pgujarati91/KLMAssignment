import XCTest
@testable import KLMAssignment

@MainActor
final class ArticleViewModelTests: XCTestCase {
    
    private var articleViewModel: ArticleViewModel!
    private var mockService: MockArticleService!
    
    override func setUp() {
        super.setUp()
        mockService = MockArticleService()
        articleViewModel = ArticleViewModel(service: mockService)
    }
    
    override func tearDown() {
        articleViewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(articleViewModel.loadingState, .idle)
        XCTAssertTrue(articleViewModel.article.isEmpty)
        XCTAssertNil(articleViewModel.error)
    }
    
    func testGetAllArticlesSuccessSetsLoadedState() async throws {
        mockService = MockArticleService.successMock()
        articleViewModel = ArticleViewModel(service: mockService)
        
        await articleViewModel.getAllArticles()
        
        try await Task.sleep(for: .milliseconds(100))
        
        XCTAssertEqual(articleViewModel.loadingState, .loaded(mockService.articlesToReturn))
        XCTAssertFalse(articleViewModel.article.isEmpty)
        XCTAssertNil(articleViewModel.error)
    }

    func testGetAllArticlesEmptySetsEmptyState() async throws {
        mockService = MockArticleService.emptyMock()
        articleViewModel = ArticleViewModel(service: mockService)
        
        await articleViewModel.getAllArticles()
        
        try await Task.sleep(for: .milliseconds(100))
        
        XCTAssertEqual(articleViewModel.loadingState, .empty)
        XCTAssertTrue(articleViewModel.article.isEmpty)
        XCTAssertNil(articleViewModel.error)
    }
    
    func testGetAllArticlesErrorSetsErrorState() async throws {
        mockService = MockArticleService.errorMock()
        articleViewModel = ArticleViewModel(service: mockService)
        
        await articleViewModel.getAllArticles()
        
        try await Task.sleep(for: .milliseconds(100))
        
        XCTAssertEqual(articleViewModel.loadingState, .error(.noData))
        XCTAssertNil(articleViewModel.error)
        XCTAssertTrue(articleViewModel.article.isEmpty)
    }
    
    func testLoadingStateDuringFetch() async throws {
        let mock = MockArticleService.successMock()
        let viewModel = ArticleViewModel(service: mock)
        
        XCTAssertEqual(viewModel.loadingState, .idle)
        
        let task = Task { await viewModel.getAllArticles() }
        
        try await Task.sleep(for: .milliseconds(50))
        XCTAssertEqual(viewModel.loadingState, .loading)
        
        await task.value
        XCTAssertEqual(viewModel.loadingState, .loaded(mock.articlesToReturn))
    }
    
    func testDuplicateLogicSetsLoadedForNonEmpty() async throws {

        mockService.articlesToReturn = [
            Article(id: 1, title: "A", url: nil, imageURL: nil, newsSite: "Test", summary: ""),
            Article(id: 2, title: "B", url: nil, imageURL: nil, newsSite: "Test", summary: "")
        ]
        articleViewModel = ArticleViewModel(service: mockService)
        
        await articleViewModel.getAllArticles()
        
        try await Task.sleep(for: .milliseconds(100))
        
        XCTAssertEqual(articleViewModel.loadingState, .loaded(mockService.articlesToReturn))
    }

    func testSingleArticleSetsLoadedState() async throws {
        
        mockService.articlesToReturn = [Article(id: 1, title: "Single", url: nil, imageURL: nil, newsSite: "Test", summary: "")]
        
        articleViewModel = ArticleViewModel(service: mockService)
        
        await articleViewModel.getAllArticles()
        
        try await Task.sleep(for: .milliseconds(100))
        
        XCTAssertEqual(articleViewModel.loadingState, .loaded([mockService.articlesToReturn[0]]))
    }
}
