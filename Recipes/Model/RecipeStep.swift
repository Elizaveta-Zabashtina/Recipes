import Foundation
import RealmSwift

class RecipeStep: Object {
    dynamic var id = UUID()
    dynamic var number = 0
    dynamic var step = ""
    dynamic var image = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: UUID, number: Int, step: String, image: String) {
        self.init()
        self.id = id
        self.number = number
        self.step = step
        self.image = image
    }
}
