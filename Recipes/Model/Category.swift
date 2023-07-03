import Foundation
import RealmSwift

class Category: Object {
    dynamic var id  = UUID()
    dynamic var name = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: UUID, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
