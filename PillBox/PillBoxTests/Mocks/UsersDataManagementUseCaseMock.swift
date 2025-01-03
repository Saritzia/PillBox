@testable import PillBox

final class UsersDataManagementUseCaseMock: UsersDataManagementUseCaseContract {
    private(set) var fetchUserCallsCount = 0
    private(set) var saveUserCallsCount = 0
    private(set) var deleteUserCallsCount = 0
    private(set) var updateUserCallsCount = 0
    private var users: [UserModel] = []
    
    func fetchUsers() -> [PillBox.UserModel]? {
        fetchUserCallsCount += 1
        return users
    }
    
    func saveData(name: String, avatar: String) throws {
        saveUserCallsCount += 1
        users.append(getUser())
    }
    
    func deleteData(_ id: String) throws {
        deleteUserCallsCount += 1
        users.removeAll { $0.idUser == id }
    }
    
    func updateAvatar(avatar: String, id: String) throws {
        updateUserCallsCount += 1
        users.append(getUser(avatar: "manAvatar"))
    }
}

private extension UsersDataManagementUseCaseMock {
    func getUser(avatar: String = "womanAvatar") -> UserModel {
        UserModel(idUser: "Any", name: "Any", avatar: avatar)
    }
}
