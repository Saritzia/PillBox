import Foundation
import RealmSwift

final class DrugsTableViewModel: ReusableTableViewModelContract {
    //MARK: - Properties
    @Published var cellModels: [CellModel]?
    private let user: String
    private let drugsDataManagementUseCase: DrugsDataManagementUseCaseContract
    
    
    //MARK: - Init
    init(user: String) {
        self.user = user
        self.drugsDataManagementUseCase = DrugsDataManagementUseCase()
        fetchData()
    }
    
    // MARK: - Functions
    func fetchData() {
        Task { @MainActor in
            cellModels = fetchDrugs(user: user)?.map { drugModel in
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
            try drugsDataManagementUseCase.saveData(drug: name)
        } catch {
            // navegar a pantalla de error
        }
        fetchData()
    }
}
// MARK: - Add button delegate
extension DrugsTableViewModel: AddButtonDelegateContract {
    @MainActor
    func addAction(name: String) {
        saveData(name: name)
    }
}
// MARK: - Avatar picker delegate
extension DrugsTableViewModel: AvatarPickerProtocol {
    var images: [String] {
        ["dropAvatar",
         "pillAvatar",
         "syrupAvatar",
        ]
    }
    
    func updateAvatar(avatar: String, cellId: String) {
        do {
            try drugsDataManagementUseCase.updateAvatar(avatar: avatar, id: cellId)
        } catch {
            // navegar a error
        }
        fetchData()
    }
}
// MARK: - Swipable cell delegate
extension DrugsTableViewModel: SwipableCellDelegateContract {
    func onSwipe(id: String) {
        do {
            try drugsDataManagementUseCase.deleteData(id)
        } catch {
            // navegar a pantalla de error
        }
        fetchData()
    }
}
