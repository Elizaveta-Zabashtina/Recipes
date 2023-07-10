import SwiftUI
import RealmSwift

struct CreateRecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var recipeCategory: String = ""
    @State private var numberOfServings: Int = 1
    @State private var stepNumber: Int = 1
    @State private var recipeIngredient = Ingredient()
    @State private var recipeIngredients: [Ingredient] = []
    @State var isPickerShow = false
    @State var isListCategoryViewShow = false
    @State var isAddingIngredientViewShow = false
    @State var recipeImage = UIImage(systemName: "camera")!
    @State var addedStep = false
    @State var showAlert = false
    @State private var list: [String] = [""]
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var addingIngredientViewModel: AddingIngredientViewModel
    @ObservedResults(Recipe.self) var recipes
    @ObservedResults(RecipeStep.self) var recipeSteps
    var body: some View {
        Form {
            Section("Фотография готового блюда") {
                ZStack {
                Button {
                    isPickerShow.toggle()
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 52, height: 42)
                            .foregroundColor(Color(UIColor.darkGray))
                        Text("Добавить фото")
                            .fontWeight(.light)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                .background(.yellow)
                .cornerRadius(15)
                .padding(20)
                .sheet(isPresented: $isPickerShow) {
                    ImagePicker(image: $recipeImage)
                }
                }
            }
            Section("Название рецепта") {
                Row {
                    TextField("Например: Торт Наполеон", text: $recipeName)
                }
            }
            Section("Описание рецепта") {
                Row {
                    TextField("Расскажите, каким будет готовое блюдо?", text: $recipeDescription)
                }
            }
            Section("Категория") {
                Row {
                    TextField("Например: Десерты", text: $recipeCategory)
                }
                Button {
                    isListCategoryViewShow.toggle()
                } label: {
                    Text("Выбрать категорию")
                        .foregroundColor(.yellow)
                } .frame(height: 50)
                .sheet(isPresented: $isListCategoryViewShow) {
                    ListCategoryView(recipeCategory: $recipeCategory)
                }
            }
            Section("Порции") {
                HStack(spacing: 15) {
                    Button {
                        if numberOfServings > 1 {
                            numberOfServings.self -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.yellow)
                    }
                    Text("\(numberOfServings)")
                    Button {
                        if numberOfServings < 25 {
                            numberOfServings.self += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.yellow)
                    }
                }
            }
            Section("Ингредиенты") {
                VStack(spacing: 20) {
                    ForEach(recipeIngredients) { ingredient in
                        VStack(alignment: .leading) {
                            Row {
                                Text("\(ingredient.name), \(ingredient.measure) ")
                            }
                        }
                        .lineLimit(1)
                    }
                    Button {
                        if addingIngredientViewModel.saveIngredientButton {
                            recipeIngredients.append(recipeIngredient)
                            addingIngredientViewModel.saveIngredientButton.toggle()
                        }
                        isAddingIngredientViewShow.toggle()
                    } label: {
                        Text("+ Добавить ингредиент")
                            .foregroundColor(.yellow)
                    } .frame(height: 30)
                        .sheet(isPresented: $isAddingIngredientViewShow) {
                            AddingIngredientView(recipeIngredient: $recipeIngredient)
                        }
                }
            }
            Section("Как приготовить") {
                VStack(spacing: 20) {
                    NavigationView {
                        List(list, id: \.self) { _ in
                            StepFormView(stepNumber: stepNumber)
                        }
                    }
                    Button {
                        self.list.append("kdkdkdk")
                        stepNumber.self += 1
                    } label: {
                        Text("+ Добавить шаг")
                            .foregroundColor(.yellow)
                    }
                }
            }
            Spacer(minLength: 20)
            Button {
                if recipeName.count == 0, recipeDescription.count == 0 {
                    showAlert.toggle()
                } else {
                    let newRecipe = Recipe()
                    newRecipe.name = recipeName
                    newRecipe.recipeDescription = recipeDescription
                    newRecipe.category.name = recipeCategory
                    newRecipe.numberOfServings = numberOfServings
                    $recipes.append(newRecipe)
                    withAnimation {
                        listViewModel.isShowCreateView.toggle()
                    }
                }
            } label: {
                Text("Сохранить рецепт")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            } .frame(maxWidth: 300, alignment: .leading).cornerRadius(15)
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
                .background(.yellow)
                .cornerRadius(15)
        } .alert(Text("Пустые поля!"), isPresented: $showAlert, actions: {})
    }
}
struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
