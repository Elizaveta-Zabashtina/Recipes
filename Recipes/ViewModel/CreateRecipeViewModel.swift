import Foundation
import SwiftUI

struct RecipeData {
    let name: String
    let recipeDescription: String
    let image: UIImage
    let numberOdServings: Int
}

@MainActor class CreateRecipeViewModel: ObservableObject {
    var idAddedRecipe: Bool {
        return RealmManager.shared.isAddedObject(objectOfRecipe)
    }
    private var objectOfRecipe: Recipe!
    func receive(_ recipe: Any) {
            if let recipe = recipe as? Recipe {
                objectOfRecipe = recipe
            }
        }
    func addRecipe() {
        RealmManager.shared.add([objectOfRecipe])
    }
    func deleteRecipe() {
        RealmManager.shared.delete([objectOfRecipe])
    }
}
