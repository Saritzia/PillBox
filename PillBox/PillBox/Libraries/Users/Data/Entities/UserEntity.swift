import RealmSwift

final class UserEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var _idUser : ObjectId
    @Persisted var name: String
    @Persisted var avatar: String
    @Persisted var drugs : List<DrugEntity>
    
    convenience init(name: String, avatar: String) {
        self.init()
        self.avatar = avatar
        self.name = name
    }
}
