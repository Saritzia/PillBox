import Foundation
import RealmSwift

final class DrugsConfigurationViewModel: ObservableObject {
    @Published var drugModel: DrugModel?
    @Published var viewState: ViewState = .render
    private(set) var userId: String
    private let drugId: String?
    private let drugsDataManagementUseCase: DrugsDataManagementUseCaseContract
    private var currentTask: Task<Void, Error>?
    
    init(userId: String, drugId: String? = nil) {
        self.userId = userId
        self.drugId = drugId
        self.drugsDataManagementUseCase = DrugsDataManagementUseCase()
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
    
    @MainActor
    func fetchData() {
        viewState = .render
        guard let drugId else {
            viewState = .render
            return
        }
        if let drugModel = self.fetchDrugs(user: self.userId)?.filter({ $0.idDrug == drugId }).first {
            viewState = .update(model: drugModel)
        }
    }
    
    @MainActor
    func saveDrug(with model: DrugModel) {
        if let drugId {
            let newConfigurationModel = DrugModel(idDrug: drugId,
                                                  drug: model.drug,
                                                  endDate: model.endDate,
                                                  isToogleOn: model.isToogleOn,
                                                  numberOfTimes: model.numberOfTimes,
                                                  timeUnit: model.timeUnit,
                                                  otherInformation: model.otherInformation)
            saveConfiguration(drugModel: newConfigurationModel, userId: userId)
        } else {
            saveData(drugModel: model, userId: userId)
        }
    }
}

private extension DrugsConfigurationViewModel {
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsDataManagementUseCase.fetchDrugs(user: user)
    }
    
    func saveData(drugModel: DrugModel, userId: String) {
        do {
            try drugsDataManagementUseCase.saveData(drug: drugModel, user: userId)
        } catch {
            viewState = .error { [weak self] in
                self?.saveData(drugModel: drugModel, userId: userId)
            }
        }
    }
    
    func saveConfiguration(drugModel: DrugModel, userId: String) {
        do {
            try drugsDataManagementUseCase.updateConfiguration(user: userId, drug: drugModel)
        } catch {
            viewState = .error { [weak self] in
                self?.saveConfiguration(drugModel: drugModel, userId: userId)
            }
        }
    }
}
