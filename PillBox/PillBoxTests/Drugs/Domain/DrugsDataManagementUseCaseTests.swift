import SwiftUI
import XCTest

@testable import PillBox

final class DrugsDataManagementUseCaseTests: XCTestCase {
    private var sut: DrugsDataManagementUseCase!
    private var repositoryMock: DrugsRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = DrugsRepositoryMock()
        sut = DrugsDataManagementUseCase(repository: repositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        super.tearDown()
    }

    func testFetchDrugsThenExpectedModel() {
        // Given
        let expectedModel = DrugModel(idDrug: "123",
                                      drug: "Any",
                                      avatar: nil,
                                      createdDate: nil,
                                      endDate: nil,
                                      isToogleOn: false,
                                      numberOfTimes: 4,
                                      timeUnit: 1,
                                      otherInformation: nil)
        // When
        let model = sut.fetchDrugs(user: "Any")
        // Then
        XCTAssertEqual(repositoryMock.fetchDrugsCallsCount, 1)
        XCTAssertEqual(model, [expectedModel])
    }
    
    func testUpdateAvatar() throws {
        // When
        try sut.updateAvatar(avatar: "Any", id: "Id", user: "user")
        // Then
        XCTAssertEqual(repositoryMock.updateAvatarCallsCount, 1)
    }
    
    func testDeleteData() throws {
        // When
        try sut.deleteData("id", user: "user")
        // Then
        XCTAssertEqual(repositoryMock.deleteDataCallsCount, 1)
    }
    
    func testSaveData() throws {
        // Given
        let model = DrugModel(idDrug: "123",
                              drug: "Any",
                              avatar: nil,
                              createdDate: nil,
                              endDate: nil,
                              isToogleOn: false,
                              numberOfTimes: 4,
                              timeUnit: 1,
                              otherInformation: nil)
        // When
        try sut.saveData(drug: model, user: "user")
        // Then
        XCTAssertEqual(repositoryMock.saveDataCallsCount, 1)
    }
    
    func testUpdateConfiguration() throws {
        // Given
        let model = DrugModel(idDrug: "123",
                              drug: "Any",
                              avatar: nil,
                              createdDate: nil,
                              endDate: nil,
                              isToogleOn: false,
                              numberOfTimes: 4,
                              timeUnit: 1,
                              otherInformation: nil)
        // When
        try sut.updateConfiguration(user: "user", drug: model)
        // Then
        XCTAssertEqual(repositoryMock.updateConfigurationCallsCount, 1)
    }
}

