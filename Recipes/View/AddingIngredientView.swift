import SwiftUI

struct AddingIngredientView: View {
    @State private var recipeIngredient = Ingredient()
    @Binding var recipeIngredients: [Ingredient]
    @EnvironmentObject var addingIngredientViewModel: AddingIngredientViewModel
    @State var showAlert = false
    var body: some View {
        Form {
            Section("Добавить ингредиент") {
                Row {
                    TextField("Например: Курица", text: $recipeIngredient.name)
                }
                Row {
                    TextField("Например: 1 шт. или 2 кг.", text: $recipeIngredient.measure)
                }
            }
            Spacer(minLength: 30)
            Button {
                if recipeIngredient.name.count == 0, recipeIngredient.measure.count == 0 {
                    showAlert.toggle()
                } else {
                    addingIngredientViewModel.saveIngredientButton.toggle()
                    recipeIngredients.append(recipeIngredient)
                }
            } label: {
                Text("Добавить ингредиент")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            } .frame(maxWidth: 300, alignment: .leading).cornerRadius(15)
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
                .background(.yellow)
                .cornerRadius(15)
                .alert(Text("Пустые поля!"), isPresented: $showAlert, actions: {})
        }
    }
}
