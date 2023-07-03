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
    
    //устанавливаем PK
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //статический метод для быстрой инициализации
    static func getRecipeObject(id: UUID, name: String, recipeDescription: String, image: String, numberOfServings: Int,  created: Date, category: Category, ingridients: [Ingredient], steps: [RecipeStep]) -> Recipe {
        let recipe = Recipe()
        
        recipe.id = id
        recipe.name = name
        recipe.recipeDescription = recipeDescription
        recipe.image = image
        recipe.numberOfServings = numberOfServings
        recipe.created = created
        recipe.category = category
        for ingridient in ingridients {
            recipe.ingridients.append(ingridient)
        }
        for step in steps {
            recipe.steps.append(step)
        }
        
        return recipe
    }
}
