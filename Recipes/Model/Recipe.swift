import Foundation
import RealmSwift

class Recipe: Object {
    dynamic var id = UUID()
    dynamic var name = ""
    dynamic var recipeDescription = ""
    dynamic var image = ""
    dynamic var numberOfServings = 0
    dynamic var created = Date()
    dynamic var category: Category!
    var ingridients = List<Ingredient>()
    var steps = List<RecipeStep>()
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: UUID, name: String, recipeDescription: String, image: String,
                     numberOfServings: Int, created: Date, category: Category,
                     ingridients: [Ingredient], steps: [RecipeStep]) {
        self.init()
        self.id = id
        self.name = name
        self.recipeDescription = recipeDescription
        self.image = image
        self.numberOfServings = numberOfServings
        self.created = created
        self.category = category
        for ingridient in ingridients {
            self.ingridients.append(ingridient)
        }
        for step in steps {
            self.steps.append(step)
        }
    }
}
