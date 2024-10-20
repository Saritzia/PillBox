protocol DrugsDataManagementUseCaseContract {
    func fetchDrugs(user: String) -> [DrugModel]?
    func saveData(drug: String, user: String) throws
    func deleteData(_ id: String, user: String) throws
    func updateAvatar(avatar: String, id: String, user: String) throws
}

final class DrugsDataManagementUseCase: DrugsDataManagementUseCaseContract {
    private var drugsRepository: DrugsRepositoryContract
    
    init() {
        self.drugsRepository = DrugsRepository()
    }
    
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsRepository.fetchDrugs(user: user)
    }
    
    func saveData(drug: String, user: String) throws {
        try drugsRepository.saveData(drug: drug, user: user)
    }
    
    func deleteData(_ id: String, user: String) throws {
        try drugsRepository.deleteData(id, user: user)
    }
    
    func updateAvatar(avatar: String, id: String, user: String) throws {
        try drugsRepository.updateData(avatar: avatar, id: id, user: user)
    }
}
