import Foundation
import RealmSwift

final class DrugsTableViewModel: ReusableTableViewModelContract {
    @Published var cellModels: [CellModel]?
    @Published var viewSate: ViewState = .render
    private(set) var userId: String
    private let drugsDataManagementUseCase: DrugsDataManagementUseCaseContract
    private(set) var currentTask: Task <Void, Error>?
    
    init(userId: String) {
        self.userId = userId
        self.drugsDataManagementUseCase = DrugsDataManagementUseCase()
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
    
    @MainActor
    func fetchData() {
        viewSate = .render
        cellModels = fetchDrugs(user: userId)?.map { drugModel in
                CellModel(id: drugModel.idDrug ?? "",
                          title: drugModel.drug ?? "",
                          avatar: drugModel.avatar ?? "dropAvatar")
        } ?? []
    }
}

private extension DrugsTableViewModel {
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsDataManagementUseCase.fetchDrugs(user: user)
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
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
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
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
}
