import RealmSwift

protocol DrugsRepositoryContract {
    func fetchDrugs(user: String) -> [DrugModel]
    func saveData(drug: DrugModel, user: String) throws
    func deleteData(_ id: String, user: String) throws
    func updateData(avatar: String, id: String, user: String) throws
    func updateConfiguration(user: String, drug: DrugModel) throws
}

final class DrugsRepository: DrugsRepositoryContract {
    let realm = try! Realm()
    
    func fetchDrugs(user: String) -> [DrugModel] {
        realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.compactMap { entity in
            DrugModel(idDrug: entity._idDrug.stringValue,
                      drug: entity.drugName,
                      avatar: entity.avatar,
                      createdDate: entity.createdDate,
                      endDate: entity.endDate,
                      isToogleOn: entity.isToogleOn,
                      numberOfTimes: entity.numberOfTimes,
                      timeUnit: entity.timeUnit,
                      otherInformation: entity.otherInformation)
        } ?? []
    }

    func saveData(drug: DrugModel, user: String) throws {
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user })
                .first?.drugs.append(DrugEntity(drugName: drug.drug,
                                                endDate: drug.endDate,
                                                isToogleOn: drug.isToogleOn,
                                                numberOfTimes: drug.numberOfTimes,
                                                timeUnit: drug.timeUnit,
                                                otherInformation: drug.otherInformation))
        }
    }
    
    func updateData(avatar: String, id: String, user: String) throws {
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.filter { $0._idDrug.stringValue == id }.first?.avatar = avatar
        }
    }
    
    func updateConfiguration(user: String, drug: DrugModel) throws {
        let selectedDrug = realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user })
            .first?.drugs.filter { $0._idDrug.stringValue == drug.idDrug }.first
        try realm.write {
            selectedDrug?.endDate = drug.endDate
            selectedDrug?.isToogleOn = drug.isToogleOn
            selectedDrug?.numberOfTimes = drug.numberOfTimes
            selectedDrug?.timeUnit = drug.timeUnit
            selectedDrug?.otherInformation = drug.otherInformation
        }
    }
    
    func deleteData(_ id: String, user: String) throws {
        let realmObject = realm.objects(DrugEntity.self).filter { $0._idDrug.stringValue == id }
        try realm.write {
            realm.objects(UserEntity.self).filter({ $0._idUser.stringValue == user }).first?.drugs.realm?.delete(realmObject)
        }
    }
}
