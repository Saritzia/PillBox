import RealmSwift

protocol DrugsRepositoryContract {
    func fetchDrugs(user: String) -> [DrugModel]
    func saveData(drug: String, user: String) throws
    func deleteData(_ id: String, user: String) throws
    func updateData(avatar: String, id: String, user: String) throws
}

final class DrugsRepository: DrugsRepositoryContract {
    let realm = try! Realm()
    
    func fetchDrugs(user: String) -> [DrugModel] {
        realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.compactMap { entity in
            DrugModel(idDrug: entity._idDrug.stringValue,
                      drug: entity.drugName,
                      avatar: entity.avatar,
                      date: entity.date)
        } ?? []
    }

    func saveData(drug: String, user: String) throws {
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.append(DrugEntity(drugName: drug))
        }
    }
    
    func updateData(avatar: String, id: String, user: String) throws {
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.filter { $0._idDrug.stringValue == id }.first?.avatar = avatar
        }
    }
    
    func deleteData(_ id: String, user: String) throws {
        let realmObject = realm.objects(DrugEntity.self).filter { $0._idDrug.stringValue == id }
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.realm?.delete(realmObject)
        }
    }
}
