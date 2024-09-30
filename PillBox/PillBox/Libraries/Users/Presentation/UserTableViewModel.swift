import Foundation

final class UserTableViewModel: ReusableTableViewModelContract {
    // MARK: - Properties
    @Published var cellModels: [CellModel]?
    private var usersDataManagementUseCase: UsersDataManagementUseCaseContract
    
    //MARK: - Init
    init() {
        self.usersDataManagementUseCase = UsersDataManagementUseCase()
        fetchData()
    }
    
    // MARK: - Functions
    func fetchData() {
        Task { @MainActor in
            cellModels = fetchUsers()?.map { userModel in
                CellModel(id: userModel.idUser,
                            title: userModel.name,
                            avatar: userModel.avatar)
            } ?? []
        }
    }
}

private extension UserTableViewModel {
    @MainActor
    func fetchUsers() -> [UserModel]? {
        usersDataManagementUseCase.fetchUsers()
    }
    
    @MainActor
    func saveData(name: String) {
        do {
            try usersDataManagementUseCase.saveData(name: name, avatar: "womanAvatar")
        } catch {
            // navegar a pantalla de error
        }
        fetchData()
    }
    
    func updateData(name: String, avatar: String) {
        
    }
}
// MARK: - Add button delegate
extension UserTableViewModel: AddButtonDelegateContract {
    @MainActor
    func addAction(name: String) {
        saveData(name: name)
    }
}
// MARK: - Avatar picker delegate
extension UserTableViewModel: AvatarPickerProtocol {
    var images: [String] {
        ["womanAvatar",
         "oldWomanAvatar",
         "oldManAvatar",
         "boyAvatar"]
    }
    
    func updateAvatar(avatar: String, cellId: String) {
        do {
            try usersDataManagementUseCase.updateAvatar(avatar: avatar, id: cellId)
        } catch {
            // navegar a error
        }
        fetchData()
    }
}
// MARK: - Swipable cell delegate
extension UserTableViewModel: SwipableCellDelegateContract {
    func onSwipe(id: String) {
        do {
            try usersDataManagementUseCase.deleteData(id)
        } catch {
            // navegar a pantalla de error
        }
        fetchData()
    }
}

