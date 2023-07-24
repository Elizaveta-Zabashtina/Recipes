import Foundation
import SwiftUI

class CreateRecipeViewModel: ObservableObject {
    @Published var recipeName: String = ""
    @Published var recipeDescription: String = ""
    @Published var recipeCategory = Category()
    @Published var numberOfServings: Int = 1
    @Published var recipeIngredients: [Ingredient] = []
    @Published var recipeSteps: [RecipeStep] = []
    @Published var isPickerShow = false
    @Published var recipeImage: UIImage?
    @Published var stepImages: [UIImage]?
    @Published var showAlert = false
}
