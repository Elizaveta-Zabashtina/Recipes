import SwiftUI

struct CreateRecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var recipeCategory = ""
    @State private var numberOfServings: Int = 1
    @State private var stepNumber: Int = 1

    var body: some View {
        Form {
            Section("Фотография готового блюда") {
                Button {
                    //
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
                    stepNumber.self += 1
                } label: {
                    Text("+ Добавить шаг")
                        .foregroundColor(.yellow)
                }
            }
            Spacer(minLength: 20)
            Button {
                //
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
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
