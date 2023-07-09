import Foundation
import RealmSwift

class Recipe: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var recipeDescription = ""
    @Persisted var image = ""
    @Persisted var numberOfServings = 0
    @Persisted var created = Date()
    @Persisted var category: Category!
    var ingridients = List<Ingredient>()
    var steps = List<RecipeStep>()
    override static func primaryKey() -> String? {
        return "id"
    }
}
