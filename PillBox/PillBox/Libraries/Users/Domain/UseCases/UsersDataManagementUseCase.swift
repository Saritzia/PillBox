protocol UsersDataManagementUseCaseContract {
    func fetchUsers() -> [UserModel]?
    func saveData(name: String, avatar: String) throws
    func deleteData(_ id: String) throws
    func updateAvatar(avatar: String, id: String) throws
}

final class UsersDataManagementUseCase: UsersDataManagementUseCaseContract {
    private var userRepository: UsersRepositoryContract
    
    init() {
        self.userRepository = UsersRepository()
    }
    
    func fetchUsers() -> [UserModel]? {
        userRepository.fetchUsers()
    }
    
    func saveData(name: String, avatar: String) throws {
        try userRepository.saveData(name: name, avatar: avatar)
    }
    
    func deleteData(_ id: String) throws {
        try userRepository.deleteData(id)
    }
    
    func updateAvatar(avatar: String, id: String) throws {
        try userRepository.updateData(avatar: avatar, id: id)
    }
}
