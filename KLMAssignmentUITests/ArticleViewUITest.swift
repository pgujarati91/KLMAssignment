import Foundation
import XCTest
@testable import KLMAssignment  // Replace with your app's module name

final class ArticleViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-mock-data"]  // Enable ViewModel mocks if supported
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }
    
    func testLoadingStateShowsLoader() throws {
        let loader = app.otherElements["loader"]
        XCTAssertTrue(loader.waitForExistence(timeout: 3.0))
    }
    
    func testEmptyStateShowsErrorView() throws {
        // Given: Mock ViewModel with empty articles, not loading
        let errorView = app.staticTexts["No Article Found"].firstMatch
        XCTAssertTrue(errorView.waitForExistence(timeout: 3.0))
    }
    
    func testListDisplaysWithArticles() throws {
        // Given: Mock ViewModel with articles loaded
        app.launchArguments = ["-mock-data"]  // Enable ViewModel mocks if supported
        app.launch()
        
        let firstTable = app.tables.firstMatch
        
        // When/Then: List renders
        XCTAssertTrue(firstTable.waitForExistence(timeout: 3.0))
        XCTAssertEqual(firstTable.cells.count, 3)  // Adjust based on mock data count
    }
    
    func testArticleListHasAccessibilityIdentifier() throws {
        let list = app.scrollViews["articleList"].firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 2.0))
    }
    
    func testNavigationToDetail() throws {
        // Given: Articles loaded
        let table = app.tables.firstMatch
        let firstCell = table.cells.firstMatch
        
        // When: Tap first article row
        firstCell.tap()
        
        // Then: Detail view appears (adjust identifier if ArticleDetailView has one)
        let detailView = app.otherElements["articleDetail"]  // Add .accessibilityIdentifier("articleDetail") to detail
        XCTAssertTrue(detailView.waitForExistence(timeout: 3.0))
    }
    
    func testNavigationTitleDisplays() throws {
        let navTitle = app.navigationBars["Articles"].firstMatch
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2.0))
    }
}
