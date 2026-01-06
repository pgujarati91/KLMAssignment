import XCTest

final class KLMAssignmentUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.

        app.launchArguments = ["-mock-data"]
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testLoadingStateShowsLoader() throws {
        let loader = app.otherElements["loader"]
        XCTAssertTrue(loader.waitForExistence(timeout: 3.0))
    }
    
    func testEmptyStateShowsErrorView() throws {
        let errorView = app.staticTexts["No Article Found"].firstMatch
        XCTAssertTrue(errorView.waitForExistence(timeout: 3.0))
    }
    
    func testNavigationTitleDisplays() throws {
        let navTitle = app.navigationBars["Articles"].firstMatch
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2.0))
    }
}
