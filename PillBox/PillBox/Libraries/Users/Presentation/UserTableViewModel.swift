import Foundation

final class UserTableViewModel: ReusableTableViewModelContract {
    @Published var cellModels: [CellModel]?
    @Published var viewState: ViewState = .render
    private let usersDataManagementUseCase: UsersDataManagementUseCaseContract
    private(set) var currentTask: Task<Void, Error>?
    
    init() {
        self.usersDataManagementUseCase = UsersDataManagementUseCase()
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }

    @MainActor
    func fetchData() {
        viewState = .render
        cellModels = fetchUsers()?.map { userModel in
                CellModel(id: userModel.idUser,
                          title: userModel.name,
                          avatar: userModel.avatar)
        } ?? []
    }
}

private extension UserTableViewModel {
    func fetchUsers() -> [UserModel]? {
        usersDataManagementUseCase.fetchUsers()
    }
    
    func saveData(name: String) {
        do {
            try usersDataManagementUseCase.saveData(name: name, avatar: "womanAvatar")
        } catch {
            viewState = .error { [weak self] in
                self?.saveData(name: name)
            }
        }
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
}
// MARK: - Add button delegate
extension UserTableViewModel: AddButtonDelegateContract {
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
         "manAvatar",
         "boyAvatar"]
    }
    
    func updateAvatar(avatar: String, cellId: String) {
        do {
            try usersDataManagementUseCase.updateAvatar(avatar: avatar, id: cellId)
        } catch {
            viewState = .error { [weak self] in
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
extension UserTableViewModel: SwipableCellDelegateContract {
    func onSwipe(id: String) {
        do {
            try usersDataManagementUseCase.deleteData(id)
        } catch {
            viewState = .error { [weak self] in
                self?.onSwipe(id: id)
            }
        }
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
}

