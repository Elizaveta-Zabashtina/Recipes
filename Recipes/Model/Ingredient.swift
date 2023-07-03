import Foundation
import RealmSwift

class Ingredient: Object {
    dynamic var id  = UUID()
    dynamic var name = ""
    dynamic var measure = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: UUID, name: String, measure: String) {
        self.init()
        self.id = id
        self.name = name
        self.measure = measure
    }
}
