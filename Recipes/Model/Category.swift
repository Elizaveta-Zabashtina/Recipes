import Foundation
import RealmSwift

class Category: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
