import Foundation
import RealmSwift

class Ingredient: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var measure = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: ObjectId, name: String, measure: String) {
        self.init()
        self.id = id
        self.name = name
        self.measure = measure
    }
}
