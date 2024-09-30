protocol DrugsDataManagementUseCaseContract {
    func fetchDrugs(user: String) -> [DrugModel]?
    func saveData(drug: String) throws
    func deleteData(_ id: String) throws
    func updateAvatar(avatar: String, id: String) throws
}

final class DrugsDataManagementUseCase: DrugsDataManagementUseCaseContract {
    private var drugsRepository: DrugsRepositoryContract
    
    init() {
        self.drugsRepository = DrugsRepository()
    }
    
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsRepository.fetchDrugs(user: user)
    }
    
    func saveData(drug: String) throws {
        try drugsRepository.saveData(drug: drug)
    }
    
    func deleteData(_ id: String) throws {
        try drugsRepository.deleteData(id)
    }
    
    func updateAvatar(avatar: String, id: String) throws {
        try drugsRepository.updateData(avatar: avatar, id: id)
    }
}
