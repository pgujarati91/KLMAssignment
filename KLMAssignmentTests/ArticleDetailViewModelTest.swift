import XCTest
@testable import KLMAssignment

@MainActor
final class ArticleDetailViewModelTest: XCTestCase {
    
    var viewModel: ArticleDetailViewModel!
    var mockService: MockArticleDetailService!
    
    override func setUp() {
        super.setUp()
        mockService = MockArticleDetailService()
        viewModel = ArticleDetailViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - getArticleById Tests
    
    func test_GetArticleById_Success() async {
        // Arrange
        let expectedArticle = Article(
            id: 1,
            title: "Test Article",
            url: "https://test.com",
            imageURL: nil,
            newsSite: "Test Site",
            summary: "Test Summary"
        )
        mockService.articleDetailToReturn = expectedArticle
        
        // Act
        await viewModel.getArticleById(by: 1)
        XCTAssertEqual(viewModel.articleDetail, expectedArticle)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    func test_GetArticleById_Failure() async {
        let expectedError = NetworkError.invalidResponse
        mockService.errorToThrow = expectedError
        await viewModel.getArticleById(by: 1)
        
        XCTAssertNil(viewModel.articleDetail)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotEqual(viewModel.error, Optional(expectedError))
    }
    
    func test_GetArticleById_SetsLoadingState() async {
        mockService.articleDetailToReturn = nil
        await viewModel.getArticleById(by: 1)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // MARK: - getArticleByIdFromDataManager Tests
    
    func testGetArticleByIdFromDataManager_Success_UpdatesArticleDetail() async {
        let expectedArticle = Article(
            id: 2,
            title: "Local Article",
            url: "https://local.com",
            imageURL: nil,
            newsSite: "Local Site",
            summary: "Local Summary",
        )
        mockService.articleDetailToReturn = expectedArticle
        
        await viewModel.getArticleByIdFromDataManager(by: 2)
        
        XCTAssertEqual(viewModel.articleDetail, expectedArticle)
        XCTAssertNil(viewModel.error)
    }
    
    func testGetArticleByIdFromDataManager_Failure_SetsDecodingError() async {
        let expectedError = NSError(domain: "Test", code: 1, userInfo: nil)
        mockService.errorToThrow = expectedError
        
        await viewModel.getArticleByIdFromDataManager(by: 2)
        
        if case .decodingError(_) = viewModel.error {
            // Success
        } else {
            XCTFail("Expected .decodingError but got \(String(describing: viewModel.error))")
        }
        XCTAssertNil(viewModel.articleDetail)
    }
}
