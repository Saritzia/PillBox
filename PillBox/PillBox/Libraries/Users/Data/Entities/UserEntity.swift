import RealmSwift

final class UserEntity: Object {
    @Persisted(primaryKey: true) var idUser : ObjectId
    @Persisted var name: String
    @Persisted var avatar: String
    @Persisted var drugs : List<DrugEntity>
    
    convenience init(name: String, avatar: String) {
        self.init()
        idUser = ObjectId.generate()
        self.avatar = avatar
        self.name = name
    }
}
