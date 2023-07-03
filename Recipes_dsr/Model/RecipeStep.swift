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
    
    static func getRecipeStepObject(id: UUID, number: Int, step: String, image: String) -> RecipeStep {
        let recipeStep = RecipeStep()
        
        recipeStep.id = id
        recipeStep.number = number
        recipeStep.step = step
        recipeStep.image = image
        
        return recipeStep
    }
}
