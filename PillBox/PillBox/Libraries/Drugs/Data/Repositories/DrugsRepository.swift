import RealmSwift

protocol DrugsRepositoryContract {
    func fetchDrugs(user: String) -> [DrugModel]
    func saveData(drug: String) throws
    func deleteData(_ id: String) throws
    func updateData(avatar: String, id: String) throws
}

final class DrugsRepository: DrugsRepositoryContract {
    let realm = try! Realm()
    
    func fetchDrugs(user: String) -> [DrugModel] {
        realm.objects(DrugEntity.self).compactMap { entity in
            DrugModel(idDrug: entity.idDrug.stringValue,
                      drug: entity.drugName,
                      avatar: entity.avatar,
                      date: entity.date)
        }
    }

    func saveData(drug: String) throws {
        try realm.write {
            realm.add(DrugEntity(drugName: drug))
        }
    }
    
    func updateData(avatar: String, id: String) throws {
        let realmObject = realm.objects(DrugEntity.self).filter { $0.idDrug.stringValue == id }
        try realm.write {
            realmObject.first?.avatar = avatar
        }
    }
    
    func deleteData(_ id: String) throws {
        let realmObject = realm.objects(DrugEntity.self).filter { $0.idDrug.stringValue == id }
        try realm.write {
            realm.delete(realmObject)
        }
    }
}
