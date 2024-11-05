import Foundation
import RealmSwift

final class DrugsTableViewModel: ReusableTableViewModelContract {
    @Published var cellModels: [CellModel]?
    @Published var viewSate: ViewState = .render
    private let userId: String
    private let drugsDataManagementUseCase: DrugsDataManagementUseCaseContract
    
    init(userId: String) {
        self.userId = userId
        self.drugsDataManagementUseCase = DrugsDataManagementUseCase()
        fetchData()
    }
    
    func fetchData() {
        viewSate = .render
        Task { @MainActor in
            cellModels = fetchDrugs(user: userId)?.map { drugModel in
                CellModel(id: drugModel.idDrug,
                          title: drugModel.drug,
                          avatar: drugModel.avatar)
            } ?? []
        }
    }
}

private extension DrugsTableViewModel {
    @MainActor
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsDataManagementUseCase.fetchDrugs(user: user)
    }
    
    @MainActor
    func saveData(name: String) {
        do {
            try drugsDataManagementUseCase.saveData(drug: name, user: userId)
        } catch {
            viewSate = .error { [weak self] in
                self?.saveData(name: name)
            }
        }
        fetchData()
    }
}
// MARK: - Avatar picker delegate
extension DrugsTableViewModel: AvatarPickerProtocol {
    var images: [String] {
        ["dropAvatar",
         "pillAvatar",
         "syrupAvatar"]
    }
    
    func updateAvatar(avatar: String, cellId: String) {
        do {
            try drugsDataManagementUseCase.updateAvatar(avatar: avatar, id: cellId, user: userId)
        } catch {
            viewSate = .error { [weak self] in
                self?.updateAvatar(avatar: avatar, cellId: cellId)
            }
        }
        fetchData()
    }
}
// MARK: - Swipable cell delegate
extension DrugsTableViewModel: SwipableCellDelegateContract {
    func onSwipe(id: String) {
        do {
            try drugsDataManagementUseCase.deleteData(id, user: userId)
        } catch {
            viewSate = .error { [weak self] in
                self?.onSwipe(id: id)
            }
        }
        fetchData()
    }
}
