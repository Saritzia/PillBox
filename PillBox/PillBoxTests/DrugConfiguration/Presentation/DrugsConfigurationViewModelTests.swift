import SwiftUI
import XCTest

@testable import PillBox

final class DrugsConfigurationViewModelTests: XCTestCase {
    private var sut: DrugsConfigurationViewModel!
    private var useCaseMock: DrugsDataManagementUseCaseMock!
    
    override func setUp() {
        super.setUp()
        useCaseMock = DrugsDataManagementUseCaseMock()
        sut = DrugsConfigurationViewModel(userId: "Any",
                                          drugId: "123",
                                          drugsDataManagementUseCase: useCaseMock)
    }
    
    override func tearDown() {
        sut = nil
        useCaseMock = nil
        super.tearDown()
    }

    @MainActor
    func testGivenNewModelWhenSaveDataThenSaveNewDrug() throws {
        // Given
        sut = DrugsConfigurationViewModel(userId: "Any", drugId: nil, drugsDataManagementUseCase: useCaseMock)
        let newModel = DrugModel(idDrug: "234",
                                 drug: "Any",
                                 avatar: nil,
                                 createdDate: nil,
                                 endDate: nil,
                                 isToogleOn: false,
                                 numberOfTimes: 4,
                                 timeUnit: 1,
                                 otherInformation: nil)
        // When
        sut.saveDrug(with: newModel)
        // Then
        XCTAssertEqual(useCaseMock.saveDataCallsCount, 1)
    }
    
    @MainActor
    func testGivenSavedModelWhenSaveDataThenSaveNewConfiguration() throws {
        // Given
        let newModel = DrugModel(idDrug: "123",
                                 drug: "Any",
                                 avatar: nil,
                                 createdDate: nil,
                                 endDate: nil,
                                 isToogleOn: true,
                                 numberOfTimes: 4,
                                 timeUnit: 1,
                                 otherInformation: nil)
        // When
        sut.saveDrug(with: newModel)
        // Then
        XCTAssertEqual(useCaseMock.updateConfigurationCallsCount, 1)
    }
}
