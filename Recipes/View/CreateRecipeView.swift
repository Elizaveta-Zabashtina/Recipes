import SwiftUI

struct CreateRecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var recipeCategory = ""
    @State private var numberOfServings: Int = 1
    @State private var stepNumber: Int = 1
    @State var isPickerShow = false
    @State var recipeImage = UIImage(systemName: "camera")!
    @State var addedStep = false
    
    @StateObject private var createRecipeViewModel = CreateRecipeViewModel()

    var body: some View {
        Form {
            Section("Фотография готового блюда") {
                ZStack {
                Button {
                    isPickerShow.toggle()
                } label: {
                    VStack(spacing: 10) {
                        Image(uiImage: recipeImage)
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
                    NavigationLink(destination: CategoriesView(), label: {
                        Text("Например: Суп или десерт")
                    })
                }
            }
            Section("Порции") {
                HStack(spacing: 15) {
                    Button {
                        numberOfServings.self -= 1
                    } label: {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.yellow)
                    }
                    Text("\(numberOfServings)")
                    Button {
                        numberOfServings.self += 1
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.yellow)
                    }
                }
            }
            Section("Ингредиенты") {
                Spacer(minLength: 20)
                    NavigationLink(destination: AddingIngredientView(), label: {
                        Text("+ Добавить ингредиент")
                            .foregroundColor(.yellow)
                    })
            }
            Section("Как приготовить") {
                StepFormView(stepNumber: $stepNumber)
                Spacer(minLength: 20)
                Button {
                    addedStep.toggle()
                    stepNumber.self += 1
                } label: {
                    Text("+ Добавить шаг")
                        .foregroundColor(.yellow)
                } .sheet(isPresented: $addedStep) {
                    StepFormView(stepNumber: $stepNumber)
                }
            
            }
            Spacer(minLength: 20)
            Button {
                submitInformation()
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
        }
    }
    private func submitInformation() {
        let recipeData = RecipeData(name: recipeName, recipeDescription: recipeDescription, image: recipeImage, numberOdServings: numberOfServings)
        createRecipeViewModel.addRecipe()
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
