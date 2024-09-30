import RealmSwift

protocol UsersRepositoryContract {
    func fetchUsers() -> [UserModel]
    func saveData(name: String, avatar: String) throws
    func deleteData(_ id: String) throws
    func updateData(avatar: String, id: String) throws
}

class UsersRepository: UsersRepositoryContract {
    let realm = try! Realm()
    
    func fetchUsers() -> [UserModel] {
        realm.objects(UserEntity.self).compactMap { entity in
            UserModel(idUser: entity.idUser.stringValue,
                      name: entity.name,
                      avatar: entity.avatar)
        }
    }

    func saveData(name: String, avatar: String) throws {
        try realm.write {
            realm.add(UserEntity(name: name, avatar: avatar))
        }
    }
    
    func updateData(avatar: String, id: String) throws {
        let realmObject = realm.objects(UserEntity.self).filter { $0.idUser.stringValue == id }
        try realm.write {
            realmObject.first?.avatar = avatar
        }
    }
    
    func deleteData(_ id: String) throws {
        let realmObject = realm.objects(UserEntity.self).filter { $0.idUser.stringValue == id }
        try realm.write {
            realm.delete(realmObject)
        }
    }
}
