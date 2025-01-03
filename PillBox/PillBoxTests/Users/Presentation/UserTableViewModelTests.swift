import SwiftUI
import XCTest

@testable import PillBox

final class UserTableViewModelTests: XCTestCase {
    private var sut: UserTableViewModel!
    private var useCaseMock: UsersDataManagementUseCaseMock!
    
    override func setUp() {
        super.setUp()
        useCaseMock = UsersDataManagementUseCaseMock()
        sut = UserTableViewModel(useCase: useCaseMock)
    }
    
    override func tearDown() {
        sut = nil
        useCaseMock = nil
        super.tearDown()
    }

    @MainActor
    func testWhenFetchDataThenExpectedModel() throws {
        // Given
        try useCaseMock.saveData(name: "Any", avatar: "womanAvatar")
        let expectedCell = CellModel(id: "Any",
                                    title: "Any",
                                    avatar: "womanAvatar")
        // When
        sut.fetchData()
        // Then
        XCTAssertEqual(useCaseMock.fetchUserCallsCount, 1)
        XCTAssertEqual(sut.cellModels, [expectedCell])
    }
    
    func testWhenUpdateAvatarThenFetchData() async throws {
        // Given
        let expectedCell = CellModel(id: "Any",
                                    title: "Any",
                                    avatar: "manAvatar")
        // When
        sut.updateAvatar(avatar: "manAvatar", cellId: "Any")
        try await sut.currentTask?.value
        // Then
        XCTAssertEqual(useCaseMock.updateUserCallsCount, 1)
        XCTAssertEqual(useCaseMock.fetchUserCallsCount, 2)
        XCTAssertEqual(sut.cellModels, [expectedCell])
    }
    
    func testWhenSaveAUserThenFetchData() async throws {
        // Given
        let expectedCell = CellModel(id: "Any",
                                    title: "Any",
                                    avatar: "womanAvatar")
        // When
        await sut.addAction(name: "Any")
        try await sut.currentTask?.value
        // Then
        XCTAssertEqual(useCaseMock.saveUserCallsCount, 1)
        XCTAssertEqual(useCaseMock.fetchUserCallsCount, 2)
        XCTAssertEqual(sut.cellModels, [expectedCell])
    }
    
    func testWhenSwipeACellThenDeletedData() async throws {
        // Given
        try useCaseMock.saveData(name: "Any", avatar: "womanAvatar")
        // When
        sut.onSwipe(id: "Any")
        try await sut.currentTask?.value
        // Then
        XCTAssertEqual(useCaseMock.deleteUserCallsCount, 1)
        XCTAssertEqual(useCaseMock.fetchUserCallsCount, 2)
        XCTAssertEqual(sut.cellModels, [])
    }
}
