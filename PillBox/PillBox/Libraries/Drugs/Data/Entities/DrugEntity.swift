import Foundation
import RealmSwift

class DrugEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var _idDrug: ObjectId
    @Persisted var drugName:  String?
    @Persisted var avatar: String
    @Persisted var createdDate: Date
    @Persisted var endDate: Date?
    @Persisted var isToogleOn: Bool
    @Persisted var numberOfTimes: Int?
    @Persisted var timeUnit: Int?
    @Persisted var otherInformation: String?
    
    convenience init(drugName: String?,
                     endDate: Date? = nil,
                     isToogleOn: Bool = false,
                     numberOfTimes: Int? = nil,
                     timeUnit: Int? = nil,
                     otherInformation: String? = nil) {
        self.init()
        self.drugName = drugName
        self.createdDate = Date()
        self.avatar = "pillAvatar"
        self.endDate = endDate
        self.isToogleOn = isToogleOn
        self.numberOfTimes = numberOfTimes
        self.timeUnit = timeUnit
        self.otherInformation = otherInformation
    }
}
