import SwiftUI
import RealmSwift

struct CreateRecipeView: View {
    @EnvironmentObject var createRecipeViewModel: CreateRecipeViewModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(Recipe.self) var recipes
    var body: some View {
        NavigationStack {
            Form {
                Section("Фотография готового блюда") {
                    VStack {
                        if let recipeImage = createRecipeViewModel.recipeImage {
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
                                    createRecipeViewModel.isPickerShow.toggle()
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
                    } .sheet(isPresented: $createRecipeViewModel.isPickerShow) {
                        ImagePicker(image: $createRecipeViewModel.recipeImage)
                    }
                }
                Section("Название рецепта") {
                    Row {
                        TextField("Например: Торт Наполеон", text: $createRecipeViewModel.recipeName)
                    }
                }
                Section("Описание рецепта") {
                    Row {
                        TextField("Расскажите, каким будет готовое блюдо?",
                                  text: $createRecipeViewModel.recipeDescription)
                    }
                }
                Section("Категория") {
                    Row {
                        Text(createRecipeViewModel.recipeCategory.name)
                    }
                    NavigationLink {
                        ListCategoryView(recipeCategory: $createRecipeViewModel.recipeCategory)
                    } label: {
                        Text("Выбрать категорию")
                            .foregroundColor(.yellow)
                    } .frame(height: 50)
                }
                Section("Порции") {
                    HStack(spacing: 15) {
                        Button {
                            if createRecipeViewModel.numberOfServings > 1 {
                                createRecipeViewModel.numberOfServings.self -= 1
                            }
                        } label: {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .foregroundColor(.yellow)
                        }
                        Text("\(createRecipeViewModel.numberOfServings)")
                        Button {
                            if createRecipeViewModel.numberOfServings < 25 {
                                createRecipeViewModel.numberOfServings.self += 1
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
                        ForEach(createRecipeViewModel.recipeIngredients) { ingredient in
                            VStack(alignment: .leading) {
                                Row {
                                    Text("\(ingredient.name), \(ingredient.measure) ")
                                }
                            }
                            .lineLimit(1)
                        }
                        NavigationLink {
                            AddingIngredientView(recipeIngredients: $createRecipeViewModel.recipeIngredients)
                        } label: {
                            Text("+ Добавить ингредиент")
                                .foregroundColor(.yellow)
                        } .frame(height: 30)
                    }
                }
                Section("Как приготовить") {
                    VStack(spacing: 20) {
                        ForEach(createRecipeViewModel.recipeSteps, id: \.id) { step in
                            StepItem(stepItem: step) {
                                createRecipeViewModel.recipeSteps.remove(at: step.number - 1)
                            }
                            Divider()
                        }
                        NavigationLink {
                            StepFormView(recipeSteps: $createRecipeViewModel.recipeSteps)
                        } label: {
                            Text("+ Добавить шаг")
                                .foregroundColor(.yellow)
                        } .frame(height: 30)
                    }
                }
                Spacer(minLength: 20)
                Button {
                    if fieldsValidation() {
                        addNewRecipe()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        createRecipeViewModel.showAlert.toggle()
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
            } .alert(Text("Пустые поля!"), isPresented: $createRecipeViewModel.showAlert, actions: {})
        }
    }
    func addNewRecipe() {
        let newRecipe = Recipe()
        let path = "images/recipes/\(newRecipe.id).jpg"
        guard (createRecipeViewModel.recipeImage?.save(at: .documentDirectory,
                                 pathAndImageName: path)) != nil else { return }
        let todayDate = Date()
        newRecipe.created = todayDate
        newRecipe.name = createRecipeViewModel.recipeName
        newRecipe.recipeDescription = createRecipeViewModel.recipeDescription
        newRecipe.image = path
        newRecipe.category = createRecipeViewModel.recipeCategory.thaw()
        newRecipe.numberOfServings = createRecipeViewModel.numberOfServings
        newRecipe.steps.append(objectsIn: createRecipeViewModel.recipeSteps)
        newRecipe.ingredients.append(objectsIn: createRecipeViewModel.recipeIngredients)
        $recipes.append(newRecipe)
    }
    func fieldsValidation() -> Bool {
        var result = true
        if createRecipeViewModel.recipeName.count == 0 ||
            createRecipeViewModel.recipeDescription.count == 0 ||
            createRecipeViewModel.recipeIngredients.count == 0 ||
            createRecipeViewModel.recipeSteps.count == 0 ||
            createRecipeViewModel.recipeImage == nil ||
            createRecipeViewModel.recipeCategory.name == "" {
            result = false
        }
        return result
    }
}
