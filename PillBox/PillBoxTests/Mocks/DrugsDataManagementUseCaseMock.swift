@testable import PillBox

final class DrugsDataManagementUseCaseMock: DrugsDataManagementUseCaseContract {
    private(set) var fetchDrugsCallsCount = 0
    private(set) var saveDataCallsCount = 0
    private(set) var deleteDataCallsCount = 0
    private(set) var updateAvatarCallsCount = 0
    private(set) var updateConfigurationCallsCount = 0
    private var models: [PillBox.DrugModel] = []
    
    func fetchDrugs(user: String) -> [PillBox.DrugModel]? {
        fetchDrugsCallsCount += 1
        return models
    }
    
    func saveData(drug: PillBox.DrugModel, user: String) throws {
        saveDataCallsCount += 1
        models.append(getModel())
    }
    
    func deleteData(_ id: String, user: String) throws {
        deleteDataCallsCount += 1
        models.removeAll { $0.idDrug == id }
    }
    
    func updateAvatar(avatar: String, id: String, user: String) throws {
        updateAvatarCallsCount += 1
        models.append(getModel(avatar: avatar))
    }
    
    func updateConfiguration(user: String, drug: PillBox.DrugModel) throws {
        updateConfigurationCallsCount += 1
    }
}

private extension DrugsDataManagementUseCaseMock {
    func getModel(avatar: String? = nil) -> DrugModel {
        DrugModel(idDrug: "123",
                  drug: "Any",
                  avatar: avatar,
                  createdDate: nil,
                  endDate: nil,
                  isToogleOn: false,
                  numberOfTimes: 4,
                  timeUnit: 1,
                  otherInformation: nil)
    }
}
