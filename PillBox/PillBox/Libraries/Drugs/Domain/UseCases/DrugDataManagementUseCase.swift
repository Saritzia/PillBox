protocol DrugsDataManagementUseCaseContract {
    func fetchDrugs(user: String) -> [DrugModel]?
    func saveData(drug: DrugModel, user: String) throws
    func deleteData(_ id: String, user: String) throws
    func updateAvatar(avatar: String, id: String, user: String) throws
    func updateConfiguration(user: String, drug: DrugModel) throws
}

final class DrugsDataManagementUseCase: DrugsDataManagementUseCaseContract {
    private let drugsRepository: DrugsRepositoryContract
    
    init() {
        self.drugsRepository = DrugsRepository()
    }
    
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsRepository.fetchDrugs(user: user)
    }
    
    func saveData(drug: DrugModel, user: String) throws {
        try drugsRepository.saveData(drug: drug, user: user)
    }
    
    func deleteData(_ id: String, user: String) throws {
        try drugsRepository.deleteData(id, user: user)
    }
    
    func updateAvatar(avatar: String, id: String, user: String) throws {
        try drugsRepository.updateData(avatar: avatar, id: id, user: user)
    }
    
    func updateConfiguration(user: String, drug: DrugModel) throws {
        try drugsRepository.updateConfiguration(user: user, drug: drug)
    }
}
