import Foundation
import RealmSwift

class DrugEntity: Object {
    @Persisted(primaryKey: true) var idDrug : ObjectId
    @Persisted var drugName : String
    @Persisted var avatar: String
    @Persisted var date : Date
    @Persisted(originProperty: "drugs") var userLink : LinkingObjects<UserEntity>
    
    convenience init(drugName: String) {
        self.init()
        self.idDrug = ObjectId.generate()
        self.drugName = drugName
        self.date = Date()
        self.avatar = "pillAvatar"
    }
    // @Persisted var configuration : ConfigurationModel?
}
