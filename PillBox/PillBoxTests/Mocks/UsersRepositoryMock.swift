@testable import PillBox

final class UsersRepositoryMock: UsersRepositoryContract {
    private(set) var fetchUserCallsCount = 0
    private(set) var saveUserCallsCount = 0
    private(set) var deleteUserCallsCount = 0
    private(set) var updateUserCallsCount = 0
    
    func fetchUsers() -> [PillBox.UserModel] {
        fetchUserCallsCount += 1
        return [UserModel(idUser: "Any", name: "Any", avatar: "womenAvatar")]
    }
    
    func saveData(name: String, avatar: String) throws {
        saveUserCallsCount += 1
    }
    
    func deleteData(_ id: String) throws {
        deleteUserCallsCount += 1
    }
    
    func updateData(avatar: String, id: String) throws {
        updateUserCallsCount += 1
    }
}
