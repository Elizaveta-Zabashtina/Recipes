import Foundation
import RealmSwift

class RecipeStep: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var number = 0
    @Persisted var step = ""
    @Persisted var image = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: ObjectId, number: Int, step: String, image: String) {
        self.init()
        self.id = id
        self.number = number
        self.step = step
        self.image = image
    }
}
