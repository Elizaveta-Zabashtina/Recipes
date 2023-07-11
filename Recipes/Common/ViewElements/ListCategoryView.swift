import SwiftUI
import RealmSwift

struct ListCategoryView: View {
    @State var text = ""
    @ObservedResults(Category.self) var categories
    @EnvironmentObject var createRecipeViewModel: CreateRecipeViewModel
    @Binding var recipeCategory: String
    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    Button {
                        self.recipeCategory = category.name
                        createRecipeViewModel.isListCategoryViewShow.toggle()
                    } label: {
                        Text(category.name)
                            .foregroundColor(.yellow)
                    }
                }
            } .navigationTitle("Категории")
        }
    }
}
struct ListCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ListCategoryView(recipeCategory: .constant("Десерты"))
    }
}
