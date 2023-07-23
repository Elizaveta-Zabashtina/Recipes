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
    @Persisted var ingredients = List<Ingredient>()
    @Persisted var steps = List<RecipeStep>()
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: ObjectId, name: String, recipeDescription: String,
                     image: String, created: Date, category: Category,
                     ingredients: List<Ingredient>, steps: List<RecipeStep>) {
        self.init()
        self.id = id
        self.name = name
        self.recipeDescription = recipeDescription
        self.image = image
        self.created = created
        self.category = category
        self.ingredients = ingredients
        self.steps = steps
    }
}
