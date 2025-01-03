@testable import PillBox

final class DrugsRepositoryMock: DrugsRepositoryContract {
    private(set) var fetchDrugsCallsCount = 0
    private(set) var saveDataCallsCount = 0
    private(set) var deleteDataCallsCount = 0
    private(set) var updateAvatarCallsCount = 0
    private(set) var updateConfigurationCallsCount = 0
    
    func fetchDrugs(user: String) -> [PillBox.DrugModel] {
        fetchDrugsCallsCount += 1
        return [model]
    }
    
    func saveData(drug: PillBox.DrugModel, user: String) throws {
        saveDataCallsCount += 1
    }
    
    func deleteData(_ id: String, user: String) throws {
        deleteDataCallsCount += 1
    }
    
    func updateData(avatar: String, id: String, user: String) throws {
        updateAvatarCallsCount += 1
    }
    
    func updateConfiguration(user: String, drug: PillBox.DrugModel) throws {
        updateConfigurationCallsCount += 1
    }
}

private extension DrugsRepositoryMock {
    var model: DrugModel {
        DrugModel(idDrug: "123",
                  drug: "Any",
                  avatar: nil,
                  createdDate: nil,
                  endDate: nil,
                  isToogleOn: false,
                  numberOfTimes: 4,
                  timeUnit: 1,
                  otherInformation: nil)
    }
}
