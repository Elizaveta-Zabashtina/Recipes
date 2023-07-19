import SwiftUI
import RealmSwift

struct CreateRecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var recipeCategory = Category()
    @State private var numberOfServings: Int = 1
    @State private var recipeIngredients: [Ingredient] = []
    @State private var recipeSteps: [RecipeStep] = []
    @State var isPickerShow = false
    @State var recipeImage: UIImage?
    @State var showAlert = false
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var createRecipeViewModel: CreateRecipeViewModel
    @ObservedResults(Recipe.self) var recipes
    var body: some View {
        NavigationStack {
            Form {
                Section("Фотография готового блюда") {
                    VStack {
                        if let recipeImage = recipeImage {
                            Image(uiImage: recipeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(15)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                        } else {
                            ZStack {
                                Button {
                                    isPickerShow.toggle()
                                } label: {
                                    VStack {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .frame(width: 52, height: 42)
                                            .foregroundColor(Color(UIColor.darkGray))
                                        Text("Добавить фото")
                                            .fontWeight(.light)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                    } .padding(.top, 20)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                        .padding(.bottom, 20)
                                        .background(.yellow)
                                        .cornerRadius(15)
                                        .padding(20)
                                }
                            }
                        }
                    } .sheet(isPresented: $isPickerShow) {
                            ImagePicker(image: $recipeImage)
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
                        Text(recipeCategory.name)
                    }
                    NavigationLink {
                        ListCategoryView(recipeCategory: $recipeCategory)
                    } label: {
                        Text("Выбрать категорию")
                            .foregroundColor(.yellow)
                    } .frame(height: 50)
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
                        NavigationLink {
                            AddingIngredientView(recipeIngredients: $recipeIngredients)
                        } label: {
                            Text("+ Добавить ингредиент")
                                .foregroundColor(.yellow)
                        } .frame(height: 30)
                    }
                }
                Section("Как приготовить") {
                    VStack(spacing: 20) {
                        ForEach(recipeSteps, id: \.id) { step in
                            StepItem(stepItem: step) {
                                recipeSteps.remove(at: step.number - 1)
                            }
                            Divider()
                        }
                        NavigationLink {
                            StepFormView(recipeSteps: $recipeSteps)
                        } label: {
                            Text("+ Добавить шаг")
                                .foregroundColor(.yellow)
                        } .frame(height: 30)
                    }
                }
                Spacer(minLength: 20)
                Button {
                    if recipeName.count == 0, recipeDescription.count == 0, recipeSteps.count == 0, recipeIngredients.count == 0  {
                        showAlert.toggle()
                    } else {
                        let newRecipe = Recipe()
                        let path = "images/recipes/\(newRecipe.id).jpg"
                        guard (recipeImage?.save(at: .documentDirectory,
                                                 pathAndImageName: path)) != nil else { return }
                        let todayDate = Date()
                        newRecipe.created = todayDate
                        newRecipe.name = recipeName
                        newRecipe.recipeDescription = recipeDescription
                        newRecipe.image = path
                        newRecipe.category = recipeCategory
                        newRecipe.numberOfServings = numberOfServings
                        newRecipe.steps.append(objectsIn: recipeSteps)
                        newRecipe.ingredients.append(objectsIn: recipeIngredients)
                        $recipes.append(newRecipe)
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
}
