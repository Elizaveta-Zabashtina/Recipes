import SwiftUI
import Foundation

struct RecipeInformationView: View {
    @State private var recipe = Recipe()
    private let dateFormatter = DateFormatter()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "camera")
                    .resizable()
                    .frame(width: 350, height: 250)
                Spacer()
                Text(dateFormatter.string(from: recipe.created))
                    .font(.footnote)
                    .fontWeight(.thin)
                    .textCase(.uppercase)
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(recipe.description)                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                VStack {
                    Text("Категория: \(recipe.category)")
                    Text("Количество порций: \(recipe.numberOfServings)")
                } .frame(width: 350, height: 70)
                    .background(.yellow)
                    .cornerRadius(15)
                Text("Список ингредиентов")
                    .font(.title3)
                    .fontWeight(.bold)
                ForEach(recipe.ingredients) { ingredient in
                    VStack(alignment: .leading) {
                        Text("\(ingredient.name), \(ingredient.measure)")
                        Divider()
                    }
                    .lineLimit(1)
                }
                Text("Пошаговый рецепт")
                    .font(.title3)
                    .fontWeight(.bold)
                VStack(spacing: 15) {
                    ForEach(recipe.steps, id: \.id) { step in
                        StepCardItem(step: step)
                        Divider()
                    }
                }
            }
        }
    }
}
struct StepCardItem: View {
    var step: RecipeStep
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Шаг \(step.number)")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: 60, alignment: .leading).cornerRadius(15)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                    .background(.yellow)
                    .cornerRadius(15)
                Image("stepImage")
                    .resizable()
                    .frame(width: 350, height: 250)
                    .cornerRadius(15)
                Text(step.step)
                    .frame(width: 350)
            }
    }
}
struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView()
    }
}
