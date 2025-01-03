import SwiftUI
import XCTest

@testable import PillBox

final class RouterTests: XCTestCase {
    private var sut: Router!
    
    override func setUp() {
        super.setUp()
        sut = Router()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGivenDestinationWhenNavigateToThenNavigationPathIsNotEmpty() throws {
        // Given
        let destination: Router.Destination = .successScreen
        // When
        sut.navigate(to: destination)
        // Then
        XCTAssertEqual(sut.navigationPath.count, 1)
    }

    func testGivenNavigationWhenNavigateBackThenNavigationPathIsEmpty() throws {
        // Given
        givenNavigationStack()
        // When
        sut.navigateBack()
        // Then
        XCTAssertTrue(sut.navigationPath.isEmpty)
    }
    
    func testGivenNavigationWhenNavigateBackBeforeSuccessThenRemoveLastTwo() throws {
        // Given
        givenSuccessNavigationStack()
        // When
        sut.navigateBackBeforeSuccess()
        // Then
        XCTAssertEqual(sut.navigationPath.count, 1)
    }
    
    func testGivenNavigationWhenNavigateToRootThenNavigationPathIsEmpty() throws {
        // Given
        givenSuccessNavigationStack()
        // When
        sut.navigateToRoot()
        // Then
        XCTAssertTrue(sut.navigationPath.isEmpty)
    }
}

private extension RouterTests {
    func givenNavigationStack() {
        sut.navigationPath.append(Router.Destination.successScreen)
    }
    
    func givenSuccessNavigationStack() {
        sut.navigationPath.append(Router.Destination.drugTableView(id: "Any"))
        sut.navigationPath.append(Router.Destination.drugConfiguration(userId: "Any", drugId: "Any"))
        sut.navigationPath.append(Router.Destination.successScreen)
    }
}
