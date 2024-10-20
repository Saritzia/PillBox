import Foundation
import RealmSwift

class DrugEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var _idDrug : ObjectId
    @Persisted var drugName : String
    @Persisted var avatar: String
    @Persisted var date : Date
    
    convenience init(drugName: String) {
        self.init()
        self.drugName = drugName
        self.date = Date()
        self.avatar = "pillAvatar"
    }
    // @Persisted var configuration : ConfigurationModel?
}
