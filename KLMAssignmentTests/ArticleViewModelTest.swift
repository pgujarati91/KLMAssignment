import Foundation
import XCTest
@testable import KLMAssignment

@MainActor  // Required for @Published properties
final class ArticleViewModelTests: XCTestCase {
    
    var viewModel: ArticleViewModel!
    var mockService: MockArticleService!
    
    override func setUp() {
        super.setUp()
        mockService = MockArticleService()
        viewModel = ArticleViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Initial State
    func testInitialState() {
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.article.isEmpty)
    }
    
    // MARK: - Successful Fetch
    func testGetAllArticles_Success_UpdatesArticles() async {
        // Arrange
        let expectedArticles: [Article] = [
            Article(
               id: 2,
               title: "Local Article",
               url: "https://local.com",
               imageURL: nil,
               newsSite: "Local Site",
               summary: "Local Summary",
           )
        ]
        mockService.articlesToReturn = expectedArticles
        
        await viewModel.getAllArticles()
        
        XCTAssertEqual(viewModel.article, expectedArticles)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    // MARK: - Error Handling
    func testGetAllArticles_Error_SetsErrorAndClearsArticles() async {
        
        let expectedError = NetworkError.invalidResponse
        mockService.errorToThrow = expectedError
        
        await viewModel.getAllArticles()
        
        XCTAssertEqual(viewModel.article, [])
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotEqual(viewModel.error, expectedError)
    }
    
    // MARK: - Loading State
    func testGetAllArticles_SetsLoadingCorrectly() async {
        
        mockService.articlesToReturn = []
   
        await viewModel.getAllArticles()
        
        XCTAssertFalse(viewModel.isLoading)
    }
}
