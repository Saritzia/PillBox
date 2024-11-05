protocol UsersDataManagementUseCaseContract {
    func fetchUsers() -> [UserModel]?
    func saveData(name: String, avatar: String) throws
    func deleteData(_ id: String) throws
    func updateAvatar(avatar: String, id: String) throws
}

final class UsersDataManagementUseCase: UsersDataManagementUseCaseContract {
    private let usersRepository: UsersRepositoryContract
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    func fetchUsers() -> [UserModel]? {
        usersRepository.fetchUsers()
    }
    
    func saveData(name: String, avatar: String) throws {
        try usersRepository.saveData(name: name, avatar: avatar)
    }
    
    func deleteData(_ id: String) throws {
        try usersRepository.deleteData(id)
    }
    
    func updateAvatar(avatar: String, id: String) throws {
        try usersRepository.updateData(avatar: avatar, id: id)
    }
}
