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
        
    func testGetArticleByIdFromDataManager_Success_UpdatesArticleDetail() async {
        let expectedArticle = Article(
            id: 2,
            title: "Local Article",
            url: "https://local.com",
            imageURL: nil,
            newsSite: "Local Site",
            summary: "Local Summary"
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
        } else {
            XCTFail("Expected .decodingError but got \(String(describing: viewModel.error))")
        }
        XCTAssertNil(viewModel.articleDetail)
    }
}
