import XCTest

class MenuUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testDemo1() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 0).tap()
        var element = tablesQuery.otherElements.staticTexts["3"]
        var present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
        element = tablesQuery.otherElements.staticTexts["4"]
        present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
    }
    
    func testDemo2() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 1).tap()
        let element = tablesQuery.cells.element(boundBy: 4)
        let present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
    }
    
    func testDemo3() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 2).tap()
        var element = tablesQuery.otherElements.staticTexts["3"]
        var present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
        element = tablesQuery.otherElements.staticTexts["4"]
        present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
    }
    
    func testDemo4() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 3).tap()
        let element = tablesQuery.otherElements.staticTexts["3"]
        let present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
    }
    
    func testDemo5() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 4).tap()
        let element = tablesQuery.otherElements.staticTexts["3"]
        let present = element.waitForExistence(timeout: 2.5)
        XCTAssertFalse(present)
    }
    
    func testDemo6() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 5).tap()
        var element = tablesQuery.children(matching: .cell).element(boundBy: 3).staticTexts["4"]
        var present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
        element = tablesQuery.children(matching: .cell).element(boundBy: 12).staticTexts["3"]
        present = element.waitForExistence(timeout: 2.5)
        XCTAssertTrue(present)
    }
    
    func testDemo7() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.element(boundBy: 6).tap()
        var element = tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts["2"]
        var present = element.waitForExistence(timeout: 2.5)
        XCTAssertFalse(present)
        element = tablesQuery.children(matching: .cell).element(boundBy: 8).staticTexts["3"]
        present = element.waitForExistence(timeout: 2.5)
        XCTAssertFalse(present)
    }
}
