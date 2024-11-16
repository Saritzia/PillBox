import Foundation

struct DrugModel: Equatable {
    let idDrug : String?
    let drug: String?
    let avatar: String?
    let createdDate: Date?
    let endDate: Date?
    let isToogleOn: Bool
    let numberOfTimes: Int?
    let timeUnit: Int?
    let otherInformation: String?
    
    init(idDrug: String? = nil,
         drug: String?,
         avatar: String? = nil,
         createdDate: Date? = nil,
         endDate: Date? = nil,
         isToogleOn: Bool = false,
         numberOfTimes: Int? = nil,
         timeUnit: Int? = nil,
         otherInformation: String? = nil) {
        self.idDrug = idDrug
        self.drug = drug
        self.avatar = avatar
        self.createdDate = createdDate
        self.endDate = endDate
        self.isToogleOn = isToogleOn
        self.numberOfTimes = numberOfTimes
        self.timeUnit = timeUnit
        self.otherInformation = otherInformation
    }
}
