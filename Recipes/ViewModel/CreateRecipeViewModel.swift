import Foundation

class CreateRecipeViewModel: ObservableObject {
    @Published var isAddingIngredientViewShow = false
    @Published var isListCategoryViewShow = false
    @Published var isStepFormViewShow = false
}
