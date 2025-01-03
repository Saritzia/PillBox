import SwiftUI
import XCTest

@testable import PillBox

final class DrugsTableViewModelTests: XCTestCase {
    private var sut: DrugsTableViewModel!
    private var useCaseMock: DrugsDataManagementUseCaseMock!
    
    override func setUp() {
        super.setUp()
        useCaseMock = DrugsDataManagementUseCaseMock()
        sut = DrugsTableViewModel(userId: "Any",
                                  useCase: useCaseMock)
    }
    
    override func tearDown() {
        sut = nil
        useCaseMock = nil
        super.tearDown()
    }

    @MainActor
    func testGivenAnUserWhenFetchDataThenExpectedModel() throws {
        // Given
        try useCaseMock.saveData(drug: DrugModel(drug: "Any"), user: "Any")
        let expectedCell = CellModel(id: "123",
                                    title: "Any",
                                    avatar: "dropAvatar")
        // When
        sut.fetchData()
        // Then
        XCTAssertEqual(useCaseMock.fetchDrugsCallsCount, 1)
        XCTAssertEqual(sut.cellModels, [expectedCell])
    }
    
    func testGivenAnUserWhenUpdateAvatarThenFetchData() async throws {
        // Given
        let expectedCell = CellModel(id: "123",
                                    title: "Any",
                                    avatar: "pillAvatar")
        // When
        sut.updateAvatar(avatar: "pillAvatar", cellId: "Any")
        try await sut.currentTask?.value
        // Then
        XCTAssertEqual(useCaseMock.updateAvatarCallsCount, 1)
        XCTAssertEqual(useCaseMock.fetchDrugsCallsCount, 2)
        XCTAssertEqual(sut.cellModels, [expectedCell])
    }
    
    @MainActor
    func testGivenAnUserWhenSwipeACellThenDeletedData() async throws {
        // Given
        try useCaseMock.saveData(drug: DrugModel(drug: "Any"), user: "Any")
        // When
        sut.onSwipe(id: "123")
        try await sut.currentTask?.value
        // Then
        XCTAssertEqual(useCaseMock.deleteDataCallsCount, 1)
        XCTAssertEqual(useCaseMock.fetchDrugsCallsCount, 2)
        XCTAssertEqual(sut.cellModels, [])
    }
}
